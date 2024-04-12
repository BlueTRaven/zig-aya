const std = @import("std");
const aya = @import("aya.zig");
const zmesh = aya.zmesh;
const zm = aya.zm;
const wgpu = aya.wgpu;

// https://www.slideshare.net/Khronos_Group/gltf-20-reference-guide
// https://toji.dev/webgpu-gltf-case-study/#track-your-render-data-carefully
const cgltf = zmesh.io.zcgltf;

pub const GltfVertex = struct {
    position: [3]f32,
    normal: [3]f32,
    tangent: [4]f32, // temporarily removed
    texcoords0: [2]f32,
};

pub const GltfRoot = struct {
    meshes: []GltfMeshRoot,
    textures: []GltfTexture,

    scenes: []GltfScene,
    nodes: []GltfNode,

    pub fn deinit(self: *GltfRoot) void {
        for (self.meshes) |*m| m.deinit();
        for (self.nodes) |n| aya.mem.free(n.name);
        aya.mem.free(self.textures);
        aya.mem.free(self.meshes);

        aya.mem.free(self.scenes);
        aya.mem.free(self.nodes);
    }
};

pub const GltfBoundingBox = struct {
    min: [3]f32 = [_]f32{0} ** 3,
    max: [3]f32 = [_]f32{0} ** 3,
};
/// each GltfMeshRoot can contain multiple submeshes ("primitives" in GLTF terminology)
pub const GltfMeshRoot = struct {
    //NOTE: This bounding box is defined in mesh-space! Transform it via the owning node's transform for a world-space bounding box.
    bounding_box: GltfBoundingBox,
    meshes: []GltfMesh,

    pub fn deinit(self: *GltfMeshRoot) void {
        for (self.meshes) |m| {
            if (m.material) |mat| {
                aya.mem.allocator.free(mat.name);
            }
        }
        aya.mem.free(self.meshes);
    }
};

/// buffer details required for drawing the mesh with drawIndexed. Maps to a GLTF Primitive
pub const GltfMesh = struct {
    vertex_offset: u32,
    index_offset: u32,
    num_indices: u32,
    material: ?GltfMaterial,
};

/// maps the textures a mesh uses to the GltfRoot.textures index
pub const GltfMaterial = struct {
    name: ?[]const u8 = null,

    // pbr_metallic_roughness
    base_color: ?usize = null,
    metallic_roughness: ?usize = null,
    base_color_factor: [4]f32 = [_]f32{1} ** 4,
    metallic_factor: f32 = 0,
    roughness_factor: f32 = 1,

    // pbr_specular_glossiness
    diffuse: ?usize = null,
    specular_glossiness: ?usize = null,

    normal: ?usize = null,
    normal_factor: f32 = 1,
    emissive: ?usize = null,
    occlusion: ?usize = null,
};

pub const GltfTexture = struct {
    texture: aya.render.TextureHandle,
    texture_view: aya.render.TextureViewHandle,
};

pub const GltfScene = struct {
    nodes: ?[]*GltfNode,
};

pub const GltfTransform = struct {
    translation: [3]f32 = [_]f32{0} ** 3,
    scale: [3]f32 = [_]f32{1} ** 3,
    rotation: [4]f32 = [_]f32{0} ** 4,

    cached_matrix: zm.Mat,

    pub fn get_matrix(self: GltfTransform) zm.Mat {
        var matrix: zm.Mat = zm.identity();

        matrix = zm.mul(matrix, zm.scaling(self.scale[0], self.scale[1], self.scale[2]));
        matrix = zm.mul(matrix, zm.quatToMat(self.rotation));
        matrix = zm.mul(matrix, zm.translation(self.translation[0], self.translation[1], self.translation[2]));

        return matrix;
    }
};

pub const GltfNode = struct {
    name: ?[]const u8,
    transform: GltfTransform,
    to_local: zm.Mat,
    to_world: zm.Mat,
    mesh: ?*GltfMeshRoot,

    children: ?[]*GltfNode,
    parent: ?*GltfNode,

    pub fn root(self: *const GltfNode) *const GltfNode {
        return if (self.parent) |parent| parent.root() else self;
    }
};

const MeshCache = struct {
    arena_allocator: std.heap.ArenaAllocator,
    all_meshes: std.ArrayList(GltfMesh),
    all_vertices: std.ArrayList(GltfVertex),
    all_indices: std.ArrayList(u32),

    indices: std.ArrayList(u32),
    positions: std.ArrayList([3]f32),
    normals: std.ArrayList([3]f32),
    texcoords0: std.ArrayList([2]f32),
    tangents: ?std.ArrayList([4]f32) = null,
    colors: ?std.ArrayList([4]f32) = null,

    pub fn init() MeshCache {
        const arena_allocator = std.heap.ArenaAllocator.init(aya.mem.allocator); // TODO: why do we crash using this?

        return .{
            .arena_allocator = arena_allocator,
            .all_meshes = std.ArrayList(GltfMesh).init(aya.mem.allocator), // allocated without the Arena!
            .all_vertices = std.ArrayList(GltfVertex).init(aya.mem.allocator),
            .all_indices = std.ArrayList(u32).init(aya.mem.allocator),
            .indices = std.ArrayList(u32).init(aya.mem.allocator),
            .positions = std.ArrayList([3]f32).init(aya.mem.allocator),
            .normals = std.ArrayList([3]f32).init(aya.mem.allocator),
            .texcoords0 = std.ArrayList([2]f32).init(aya.mem.allocator),
        };
    }

    pub fn deinit(self: *const MeshCache) void {
        self.all_meshes.deinit();
        self.arena_allocator.deinit();

        self.all_vertices.deinit();
        self.all_indices.deinit();

        self.indices.deinit();
        self.positions.deinit();
        self.normals.deinit();
        self.texcoords0.deinit();
        if (self.tangents) |t| t.deinit();
        if (self.colors) |c| c.deinit();
    }

    pub fn resetState(self: *MeshCache) void {
        self.indices.clearRetainingCapacity();
        self.positions.clearRetainingCapacity();
        self.normals.clearRetainingCapacity();
        self.texcoords0.clearRetainingCapacity();
        if (self.tangents) |*t| t.clearRetainingCapacity();
        if (self.colors) |*c| c.clearRetainingCapacity();
    }
};

/// manages packing multiple GLTF scenes into a single vertex/index buffer. Loads all associated
/// textures as well.
pub const GltfLoader = struct {
    texture_cache: CachedTextureMap,
    mesh_cache: MeshCache,
    gltfs: aya.utils.Vec(GltfRoot),

    pub fn init() GltfLoader {
        return .{
            .texture_cache = CachedTextureMap.init(aya.mem.allocator),
            .mesh_cache = MeshCache.init(),
            .gltfs = aya.utils.Vec(GltfRoot).init(),
        };
    }

    pub fn deinit(self: *GltfLoader) void {
        self.mesh_cache.deinit();
        for (self.gltfs.slice()) |*g| g.deinit();
        var iter = self.texture_cache.keyIterator();
        while (iter.next()) |key| {
            aya.mem.allocator.free(key);
        }
        self.texture_cache.deinit();
        self.gltfs.deinit();
    }

    pub fn appendGltf(self: *GltfLoader, path: [:0]const u8) GltfRoot {
        var gltf = GltfData.init(path);
        defer gltf.deinit();

        gltf.logCounts();

        var texture_map = TextureMap.init(aya.mem.allocator);
        defer texture_map.deinit();
        var textures = aya.mem.alloc(GltfTexture, gltf.textures.len);
        for (gltf.textures, 0..) |*tex, i| {
            textures[i] = loadTexture(path, tex.*, &self.texture_cache);

            texture_map.put(tex, i) catch unreachable;
        }

        var name_to_mesh = std.AutoHashMap(cgltf.MutCString, *GltfMeshRoot).init(aya.mem.allocator);
        defer name_to_mesh.deinit();

        var mesh_root = aya.mem.alloc(GltfMeshRoot, gltf.meshes.len);
        for (0..gltf.meshes.len) |i| {
            mesh_root[i] = gltf.loadMesh(&self.mesh_cache, &gltf.meshes[i], texture_map);

            name_to_mesh.putNoClobber(gltf.meshes[i].name.?, &mesh_root[i]) catch unreachable;
        }

        var name_to_node = std.AutoHashMap(cgltf.MutCString, *GltfNode).init(aya.mem.allocator);
        defer name_to_node.deinit();

        var nodes = aya.mem.alloc(GltfNode, gltf.nodes.len);
        for (0..gltf.nodes.len) |i| {
            const node = gltf.nodes[i];

            var transform = GltfTransform{ .cached_matrix = zm.identity() };
            const matrix = &transform.cached_matrix;
            if (node.has_scale != 0) {
                transform.scale = node.scale;
                matrix.* = zm.mul(matrix.*, zm.scaling(node.scale[0], node.scale[1], node.scale[2]));
            }
            if (node.has_rotation != 0) {
                transform.rotation = node.rotation;
                matrix.* = zm.mul(matrix.*, zm.quatToMat(node.rotation));
            }
            if (node.has_translation != 0) {
                transform.translation = node.translation;
                matrix.* = zm.mul(matrix.*, zm.translation(node.translation[0], node.translation[1], node.translation[2]));
            }

            nodes[i] = GltfNode{
                .name = if (node.name) |nname| copy_cstr(nname) else null,
                .transform = transform,
                .to_local = zm.matFromArr(node.transformLocal()),
                .to_world = zm.matFromArr(node.transformWorld()),
                .mesh = if (node.mesh) |mesh| name_to_mesh.get(mesh.name.?) else null,
                .children = null,
                .parent = null,
            };

            name_to_node.putNoClobber(gltf.nodes[i].name.?, &nodes[i]) catch unreachable;
        }

        //second loop for parent/children
        for (0..gltf.nodes.len) |i| {
            const gltf_node = gltf.nodes[i];
            var node = &nodes[i];

            if (gltf_node.children) |children| {
                const arr = aya.mem.alloc(*GltfNode, gltf_node.children_count);

                for (0..gltf_node.children_count) |j| {
                    arr[j] = name_to_node.get(children[j].name.?).?;
                }

                node.children = arr;
            }

            if (gltf_node.parent) |parent| {
                node.parent = name_to_node.get(parent.name.?);
            }
        }

        var scenes = aya.mem.alloc(GltfScene, gltf.scenes.len);
        for (0..gltf.scenes.len) |i| {
            const scene = gltf.scenes[i];

            var scene_nodes = aya.mem.alloc(*GltfNode, scene.nodes_count);
            if (scene.nodes) |gltf_nodes| {
                for (0..scene.nodes_count) |j| {
                    scene_nodes[j] = name_to_node.get(gltf_nodes[j].name.?).?;
                }
            }

            scenes[i] = GltfScene{
                .nodes = scene_nodes,
            };
        }

        const index = self.gltfs.slice().len;
        self.gltfs.append(.{
            .meshes = mesh_root,
            .textures = textures,

            .scenes = scenes,
            .nodes = nodes,
        });

        return self.gltfs.slice()[index];

        // TODO: delete all this
        // std.debug.print("loaded {} meshes\n", .{mesh_root.len});
        // for (mesh_root) |mesh| {
        //     std.debug.print("    primitives: {}\n", .{mesh.meshes.len});
        // }
    }

    pub fn generateBuffers(self: *const GltfLoader) struct { aya.render.BufferHandle, aya.render.BufferHandle } {
        return .{
            aya.gctx.createBufferInit(null, .{ .copy_dst = true, .vertex = true }, GltfVertex, self.mesh_cache.all_vertices.items),
            aya.gctx.createBufferInit(null, .{ .copy_dst = true, .index = true }, u32, self.mesh_cache.all_indices.items),
        };
    }
};

const TextureMap = std.AutoHashMap(*const cgltf.Texture, usize);

/// simplified representation of the cgltf.Data struct
pub const GltfData = struct {
    path: [:0]const u8,

    gltf: *cgltf.Data,
    meshes: []cgltf.Mesh,
    materials: []cgltf.Material,
    accessors: []cgltf.Accessor,
    buffer_views: []cgltf.BufferView,
    buffers: []cgltf.Buffer,
    images: []cgltf.Image,
    textures: []cgltf.Texture,
    samplers: []cgltf.Sampler,
    nodes: []cgltf.Node,
    scenes: []cgltf.Scene,
    scene: ?*cgltf.Scene,

    pub fn init(path: [:0]const u8) GltfData {
        const data = cgltf.parseFile(.{}, path) catch unreachable;
        errdefer cgltf.free(data);

        cgltf.loadBuffers(.{}, data, path) catch unreachable;

        return .{
            .path = path,
            .gltf = data,
            .meshes = if (data.meshes) |m| m[0..data.meshes_count] else &.{},
            .materials = if (data.materials) |m| m[0..data.materials_count] else &.{},
            .accessors = if (data.accessors) |a| a[0..data.accessors_count] else &.{},
            .buffer_views = if (data.buffer_views) |bv| bv[0..data.buffer_views_count] else &.{},
            .buffers = if (data.buffers) |b| b[0..data.buffers_count] else &.{},
            .images = if (data.images) |img| img[0..data.images_count] else &.{},
            .textures = if (data.textures) |tex| tex[0..data.textures_count] else &.{},
            .samplers = if (data.samplers) |s| s[0..data.samplers_count] else &.{},
            .nodes = if (data.nodes) |node| node[0..data.nodes_count] else &.{},
            .scenes = if (data.scenes) |scene| scene[0..data.scenes_count] else &.{},
            .scene = data.scene,
        };
    }

    pub fn deinit(self: *const GltfData) void {
        zmesh.io.freeData(self.gltf);
    }

    pub fn logCounts(self: GltfData) void {
        std.debug.print("meshes: {}\n", .{self.meshes.len});
        std.debug.print("materials: {}\n", .{self.materials.len});
        std.debug.print("accessors: {}\n", .{self.accessors.len});
        std.debug.print("buffers: {}\n", .{self.buffers.len});
        std.debug.print("images: {}\n", .{self.images.len});
        std.debug.print("textures: {}\n\n", .{self.textures.len});
    }

    /// loads the mesh at `index` and all its Primitives
    fn loadMesh(self: *const GltfData, mesh_cache: *MeshCache, mesh: *cgltf.Mesh, texture_map: TextureMap) GltfMeshRoot {
        var mesh_root = GltfMeshRoot{
            .bounding_box = .{},
            .meshes = aya.mem.alloc(GltfMesh, mesh.primitives_count),
        };

        var min = &mesh_root.bounding_box.min;
        var max = &mesh_root.bounding_box.max;

        for (mesh.primitives[0..mesh.primitives_count], 0..) |*primitive, i| {
            const pre_indices_len = mesh_cache.all_indices.items.len;
            const pre_positions_len = mesh_cache.all_vertices.items.len;

            appendMeshPrimitive(primitive, mesh_cache);

            mesh_root.meshes[i].index_offset = @as(u32, @intCast(pre_indices_len));
            mesh_root.meshes[i].num_indices = @as(u32, @intCast(mesh_cache.indices.items.len));
            mesh_root.meshes[i].vertex_offset = @as(u32, @intCast(pre_positions_len));
            mesh_root.meshes[i].material = self.loadMaterial(primitive, texture_map);

            mesh_cache.all_indices.ensureTotalCapacity(mesh_cache.all_indices.items.len + mesh_cache.indices.items.len) catch unreachable;
            for (mesh_cache.indices.items) |mesh_index| {
                mesh_cache.all_indices.appendAssumeCapacity(mesh_index);
            }

            {
                if (mesh_cache.tangents) |tangents| {
                    std.debug.assert(tangents.items.len == mesh_cache.positions.items.len);
                }
            }

            mesh_cache.all_vertices.ensureTotalCapacity(mesh_cache.all_vertices.items.len + mesh_cache.positions.items.len) catch unreachable;
            for (mesh_cache.positions.items, 0..) |_, j| {
                const position = mesh_cache.positions.items[j];
                for (0..3) |k| {
                    if (position[k] < min[k]) {
                        min[k] = position[k];
                    }
                    if (position[k] > max[k]) {
                        max[k] = position[k];
                    }
                }
                const tangent: @Vector(4, f32) = brk: {
                    if (mesh_cache.tangents) |tangents| {
                        break :brk tangents.items[j];
                    } else break :brk @splat(0);
                };

                mesh_cache.all_vertices.appendAssumeCapacity(.{
                    .position = position,
                    .normal = mesh_cache.normals.items[j],
                    .tangent = tangent,
                    .texcoords0 = mesh_cache.texcoords0.items[j],
                });
            }

            mesh_cache.resetState();
        }

        return mesh_root;
    }

    fn loadMaterial(self: *const GltfData, primitive: *cgltf.Primitive, texture_map: TextureMap) ?GltfMaterial {
        _ = self;
        const mat = primitive.material orelse return null;
        var material = GltfMaterial{};

        if (mat.name) |name| material.name = copy_cstr(name);

        const getTextureIndex = struct {
            pub fn getTextureIndex(tv: cgltf.TextureView, _texture_map: TextureMap) ?usize {
                const texture = tv.texture orelse return null;

                //std.debug.assert(tv.has_transform == 0);
                //std.debug.assert(tv.texcoord == 0);
                //std.debug.assert(tv.scale == 1);

                return _texture_map.get(texture);

                // for (data.textures, 0..) |*t, i| {
                //     if (t == texture) return i;
                // }
                // return null;
            }
        }.getTextureIndex;

        if (mat.has_pbr_metallic_roughness > 0) {
            material.base_color = getTextureIndex(mat.pbr_metallic_roughness.base_color_texture, texture_map);
            material.metallic_roughness = getTextureIndex(mat.pbr_metallic_roughness.metallic_roughness_texture, texture_map);
            material.base_color_factor = mat.pbr_metallic_roughness.base_color_factor;
            material.metallic_factor = mat.pbr_metallic_roughness.metallic_factor;
            material.roughness_factor = mat.pbr_metallic_roughness.roughness_factor;
        }

        if (mat.has_pbr_specular_glossiness > 0) {
            material.diffuse = getTextureIndex(mat.pbr_specular_glossiness.diffuse_texture, texture_map);
            material.specular_glossiness = getTextureIndex(mat.pbr_specular_glossiness.specular_glossiness_texture, texture_map);
        }
        material.normal = getTextureIndex(mat.normal_texture, texture_map);
        material.normal_factor = mat.normal_texture.scale;
        material.emissive = getTextureIndex(mat.emissive_texture, texture_map);
        material.occlusion = getTextureIndex(mat.occlusion_texture, texture_map);

        return material;
    }
};

const CachedTextureMap = std.StringHashMap(GltfTexture);

fn loadTexture(root_path: [:0]const u8, gltf_texture: zmesh.io.zcgltf.Texture, cached_textures: *CachedTextureMap) GltfTexture {
    const image = gltf_texture.image orelse unreachable;
    const uri_str: ?[]const u8 = brk: {
        if (image.uri) |uri| {
            const uri_len = std.mem.len(uri);
            break :brk uri[0..uri_len];
        } else break :brk null;
    };

    const stb_image, const x, const y = brk: {
        if (image.buffer_view) |buffer_view| {
            const data = buffer_view.buffer.data orelse unreachable;

            var x: c_int = undefined;
            var y: c_int = undefined;
            const buffer_bytes = @as([*]const u8, @ptrCast(data))[buffer_view.offset .. buffer_view.offset + buffer_view.size];
            break :brk .{ aya.stb.stbi_load_from_memory(buffer_bytes.ptr, @intCast(buffer_bytes.len), &x, &y, null, 4), x, y };
        } else {
            //if we load from a file, we need to ensure that we're not loading a file that's already been loaded.
            if (cached_textures.get(uri_str.?)) |cached_tex| {
                return cached_tex;
            }
            const unescaped = std.Uri.unescapeString(aya.mem.allocator, uri_str.?) catch unreachable;
            defer aya.mem.allocator.free(unescaped);

            const path = std.fs.path.dirname(root_path).?;
            const dir = std.fs.cwd().openDir(path, .{}) catch unreachable;

            const f = dir.openFile(unescaped, .{ .mode = .read_only }) catch unreachable;
            defer f.close();

            const stat = f.stat() catch unreachable;
            const data = f.readToEndAlloc(aya.mem.allocator, stat.size) catch unreachable;
            //TODO: LEAK!!

            var x: c_int = undefined;
            var y: c_int = undefined;
            break :brk .{ aya.stb.stbi_load_from_memory(data.ptr, @intCast(data.len), &x, &y, null, 4), x, y };
        }
    };
    defer aya.stb.stbi_image_free(stb_image);

    const texture = aya.gctx.createTexture(@intCast(x), @intCast(y), .rgba8_unorm);
    const image_data = stb_image[0..@as(usize, @intCast(x * y * 4))];
    aya.gctx.writeTexture(texture, 4, u8, image_data);

    const gltf_tex = GltfTexture{
        .texture = texture,
        .texture_view = aya.gctx.createTextureView(texture, &.{}),
    };

    if (image.buffer_view == null) {
        if (uri_str) |str| {
            std.log.debug("cached texture {d}: {s}", .{ cached_textures.count(), str });
            const putstr = aya.mem.allocator.dupe(u8, str) catch unreachable;
            cached_textures.put(putstr, gltf_tex) catch unreachable;
        }
    }
    return gltf_tex;
}

fn appendMeshPrimitive(prim: *cgltf.Primitive, mesh_cache: *MeshCache) void {
    const num_vertices: u32 = @as(u32, @intCast(prim.attributes[0].data.count));
    const num_indices: u32 = @as(u32, @intCast(prim.indices.?.count));

    // Indices.
    {
        mesh_cache.indices.ensureTotalCapacity(mesh_cache.indices.items.len + num_indices) catch unreachable;

        const accessor = prim.indices.?;
        const buffer_view = accessor.buffer_view.?;

        std.debug.assert(accessor.stride == buffer_view.stride or buffer_view.stride == 0);
        std.debug.assert(accessor.stride * accessor.count == buffer_view.size);
        std.debug.assert(buffer_view.buffer.data != null);

        const data_addr = @as([*]const u8, @ptrCast(buffer_view.buffer.data)) +
            accessor.offset + buffer_view.offset;

        if (accessor.stride == 1) {
            std.debug.assert(accessor.component_type == .r_8u);
            const src = @as([*]const u8, @ptrCast(data_addr));
            var i: u32 = 0;
            while (i < num_indices) : (i += 1) {
                mesh_cache.indices.appendAssumeCapacity(src[i]);
            }
        } else if (accessor.stride == 2) {
            std.debug.assert(accessor.component_type == .r_16u);
            const src = @as([*]const u16, @ptrCast(@alignCast(data_addr)));
            var i: u32 = 0;
            while (i < num_indices) : (i += 1) {
                mesh_cache.indices.appendAssumeCapacity(src[i]);
            }
        } else if (accessor.stride == 4) {
            std.debug.assert(accessor.component_type == .r_32u);
            const src = @as([*]const u32, @ptrCast(@alignCast(data_addr)));
            var i: u32 = 0;
            while (i < num_indices) : (i += 1) {
                mesh_cache.indices.appendAssumeCapacity(src[i]);
            }
        } else {
            unreachable;
        }
    }

    // Attributes.
    {
        const attributes = prim.attributes[0..prim.attributes_count];
        for (attributes) |attrib| {
            const accessor = attrib.data;
            std.debug.assert(accessor.component_type == .r_32f);

            const buffer_view = accessor.buffer_view.?;
            std.debug.assert(buffer_view.buffer.data != null);

            std.debug.assert(accessor.stride == buffer_view.stride or buffer_view.stride == 0);
            std.debug.assert(accessor.stride * accessor.count == buffer_view.size);

            const data_addr = @as([*]const u8, @ptrCast(buffer_view.buffer.data)) +
                accessor.offset + buffer_view.offset;

            if (attrib.type == .position) {
                std.debug.assert(accessor.type == .vec3);
                const slice = @as([*]const [3]f32, @ptrCast(@alignCast(data_addr)))[0..num_vertices];
                mesh_cache.positions.appendSlice(slice) catch unreachable;
            } else if (attrib.type == .color) {
                if (mesh_cache.colors) |*col| {
                    std.debug.assert(accessor.type == .vec4);
                    const slice = @as([*]const [4]f32, @ptrCast(@alignCast(data_addr)))[0..num_vertices];
                    col.appendSlice(slice) catch unreachable;
                }
            } else if (attrib.type == .normal) {
                std.debug.assert(accessor.type == .vec3);
                const slice = @as([*]const [3]f32, @ptrCast(@alignCast(data_addr)))[0..num_vertices];
                mesh_cache.normals.appendSlice(slice) catch unreachable;
            } else if (attrib.type == .texcoord) {
                std.debug.assert(accessor.type == .vec2);
                const slice = @as([*]const [2]f32, @ptrCast(@alignCast(data_addr)))[0..num_vertices];
                mesh_cache.texcoords0.appendSlice(slice) catch unreachable;
            } else if (attrib.type == .tangent) {
                if (mesh_cache.tangents == null) mesh_cache.tangents = std.ArrayList([4]f32).init(aya.mem.allocator);

                std.debug.assert(accessor.type == .vec4);
                const slice = @as([*]const [4]f32, @ptrCast(@alignCast(data_addr)))[0..num_vertices];
                mesh_cache.tangents.?.appendSlice(slice) catch unreachable;
            }
        }
    }
}

fn copy_cstr(str: cgltf.MutCString) []const u8 {
    const len = std.mem.len(str);
    const new_str = aya.mem.allocator.alloc(u8, len) catch unreachable;
    @memcpy(new_str, str[0..len]);

    return new_str;
}
