pub extern fn SDL_GetPlatform() [*c]const u8;
pub const FILE = *c_void;

pub const SDL_FALSE = @enumToInt(SDL_bool.SDL_FALSE);
pub const SDL_TRUE = @enumToInt(SDL_bool.SDL_TRUE);
pub const SDL_bool = extern enum(c_int) {
    SDL_FALSE = 0,
    SDL_TRUE = 1,
};

pub const Sint8 = i8;
pub const Uint8 = u8;
pub const Sint16 = i16;
pub const Uint16 = u16;
pub const Uint32 = u32;
pub const Sint64 = i64;
pub const Uint64 = u64;

pub const RW_SEEK_SET: c_int = 0;   // Seek from the beginning of data
pub const RW_SEEK_CUR: c_int = 1;   // Seek relative to current read point
pub const RW_SEEK_END: c_int = 2;   // Seek relative to the end of data

pub extern fn SDL_malloc(size: usize) ?*c_void;
pub extern fn SDL_calloc(nmemb: usize, size: usize) ?*c_void;
pub extern fn SDL_realloc(mem: ?*c_void, size: usize) ?*c_void;
pub extern fn SDL_free(mem: ?*c_void) void;
pub const SDL_malloc_func = ?fn (usize) callconv(.C) ?*c_void;
pub const SDL_calloc_func = ?fn (usize, usize) callconv(.C) ?*c_void;
pub const SDL_realloc_func = ?fn (?*c_void, usize) callconv(.C) ?*c_void;
pub const SDL_free_func = ?fn (?*c_void) callconv(.C) void;
pub extern fn SDL_GetMemoryFunctions(malloc_func: [*c]SDL_malloc_func, calloc_func: [*c]SDL_calloc_func, realloc_func: [*c]SDL_realloc_func, free_func: [*c]SDL_free_func) void;
pub extern fn SDL_SetMemoryFunctions(malloc_func: SDL_malloc_func, calloc_func: SDL_calloc_func, realloc_func: SDL_realloc_func, free_func: SDL_free_func) c_int;
pub extern fn SDL_GetNumAllocations() c_int;
pub extern fn SDL_getenv(name: [*c]const u8) [*c]u8;
pub extern fn SDL_setenv(name: [*c]const u8, value: [*c]const u8, overwrite: c_int) c_int;
pub extern fn SDL_qsort(base: ?*c_void, nmemb: usize, size: usize, compare: ?fn (?*const c_void, ?*const c_void) callconv(.C) c_int) void;
pub extern fn SDL_abs(x: c_int) c_int;
pub extern fn SDL_isdigit(x: c_int) c_int;
pub extern fn SDL_isspace(x: c_int) c_int;
pub extern fn SDL_isupper(x: c_int) c_int;
pub extern fn SDL_islower(x: c_int) c_int;
pub extern fn SDL_toupper(x: c_int) c_int;
pub extern fn SDL_tolower(x: c_int) c_int;
pub extern fn SDL_memset(dst: ?*c_void, c: c_int, len: usize) ?*c_void;
pub extern fn SDL_memcpy(dst: ?*c_void, src: ?*const c_void, len: usize) ?*c_void;
pub extern fn SDL_memmove(dst: ?*c_void, src: ?*const c_void, len: usize) ?*c_void;
pub extern fn SDL_memcmp(s1: ?*const c_void, s2: ?*const c_void, len: usize) c_int;
pub extern fn SDL_wcslen(wstr: [*c]const wchar_t) usize;
pub extern fn SDL_wcslcpy(dst: [*c]wchar_t, src: [*c]const wchar_t, maxlen: usize) usize;
pub extern fn SDL_wcslcat(dst: [*c]wchar_t, src: [*c]const wchar_t, maxlen: usize) usize;
pub extern fn SDL_wcsdup(wstr: [*c]const wchar_t) [*c]wchar_t;
pub extern fn SDL_wcsstr(haystack: [*c]const wchar_t, needle: [*c]const wchar_t) [*c]wchar_t;
pub extern fn SDL_wcscmp(str1: [*c]const wchar_t, str2: [*c]const wchar_t) c_int;
pub extern fn SDL_wcsncmp(str1: [*c]const wchar_t, str2: [*c]const wchar_t, maxlen: usize) c_int;
pub extern fn SDL_strlen(str: [*c]const u8) usize;
pub extern fn SDL_strlcpy(dst: [*c]u8, src: [*c]const u8, maxlen: usize) usize;
pub extern fn SDL_utf8strlcpy(dst: [*c]u8, src: [*c]const u8, dst_bytes: usize) usize;
pub extern fn SDL_strlcat(dst: [*c]u8, src: [*c]const u8, maxlen: usize) usize;
pub extern fn SDL_strdup(str: [*c]const u8) [*c]u8;
pub extern fn SDL_strrev(str: [*c]u8) [*c]u8;
pub extern fn SDL_strupr(str: [*c]u8) [*c]u8;
pub extern fn SDL_strlwr(str: [*c]u8) [*c]u8;
pub extern fn SDL_strchr(str: [*c]const u8, c: c_int) [*c]u8;
pub extern fn SDL_strrchr(str: [*c]const u8, c: c_int) [*c]u8;
pub extern fn SDL_strstr(haystack: [*c]const u8, needle: [*c]const u8) [*c]u8;
pub extern fn SDL_strtokr(s1: [*c]u8, s2: [*c]const u8, saveptr: [*c][*c]u8) [*c]u8;
pub extern fn SDL_utf8strlen(str: [*c]const u8) usize;
pub extern fn SDL_itoa(value: c_int, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_uitoa(value: c_uint, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_ltoa(value: c_long, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_ultoa(value: c_ulong, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_lltoa(value: Sint64, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_ulltoa(value: Uint64, str: [*c]u8, radix: c_int) [*c]u8;
pub extern fn SDL_atoi(str: [*c]const u8) c_int;
pub extern fn SDL_atof(str: [*c]const u8) f64;
pub extern fn SDL_strtol(str: [*c]const u8, endp: [*c][*c]u8, base: c_int) c_long;
pub extern fn SDL_strtoul(str: [*c]const u8, endp: [*c][*c]u8, base: c_int) c_ulong;
pub extern fn SDL_strtoll(str: [*c]const u8, endp: [*c][*c]u8, base: c_int) Sint64;
pub extern fn SDL_strtoull(str: [*c]const u8, endp: [*c][*c]u8, base: c_int) Uint64;
pub extern fn SDL_strtod(str: [*c]const u8, endp: [*c][*c]u8) f64;
pub extern fn SDL_strcmp(str1: [*c]const u8, str2: [*c]const u8) c_int;
pub extern fn SDL_strncmp(str1: [*c]const u8, str2: [*c]const u8, maxlen: usize) c_int;
pub extern fn SDL_strcasecmp(str1: [*c]const u8, str2: [*c]const u8) c_int;
pub extern fn SDL_strncasecmp(str1: [*c]const u8, str2: [*c]const u8, len: usize) c_int;
pub extern fn SDL_sscanf(text: [*c]const u8, fmt: [*c]const u8, ...) c_int;
pub extern fn SDL_vsscanf(text: [*c]const u8, fmt: [*c]const u8, ap: [*c]struct___va_list_tag) c_int;
pub extern fn SDL_snprintf(text: [*c]u8, maxlen: usize, fmt: [*c]const u8, ...) c_int;
pub extern fn SDL_vsnprintf(text: [*c]u8, maxlen: usize, fmt: [*c]const u8, ap: [*c]struct___va_list_tag) c_int;
pub extern fn SDL_acos(x: f64) f64;
pub extern fn SDL_acosf(x: f32) f32;
pub extern fn SDL_asin(x: f64) f64;
pub extern fn SDL_asinf(x: f32) f32;
pub extern fn SDL_atan(x: f64) f64;
pub extern fn SDL_atanf(x: f32) f32;
pub extern fn SDL_atan2(x: f64, y: f64) f64;
pub extern fn SDL_atan2f(x: f32, y: f32) f32;
pub extern fn SDL_ceil(x: f64) f64;
pub extern fn SDL_ceilf(x: f32) f32;
pub extern fn SDL_copysign(x: f64, y: f64) f64;
pub extern fn SDL_copysignf(x: f32, y: f32) f32;
pub extern fn SDL_cos(x: f64) f64;
pub extern fn SDL_cosf(x: f32) f32;
pub extern fn SDL_exp(x: f64) f64;
pub extern fn SDL_expf(x: f32) f32;
pub extern fn SDL_fabs(x: f64) f64;
pub extern fn SDL_fabsf(x: f32) f32;
pub extern fn SDL_floor(x: f64) f64;
pub extern fn SDL_floorf(x: f32) f32;
pub extern fn SDL_fmod(x: f64, y: f64) f64;
pub extern fn SDL_fmodf(x: f32, y: f32) f32;
pub extern fn SDL_log(x: f64) f64;
pub extern fn SDL_logf(x: f32) f32;
pub extern fn SDL_log10(x: f64) f64;
pub extern fn SDL_log10f(x: f32) f32;
pub extern fn SDL_pow(x: f64, y: f64) f64;
pub extern fn SDL_powf(x: f32, y: f32) f32;
pub extern fn SDL_scalbn(x: f64, n: c_int) f64;
pub extern fn SDL_scalbnf(x: f32, n: c_int) f32;
pub extern fn SDL_sin(x: f64) f64;
pub extern fn SDL_sinf(x: f32) f32;
pub extern fn SDL_sqrt(x: f64) f64;
pub extern fn SDL_sqrtf(x: f32) f32;
pub extern fn SDL_tan(x: f64) f64;
pub extern fn SDL_tanf(x: f32) f32;
pub const struct__SDL_iconv_t = @Type(.Opaque);
pub const SDL_iconv_t = ?*struct__SDL_iconv_t;
pub extern fn SDL_iconv_open(tocode: [*c]const u8, fromcode: [*c]const u8) SDL_iconv_t;
pub extern fn SDL_iconv_close(cd: SDL_iconv_t) c_int;
pub extern fn SDL_iconv(cd: SDL_iconv_t, inbuf: [*c][*c]const u8, inbytesleft: [*c]usize, outbuf: [*c][*c]u8, outbytesleft: [*c]usize) usize;
pub extern fn SDL_iconv_string(tocode: [*c]const u8, fromcode: [*c]const u8, inbuf: [*c]const u8, inbytesleft: usize) [*c]u8;
pub const SDL_main_func = ?fn (c_int, [*c][*c]u8) callconv(.C) c_int;
pub extern fn SDL_main(argc: c_int, argv: [*c][*c]u8) c_int;
pub extern fn SDL_SetMainReady() void;

pub const SDL_AssertState = extern enum(c_int) {
    SDL_ASSERTION_RETRY,
    SDL_ASSERTION_BREAK,
    SDL_ASSERTION_ABORT,
    SDL_ASSERTION_IGNORE,
    SDL_ASSERTION_ALWAYS_IGNORE,
};

pub const SDL_AssertData = extern struct {
    always_ignore: c_int,
    trigger_count: c_uint,
    condition: [*c]const u8,
    filename: [*c]const u8,
    linenum: c_int,
    function: [*c]const u8,
    next: [*c]const SDL_AssertData,
};

pub extern fn SDL_ReportAssertion([*c]SDL_AssertData, [*c]const u8, [*c]const u8, c_int) SDL_AssertState;
pub const SDL_AssertionHandler = ?fn ([*c]const SDL_AssertData, ?*c_void) callconv(.C) SDL_AssertState;
pub extern fn SDL_SetAssertionHandler(handler: SDL_AssertionHandler, userdata: ?*c_void) void;
pub extern fn SDL_GetDefaultAssertionHandler() SDL_AssertionHandler;
pub extern fn SDL_GetAssertionHandler(puserdata: [*c]?*c_void) SDL_AssertionHandler;
pub extern fn SDL_GetAssertionReport() [*c]const SDL_AssertData;
pub extern fn SDL_ResetAssertionReport() void;
pub const SDL_SpinLock = c_int;
pub extern fn SDL_AtomicTryLock(lock: [*c]SDL_SpinLock) SDL_bool;
pub extern fn SDL_AtomicLock(lock: [*c]SDL_SpinLock) void;
pub extern fn SDL_AtomicUnlock(lock: [*c]SDL_SpinLock) void;
pub extern fn SDL_MemoryBarrierReleaseFunction() void;
pub extern fn SDL_MemoryBarrierAcquireFunction() void;
pub const SDL_atomic_t = extern struct {
    value: c_int,
};
pub extern fn SDL_AtomicCAS(a: [*c]SDL_atomic_t, oldval: c_int, newval: c_int) SDL_bool;
pub extern fn SDL_AtomicSet(a: [*c]SDL_atomic_t, v: c_int) c_int;
pub extern fn SDL_AtomicGet(a: [*c]SDL_atomic_t) c_int;
pub extern fn SDL_AtomicAdd(a: [*c]SDL_atomic_t, v: c_int) c_int;
pub extern fn SDL_AtomicCASPtr(a: [*c]?*c_void, oldval: ?*c_void, newval: ?*c_void) SDL_bool;
pub extern fn SDL_AtomicSetPtr(a: [*c]?*c_void, v: ?*c_void) ?*c_void;
pub extern fn SDL_AtomicGetPtr(a: [*c]?*c_void) ?*c_void;
pub extern fn SDL_SetError(fmt: [*c]const u8, ...) c_int;
pub extern fn SDL_GetError() [*c]const u8;
pub extern fn SDL_ClearError() void;

pub const SDL_errorcode = extern enum(c_int) {
    SDL_ENOMEM,
    SDL_EFREAD,
    SDL_EFWRITE,
    SDL_EFSEEK,
    SDL_UNSUPPORTED,
    SDL_LASTERROR,
};

pub extern fn SDL_Error(code: SDL_errorcode) c_int; // /usr/local/include/SDL2/SDL_endian.h:83:3: warning: TODO implement translation of stmt class GCCAsmStmtClass
pub const SDL_mutex = @Type(.Opaque);
pub extern fn SDL_CreateMutex() ?*SDL_mutex;
pub extern fn SDL_LockMutex(mutex: ?*SDL_mutex) c_int;
pub extern fn SDL_TryLockMutex(mutex: ?*SDL_mutex) c_int;
pub extern fn SDL_UnlockMutex(mutex: ?*SDL_mutex) c_int;
pub extern fn SDL_DestroyMutex(mutex: ?*SDL_mutex) void;
pub const SDL_sem = @Type(.Opaque);
pub extern fn SDL_CreateSemaphore(initial_value: Uint32) ?*SDL_sem;
pub extern fn SDL_DestroySemaphore(sem: ?*SDL_sem) void;
pub extern fn SDL_SemWait(sem: ?*SDL_sem) c_int;
pub extern fn SDL_SemTryWait(sem: ?*SDL_sem) c_int;
pub extern fn SDL_SemWaitTimeout(sem: ?*SDL_sem, ms: Uint32) c_int;
pub extern fn SDL_SemPost(sem: ?*SDL_sem) c_int;
pub extern fn SDL_SemValue(sem: ?*SDL_sem) Uint32;
pub const struct_SDL_cond = @Type(.Opaque);
pub const SDL_cond = struct_SDL_cond;
pub extern fn SDL_CreateCond() ?*SDL_cond;
pub extern fn SDL_DestroyCond(cond: ?*SDL_cond) void;
pub extern fn SDL_CondSignal(cond: ?*SDL_cond) c_int;
pub extern fn SDL_CondBroadcast(cond: ?*SDL_cond) c_int;
pub extern fn SDL_CondWait(cond: ?*SDL_cond, mutex: ?*SDL_mutex) c_int;
pub extern fn SDL_CondWaitTimeout(cond: ?*SDL_cond, mutex: ?*SDL_mutex, ms: Uint32) c_int;
pub const struct_SDL_Thread = @Type(.Opaque);
pub const SDL_Thread = struct_SDL_Thread;
pub const SDL_threadID = c_ulong;
pub const SDL_TLSID = c_uint;
pub const SDL_ThreadPriority = extern enum(c_int) {
    SDL_THREAD_PRIORITY_LOW,
    SDL_THREAD_PRIORITY_NORMAL,
    SDL_THREAD_PRIORITY_HIGH,
    SDL_THREAD_PRIORITY_TIME_CRITICAL,
};
pub const SDL_ThreadFunction = ?fn (?*c_void) callconv(.C) c_int;
pub extern fn SDL_CreateThread(@"fn": SDL_ThreadFunction, name: [*c]const u8, data: ?*c_void) ?*SDL_Thread;
pub extern fn SDL_CreateThreadWithStackSize(@"fn": SDL_ThreadFunction, name: [*c]const u8, stacksize: usize, data: ?*c_void) ?*SDL_Thread;
pub extern fn SDL_GetThreadName(thread: ?*SDL_Thread) [*c]const u8;
pub extern fn SDL_ThreadID() SDL_threadID;
pub extern fn SDL_GetThreadID(thread: ?*SDL_Thread) SDL_threadID;
pub extern fn SDL_SetThreadPriority(priority: SDL_ThreadPriority) c_int;
pub extern fn SDL_WaitThread(thread: ?*SDL_Thread, status: [*c]c_int) void;
pub extern fn SDL_DetachThread(thread: ?*SDL_Thread) void;
pub extern fn SDL_TLSCreate() SDL_TLSID;
pub extern fn SDL_TLSGet(id: SDL_TLSID) ?*c_void;
pub extern fn SDL_TLSSet(id: SDL_TLSID, value: ?*const c_void, destructor: ?fn (?*c_void) callconv(.C) void) c_int;
const struct_unnamed_21 = extern struct {
    autoclose: SDL_bool,
    fp: [*c]FILE,
};
const struct_unnamed_22 = extern struct {
    base: [*c]Uint8,
    here: [*c]Uint8,
    stop: [*c]Uint8,
};
const struct_unnamed_23 = extern struct {
    data1: ?*c_void,
    data2: ?*c_void,
};
const union_unnamed_20 = extern union {
    stdio: struct_unnamed_21,
    mem: struct_unnamed_22,
    unknown: struct_unnamed_23,
};
pub const SDL_RWops = extern struct {
    size: ?fn ([*c]SDL_RWops) callconv(.C) Sint64,
    seek: ?fn ([*c]SDL_RWops, Sint64, c_int) callconv(.C) Sint64,
    read: ?fn ([*c]SDL_RWops, ?*c_void, usize, usize) callconv(.C) usize,
    write: ?fn ([*c]SDL_RWops, ?*const c_void, usize, usize) callconv(.C) usize,
    close: ?fn ([*c]SDL_RWops) callconv(.C) c_int,
    type: Uint32,
    hidden: union_unnamed_20,
};

pub extern fn SDL_RWFromFile(file: [*c]const u8, mode: [*c]const u8) [*c]SDL_RWops;
pub extern fn SDL_RWFromFP(fp: [*c]FILE, autoclose: SDL_bool) [*c]SDL_RWops;
pub extern fn SDL_RWFromMem(mem: ?*c_void, size: c_int) [*c]SDL_RWops;
pub extern fn SDL_RWFromConstMem(mem: ?*const c_void, size: c_int) [*c]SDL_RWops;
pub extern fn SDL_AllocRW() [*c]SDL_RWops;
pub extern fn SDL_FreeRW(area: [*c]SDL_RWops) void;
pub extern fn SDL_RWsize(context: [*c]SDL_RWops) Sint64;
pub extern fn SDL_RWseek(context: [*c]SDL_RWops, offset: Sint64, whence: c_int) Sint64;
pub extern fn SDL_RWtell(context: [*c]SDL_RWops) Sint64;
pub extern fn SDL_RWread(context: [*c]SDL_RWops, ptr: ?*c_void, size: usize, maxnum: usize) usize;
pub extern fn SDL_RWwrite(context: [*c]SDL_RWops, ptr: ?*const c_void, size: usize, num: usize) usize;
pub extern fn SDL_RWclose(context: [*c]SDL_RWops) c_int;
pub extern fn SDL_LoadFile_RW(src: [*c]SDL_RWops, datasize: [*c]usize, freesrc: c_int) ?*c_void;
pub extern fn SDL_LoadFile(file: [*c]const u8, datasize: [*c]usize) ?*c_void;
pub extern fn SDL_ReadU8(src: [*c]SDL_RWops) Uint8;
pub extern fn SDL_ReadLE16(src: [*c]SDL_RWops) Uint16;
pub extern fn SDL_ReadBE16(src: [*c]SDL_RWops) Uint16;
pub extern fn SDL_ReadLE32(src: [*c]SDL_RWops) Uint32;
pub extern fn SDL_ReadBE32(src: [*c]SDL_RWops) Uint32;
pub extern fn SDL_ReadLE64(src: [*c]SDL_RWops) Uint64;
pub extern fn SDL_ReadBE64(src: [*c]SDL_RWops) Uint64;
pub extern fn SDL_WriteU8(dst: [*c]SDL_RWops, value: Uint8) usize;
pub extern fn SDL_WriteLE16(dst: [*c]SDL_RWops, value: Uint16) usize;
pub extern fn SDL_WriteBE16(dst: [*c]SDL_RWops, value: Uint16) usize;
pub extern fn SDL_WriteLE32(dst: [*c]SDL_RWops, value: Uint32) usize;
pub extern fn SDL_WriteBE32(dst: [*c]SDL_RWops, value: Uint32) usize;
pub extern fn SDL_WriteLE64(dst: [*c]SDL_RWops, value: Uint64) usize;
pub extern fn SDL_WriteBE64(dst: [*c]SDL_RWops, value: Uint64) usize;
pub const SDL_AudioFormat = Uint16;
pub const SDL_AudioCallback = ?fn (?*c_void, [*c]Uint8, c_int) callconv(.C) void;
pub const SDL_AudioSpec = extern struct {
    freq: c_int,
    format: SDL_AudioFormat,
    channels: Uint8,
    silence: Uint8,
    samples: Uint16,
    padding: Uint16,
    size: Uint32,
    callback: SDL_AudioCallback,
    userdata: ?*c_void,
};

pub const SDL_AudioCVT = extern struct {
    needed: c_int,
    src_format: SDL_AudioFormat,
    dst_format: SDL_AudioFormat,
    rate_incr: f64,
    buf: [*c]Uint8,
    len: c_int,
    len_cvt: c_int,
    len_mult: c_int,
    len_ratio: f64,
    filters: [10]SDL_AudioFilter,
    filter_index: c_int,
};
pub const SDL_AudioFilter = ?fn ([*c]struct_SDL_AudioCVT, SDL_AudioFormat) callconv(.C) void;
pub extern fn SDL_GetNumAudioDrivers() c_int;
pub extern fn SDL_GetAudioDriver(index: c_int) [*c]const u8;
pub extern fn SDL_AudioInit(driver_name: [*c]const u8) c_int;
pub extern fn SDL_AudioQuit() void;
pub extern fn SDL_GetCurrentAudioDriver() [*c]const u8;
pub extern fn SDL_OpenAudio(desired: [*c]SDL_AudioSpec, obtained: [*c]SDL_AudioSpec) c_int;
pub const SDL_AudioDeviceID = Uint32;
pub extern fn SDL_GetNumAudioDevices(iscapture: c_int) c_int;
pub extern fn SDL_GetAudioDeviceName(index: c_int, iscapture: c_int) [*c]const u8;
pub extern fn SDL_OpenAudioDevice(device: [*c]const u8, iscapture: c_int, desired: [*c]const SDL_AudioSpec, obtained: [*c]SDL_AudioSpec, allowed_changes: c_int) SDL_AudioDeviceID;
pub const SDL_AUDIO_STOPPED = @enumToInt(enum_unnamed_24.SDL_AUDIO_STOPPED);
pub const SDL_AUDIO_PLAYING = @enumToInt(enum_unnamed_24.SDL_AUDIO_PLAYING);
pub const SDL_AUDIO_PAUSED = @enumToInt(enum_unnamed_24.SDL_AUDIO_PAUSED);
const enum_unnamed_24 = extern enum(c_int) {
    SDL_AUDIO_STOPPED = 0,
    SDL_AUDIO_PLAYING = 1,
    SDL_AUDIO_PAUSED = 2,
    _,
};
pub const SDL_AudioStatus = enum_unnamed_24;
pub extern fn SDL_GetAudioStatus() SDL_AudioStatus;
pub extern fn SDL_GetAudioDeviceStatus(dev: SDL_AudioDeviceID) SDL_AudioStatus;
pub extern fn SDL_PauseAudio(pause_on: c_int) void;
pub extern fn SDL_PauseAudioDevice(dev: SDL_AudioDeviceID, pause_on: c_int) void;
pub extern fn SDL_LoadWAV_RW(src: [*c]SDL_RWops, freesrc: c_int, spec: [*c]SDL_AudioSpec, audio_buf: [*c][*c]Uint8, audio_len: [*c]Uint32) [*c]SDL_AudioSpec;
pub extern fn SDL_FreeWAV(audio_buf: [*c]Uint8) void;
pub extern fn SDL_BuildAudioCVT(cvt: [*c]SDL_AudioCVT, src_format: SDL_AudioFormat, src_channels: Uint8, src_rate: c_int, dst_format: SDL_AudioFormat, dst_channels: Uint8, dst_rate: c_int) c_int;
pub extern fn SDL_ConvertAudio(cvt: [*c]SDL_AudioCVT) c_int;
pub const struct__SDL_AudioStream = @Type(.Opaque);
pub const SDL_AudioStream = struct__SDL_AudioStream;
pub extern fn SDL_NewAudioStream(src_format: SDL_AudioFormat, src_channels: Uint8, src_rate: c_int, dst_format: SDL_AudioFormat, dst_channels: Uint8, dst_rate: c_int) ?*SDL_AudioStream;
pub extern fn SDL_AudioStreamPut(stream: ?*SDL_AudioStream, buf: ?*const c_void, len: c_int) c_int;
pub extern fn SDL_AudioStreamGet(stream: ?*SDL_AudioStream, buf: ?*c_void, len: c_int) c_int;
pub extern fn SDL_AudioStreamAvailable(stream: ?*SDL_AudioStream) c_int;
pub extern fn SDL_AudioStreamFlush(stream: ?*SDL_AudioStream) c_int;
pub extern fn SDL_AudioStreamClear(stream: ?*SDL_AudioStream) void;
pub extern fn SDL_FreeAudioStream(stream: ?*SDL_AudioStream) void;
pub extern fn SDL_MixAudio(dst: [*c]Uint8, src: [*c]const Uint8, len: Uint32, volume: c_int) void;
pub extern fn SDL_MixAudioFormat(dst: [*c]Uint8, src: [*c]const Uint8, format: SDL_AudioFormat, len: Uint32, volume: c_int) void;
pub extern fn SDL_QueueAudio(dev: SDL_AudioDeviceID, data: ?*const c_void, len: Uint32) c_int;
pub extern fn SDL_DequeueAudio(dev: SDL_AudioDeviceID, data: ?*c_void, len: Uint32) Uint32;
pub extern fn SDL_GetQueuedAudioSize(dev: SDL_AudioDeviceID) Uint32;
pub extern fn SDL_ClearQueuedAudio(dev: SDL_AudioDeviceID) void;
pub extern fn SDL_LockAudio() void;
pub extern fn SDL_LockAudioDevice(dev: SDL_AudioDeviceID) void;
pub extern fn SDL_UnlockAudio() void;
pub extern fn SDL_UnlockAudioDevice(dev: SDL_AudioDeviceID) void;
pub extern fn SDL_CloseAudio() void;
pub extern fn SDL_CloseAudioDevice(dev: SDL_AudioDeviceID) void;
pub extern fn SDL_SetClipboardText(text: [*c]const u8) c_int;
pub extern fn SDL_GetClipboardText() [*c]u8;
pub extern fn SDL_HasClipboardText() SDL_bool; // /Users/desaro/zig/lib/zig/include/mmintrin.h:13:19: warning: unsupported type: 'Vector'

pub extern fn SDL_GetCPUCount() c_int;
pub extern fn SDL_GetCPUCacheLineSize() c_int;
pub extern fn SDL_HasRDTSC() SDL_bool;
pub extern fn SDL_HasAltiVec() SDL_bool;
pub extern fn SDL_HasMMX() SDL_bool;
pub extern fn SDL_Has3DNow() SDL_bool;
pub extern fn SDL_HasSSE() SDL_bool;
pub extern fn SDL_HasSSE2() SDL_bool;
pub extern fn SDL_HasSSE3() SDL_bool;
pub extern fn SDL_HasSSE41() SDL_bool;
pub extern fn SDL_HasSSE42() SDL_bool;
pub extern fn SDL_HasAVX() SDL_bool;
pub extern fn SDL_HasAVX2() SDL_bool;
pub extern fn SDL_HasAVX512F() SDL_bool;
pub extern fn SDL_HasARMSIMD() SDL_bool;
pub extern fn SDL_HasNEON() SDL_bool;
pub extern fn SDL_GetSystemRAM() c_int;
pub extern fn SDL_SIMDGetAlignment() usize;
pub extern fn SDL_SIMDAlloc(len: usize) ?*c_void;
pub extern fn SDL_SIMDFree(ptr: ?*c_void) void;

pub const SDL_PixelType = extern enum(c_int) {
    SDL_PIXELTYPE_UNKNOWN,
    SDL_PIXELTYPE_INDEX1,
    SDL_PIXELTYPE_INDEX4,
    SDL_PIXELTYPE_INDEX8,
    SDL_PIXELTYPE_PACKED8,
    SDL_PIXELTYPE_PACKED16,
    SDL_PIXELTYPE_PACKED32,
    SDL_PIXELTYPE_ARRAYU8,
    SDL_PIXELTYPE_ARRAYU16,
    SDL_PIXELTYPE_ARRAYU32,
    SDL_PIXELTYPE_ARRAYF16,
    SDL_PIXELTYPE_ARRAYF32,
};

pub const SDL_BitmapOrder = extern enum(c_int) {
    SDL_BITMAPORDER_NONE,
    SDL_BITMAPORDER_4321,
    SDL_BITMAPORDER_1234,
};

pub const SDL_PackedOrder = extern enum(c_int) {
    SDL_PACKEDORDER_NONE,
    SDL_PACKEDORDER_XRGB,
    SDL_PACKEDORDER_RGBX,
    SDL_PACKEDORDER_ARGB,
    SDL_PACKEDORDER_RGBA,
    SDL_PACKEDORDER_XBGR,
    SDL_PACKEDORDER_BGRX,
    SDL_PACKEDORDER_ABGR,
    SDL_PACKEDORDER_BGRA,
};

pub const SDL_ArrayOrder = extern enum(c_int) {
    SDL_ARRAYORDER_NONE,
    SDL_ARRAYORDER_RGB,
    SDL_ARRAYORDER_RGBA,
    SDL_ARRAYORDER_ARGB,
    SDL_ARRAYORDER_BGR,
    SDL_ARRAYORDER_BGRA,
    SDL_ARRAYORDER_ABGR,
};

const enum_unnamed_33 = extern enum(c_int) {
    SDL_PACKEDLAYOUT_NONE,
    SDL_PACKEDLAYOUT_332,
    SDL_PACKEDLAYOUT_4444,
    SDL_PACKEDLAYOUT_1555,
    SDL_PACKEDLAYOUT_5551,
    SDL_PACKEDLAYOUT_565,
    SDL_PACKEDLAYOUT_8888,
    SDL_PACKEDLAYOUT_2101010,
    SDL_PACKEDLAYOUT_1010102,
    _,
};
pub const SDL_PackedLayout = enum_unnamed_33;

const enum_unnamed_34 = extern enum(c_int) {
    SDL_PIXELFORMAT_UNKNOWN = 0,
    SDL_PIXELFORMAT_INDEX1LSB = 286261504,
    SDL_PIXELFORMAT_INDEX1MSB = 287310080,
    SDL_PIXELFORMAT_INDEX4LSB = 303039488,
    SDL_PIXELFORMAT_INDEX4MSB = 304088064,
    SDL_PIXELFORMAT_INDEX8 = 318769153,
    SDL_PIXELFORMAT_RGB332 = 336660481,
    SDL_PIXELFORMAT_RGB444 = 353504258,
    SDL_PIXELFORMAT_BGR444 = 357698562,
    SDL_PIXELFORMAT_RGB555 = 353570562,
    SDL_PIXELFORMAT_BGR555 = 357764866,
    SDL_PIXELFORMAT_ARGB4444 = 355602434,
    SDL_PIXELFORMAT_RGBA4444 = 356651010,
    SDL_PIXELFORMAT_ABGR4444 = 359796738,
    SDL_PIXELFORMAT_BGRA4444 = 360845314,
    SDL_PIXELFORMAT_ARGB1555 = 355667970,
    SDL_PIXELFORMAT_RGBA5551 = 356782082,
    SDL_PIXELFORMAT_ABGR1555 = 359862274,
    SDL_PIXELFORMAT_BGRA5551 = 360976386,
    SDL_PIXELFORMAT_RGB565 = 353701890,
    SDL_PIXELFORMAT_BGR565 = 357896194,
    SDL_PIXELFORMAT_RGB24 = 386930691,
    SDL_PIXELFORMAT_BGR24 = 390076419,
    SDL_PIXELFORMAT_RGB888 = 370546692,
    SDL_PIXELFORMAT_RGBX8888 = 371595268,
    SDL_PIXELFORMAT_BGR888 = 374740996,
    SDL_PIXELFORMAT_BGRX8888 = 375789572,
    SDL_PIXELFORMAT_ARGB8888 = 372645892,
    SDL_PIXELFORMAT_RGBA8888 = 373694468,
    SDL_PIXELFORMAT_ABGR8888 = 376840196,
    SDL_PIXELFORMAT_BGRA8888 = 377888772,
    SDL_PIXELFORMAT_ARGB2101010 = 372711428,
    SDL_PIXELFORMAT_RGBA32 = 376840196,
    SDL_PIXELFORMAT_ARGB32 = 377888772,
    SDL_PIXELFORMAT_BGRA32 = 372645892,
    SDL_PIXELFORMAT_ABGR32 = 373694468,
    SDL_PIXELFORMAT_YV12 = 842094169,
    SDL_PIXELFORMAT_IYUV = 1448433993,
    SDL_PIXELFORMAT_YUY2 = 844715353,
    SDL_PIXELFORMAT_UYVY = 1498831189,
    SDL_PIXELFORMAT_YVYU = 1431918169,
    SDL_PIXELFORMAT_NV12 = 842094158,
    SDL_PIXELFORMAT_NV21 = 825382478,
    SDL_PIXELFORMAT_EXTERNAL_OES = 542328143,
    _,
};
pub const SDL_PixelFormatEnum = enum_unnamed_34;
pub const struct_SDL_Color = extern struct {
    r: Uint8,
    g: Uint8,
    b: Uint8,
    a: Uint8,
};
pub const SDL_Color = struct_SDL_Color;
pub const struct_SDL_Palette = extern struct {
    ncolors: c_int,
    colors: [*c]SDL_Color,
    version: Uint32,
    refcount: c_int,
};
pub const SDL_Palette = struct_SDL_Palette;
pub const struct_SDL_PixelFormat = extern struct {
    format: Uint32,
    palette: [*c]SDL_Palette,
    BitsPerPixel: Uint8,
    BytesPerPixel: Uint8,
    padding: [2]Uint8,
    Rmask: Uint32,
    Gmask: Uint32,
    Bmask: Uint32,
    Amask: Uint32,
    Rloss: Uint8,
    Gloss: Uint8,
    Bloss: Uint8,
    Aloss: Uint8,
    Rshift: Uint8,
    Gshift: Uint8,
    Bshift: Uint8,
    Ashift: Uint8,
    refcount: c_int,
    next: [*c]struct_SDL_PixelFormat,
};
pub const SDL_PixelFormat = struct_SDL_PixelFormat;
pub extern fn SDL_GetPixelFormatName(format: Uint32) [*c]const u8;
pub extern fn SDL_PixelFormatEnumToMasks(format: Uint32, bpp: [*c]c_int, Rmask: [*c]Uint32, Gmask: [*c]Uint32, Bmask: [*c]Uint32, Amask: [*c]Uint32) SDL_bool;
pub extern fn SDL_MasksToPixelFormatEnum(bpp: c_int, Rmask: Uint32, Gmask: Uint32, Bmask: Uint32, Amask: Uint32) Uint32;
pub extern fn SDL_AllocFormat(pixel_format: Uint32) [*c]SDL_PixelFormat;
pub extern fn SDL_FreeFormat(format: [*c]SDL_PixelFormat) void;
pub extern fn SDL_AllocPalette(ncolors: c_int) [*c]SDL_Palette;
pub extern fn SDL_SetPixelFormatPalette(format: [*c]SDL_PixelFormat, palette: [*c]SDL_Palette) c_int;
pub extern fn SDL_SetPaletteColors(palette: [*c]SDL_Palette, colors: [*c]const SDL_Color, firstcolor: c_int, ncolors: c_int) c_int;
pub extern fn SDL_FreePalette(palette: [*c]SDL_Palette) void;
pub extern fn SDL_MapRGB(format: [*c]const SDL_PixelFormat, r: Uint8, g: Uint8, b: Uint8) Uint32;
pub extern fn SDL_MapRGBA(format: [*c]const SDL_PixelFormat, r: Uint8, g: Uint8, b: Uint8, a: Uint8) Uint32;
pub extern fn SDL_GetRGB(pixel: Uint32, format: [*c]const SDL_PixelFormat, r: [*c]Uint8, g: [*c]Uint8, b: [*c]Uint8) void;
pub extern fn SDL_GetRGBA(pixel: Uint32, format: [*c]const SDL_PixelFormat, r: [*c]Uint8, g: [*c]Uint8, b: [*c]Uint8, a: [*c]Uint8) void;
pub extern fn SDL_CalculateGammaRamp(gamma: f32, ramp: [*c]Uint16) void;
pub const struct_SDL_Point = extern struct {
    x: c_int,
    y: c_int,
};
pub const SDL_Point = struct_SDL_Point;
pub const struct_SDL_FPoint = extern struct {
    x: f32,
    y: f32,
};
pub const SDL_FPoint = struct_SDL_FPoint;
pub const struct_SDL_Rect = extern struct {
    x: c_int,
    y: c_int,
    w: c_int,
    h: c_int,
};
pub const SDL_Rect = struct_SDL_Rect;
pub const struct_SDL_FRect = extern struct {
    x: f32,
    y: f32,
    w: f32,
    h: f32,
};
pub const SDL_FRect = struct_SDL_FRect;
pub fn SDL_PointInRect(arg_p: [*c]const SDL_Point, arg_r: [*c]const SDL_Rect) callconv(.C) SDL_bool {
    var p = arg_p;
    var r = arg_r;
    return @intToEnum(SDL_bool, if ((((p.*.x >= r.*.x) and (p.*.x < (r.*.x + r.*.w))) and (p.*.y >= r.*.y)) and (p.*.y < (r.*.y + r.*.h))) SDL_TRUE else SDL_FALSE);
}
pub fn SDL_RectEmpty(arg_r: [*c]const SDL_Rect) callconv(.C) SDL_bool {
    var r = arg_r;
    return @intToEnum(SDL_bool, if (((!(r != null)) or (r.*.w <= @as(c_int, 0))) or (r.*.h <= @as(c_int, 0))) SDL_TRUE else SDL_FALSE);
}
pub fn SDL_RectEquals(arg_a: [*c]const SDL_Rect, arg_b: [*c]const SDL_Rect) callconv(.C) SDL_bool {
    var a = arg_a;
    var b = arg_b;
    return @intToEnum(SDL_bool, if ((((((a != null) and (b != null)) and (a.*.x == b.*.x)) and (a.*.y == b.*.y)) and (a.*.w == b.*.w)) and (a.*.h == b.*.h)) SDL_TRUE else SDL_FALSE);
}
pub extern fn SDL_HasIntersection(A: [*c]const SDL_Rect, B: [*c]const SDL_Rect) SDL_bool;
pub extern fn SDL_IntersectRect(A: [*c]const SDL_Rect, B: [*c]const SDL_Rect, result: [*c]SDL_Rect) SDL_bool;
pub extern fn SDL_UnionRect(A: [*c]const SDL_Rect, B: [*c]const SDL_Rect, result: [*c]SDL_Rect) void;
pub extern fn SDL_EnclosePoints(points: [*c]const SDL_Point, count: c_int, clip: [*c]const SDL_Rect, result: [*c]SDL_Rect) SDL_bool;
pub extern fn SDL_IntersectRectAndLine(rect: [*c]const SDL_Rect, X1: [*c]c_int, Y1: [*c]c_int, X2: [*c]c_int, Y2: [*c]c_int) SDL_bool;

const enum_unnamed_35 = extern enum(c_int) {
    SDL_BLENDMODE_NONE = 0,
    SDL_BLENDMODE_BLEND = 1,
    SDL_BLENDMODE_ADD = 2,
    SDL_BLENDMODE_MOD = 4,
    SDL_BLENDMODE_MUL = 8,
    SDL_BLENDMODE_INVALID = 2147483647,
    _,
};
pub const SDL_BlendMode = enum_unnamed_35;

const enum_unnamed_36 = extern enum(c_int) {
    SDL_BLENDOPERATION_ADD = 1,
    SDL_BLENDOPERATION_SUBTRACT = 2,
    SDL_BLENDOPERATION_REV_SUBTRACT = 3,
    SDL_BLENDOPERATION_MINIMUM = 4,
    SDL_BLENDOPERATION_MAXIMUM = 5,
    _,
};
pub const SDL_BlendOperation = enum_unnamed_36;

const enum_unnamed_37 = extern enum(c_int) {
    SDL_BLENDFACTOR_ZERO = 1,
    SDL_BLENDFACTOR_ONE = 2,
    SDL_BLENDFACTOR_SRC_COLOR = 3,
    SDL_BLENDFACTOR_ONE_MINUS_SRC_COLOR = 4,
    SDL_BLENDFACTOR_SRC_ALPHA = 5,
    SDL_BLENDFACTOR_ONE_MINUS_SRC_ALPHA = 6,
    SDL_BLENDFACTOR_DST_COLOR = 7,
    SDL_BLENDFACTOR_ONE_MINUS_DST_COLOR = 8,
    SDL_BLENDFACTOR_DST_ALPHA = 9,
    SDL_BLENDFACTOR_ONE_MINUS_DST_ALPHA = 10,
    _,
};
pub const SDL_BlendFactor = enum_unnamed_37;
pub extern fn SDL_ComposeCustomBlendMode(srcColorFactor: SDL_BlendFactor, dstColorFactor: SDL_BlendFactor, colorOperation: SDL_BlendOperation, srcAlphaFactor: SDL_BlendFactor, dstAlphaFactor: SDL_BlendFactor, alphaOperation: SDL_BlendOperation) SDL_BlendMode;
pub const struct_SDL_BlitMap = @Type(.Opaque);
pub const struct_SDL_Surface = extern struct {
    flags: Uint32,
    format: [*c]SDL_PixelFormat,
    w: c_int,
    h: c_int,
    pitch: c_int,
    pixels: ?*c_void,
    userdata: ?*c_void,
    locked: c_int,
    lock_data: ?*c_void,
    clip_rect: SDL_Rect,
    map: ?*struct_SDL_BlitMap,
    refcount: c_int,
};
pub const SDL_Surface = struct_SDL_Surface;
pub const SDL_blit = ?fn ([*c]struct_SDL_Surface, [*c]SDL_Rect, [*c]struct_SDL_Surface, [*c]SDL_Rect) callconv(.C) c_int;

const enum_unnamed_38 = extern enum(c_int) {
    SDL_YUV_CONVERSION_JPEG,
    SDL_YUV_CONVERSION_BT601,
    SDL_YUV_CONVERSION_BT709,
    SDL_YUV_CONVERSION_AUTOMATIC,
    _,
};
pub const SDL_YUV_CONVERSION_MODE = enum_unnamed_38;
pub extern fn SDL_CreateRGBSurface(flags: Uint32, width: c_int, height: c_int, depth: c_int, Rmask: Uint32, Gmask: Uint32, Bmask: Uint32, Amask: Uint32) [*c]SDL_Surface;
pub extern fn SDL_CreateRGBSurfaceWithFormat(flags: Uint32, width: c_int, height: c_int, depth: c_int, format: Uint32) [*c]SDL_Surface;
pub extern fn SDL_CreateRGBSurfaceFrom(pixels: ?*c_void, width: c_int, height: c_int, depth: c_int, pitch: c_int, Rmask: Uint32, Gmask: Uint32, Bmask: Uint32, Amask: Uint32) [*c]SDL_Surface;
pub extern fn SDL_CreateRGBSurfaceWithFormatFrom(pixels: ?*c_void, width: c_int, height: c_int, depth: c_int, pitch: c_int, format: Uint32) [*c]SDL_Surface;
pub extern fn SDL_FreeSurface(surface: [*c]SDL_Surface) void;
pub extern fn SDL_SetSurfacePalette(surface: [*c]SDL_Surface, palette: [*c]SDL_Palette) c_int;
pub extern fn SDL_LockSurface(surface: [*c]SDL_Surface) c_int;
pub extern fn SDL_UnlockSurface(surface: [*c]SDL_Surface) void;
pub extern fn SDL_LoadBMP_RW(src: [*c]SDL_RWops, freesrc: c_int) [*]SDL_Surface;
pub extern fn SDL_SaveBMP_RW(surface: [*c]SDL_Surface, dst: [*c]SDL_RWops, freedst: c_int) c_int;
pub extern fn SDL_SetSurfaceRLE(surface: [*c]SDL_Surface, flag: c_int) c_int;
pub extern fn SDL_SetColorKey(surface: [*c]SDL_Surface, flag: c_int, key: Uint32) c_int;
pub extern fn SDL_HasColorKey(surface: [*c]SDL_Surface) SDL_bool;
pub extern fn SDL_GetColorKey(surface: [*c]SDL_Surface, key: [*c]Uint32) c_int;
pub extern fn SDL_SetSurfaceColorMod(surface: [*c]SDL_Surface, r: Uint8, g: Uint8, b: Uint8) c_int;
pub extern fn SDL_GetSurfaceColorMod(surface: [*c]SDL_Surface, r: [*c]Uint8, g: [*c]Uint8, b: [*c]Uint8) c_int;
pub extern fn SDL_SetSurfaceAlphaMod(surface: [*c]SDL_Surface, alpha: Uint8) c_int;
pub extern fn SDL_GetSurfaceAlphaMod(surface: [*c]SDL_Surface, alpha: [*c]Uint8) c_int;
pub extern fn SDL_SetSurfaceBlendMode(surface: [*c]SDL_Surface, blendMode: SDL_BlendMode) c_int;
pub extern fn SDL_GetSurfaceBlendMode(surface: [*c]SDL_Surface, blendMode: [*c]SDL_BlendMode) c_int;
pub extern fn SDL_SetClipRect(surface: [*c]SDL_Surface, rect: [*c]const SDL_Rect) SDL_bool;
pub extern fn SDL_GetClipRect(surface: [*c]SDL_Surface, rect: [*c]SDL_Rect) void;
pub extern fn SDL_DuplicateSurface(surface: [*c]SDL_Surface) [*c]SDL_Surface;
pub extern fn SDL_ConvertSurface(src: [*c]SDL_Surface, fmt: [*c]const SDL_PixelFormat, flags: Uint32) [*c]SDL_Surface;
pub extern fn SDL_ConvertSurfaceFormat(src: [*c]SDL_Surface, pixel_format: Uint32, flags: Uint32) [*c]SDL_Surface;
pub extern fn SDL_ConvertPixels(width: c_int, height: c_int, src_format: Uint32, src: ?*const c_void, src_pitch: c_int, dst_format: Uint32, dst: ?*c_void, dst_pitch: c_int) c_int;
pub extern fn SDL_FillRect(dst: [*c]SDL_Surface, rect: [*c]const SDL_Rect, color: Uint32) c_int;
pub extern fn SDL_FillRects(dst: [*c]SDL_Surface, rects: [*c]const SDL_Rect, count: c_int, color: Uint32) c_int;
pub extern fn SDL_UpperBlit(src: [*c]SDL_Surface, srcrect: [*c]const SDL_Rect, dst: [*c]SDL_Surface, dstrect: [*c]SDL_Rect) c_int;
pub extern fn SDL_LowerBlit(src: [*c]SDL_Surface, srcrect: [*c]SDL_Rect, dst: [*c]SDL_Surface, dstrect: [*c]SDL_Rect) c_int;
pub extern fn SDL_SoftStretch(src: [*c]SDL_Surface, srcrect: [*c]const SDL_Rect, dst: [*c]SDL_Surface, dstrect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_UpperBlitScaled(src: [*c]SDL_Surface, srcrect: [*c]const SDL_Rect, dst: [*c]SDL_Surface, dstrect: [*c]SDL_Rect) c_int;
pub extern fn SDL_LowerBlitScaled(src: [*c]SDL_Surface, srcrect: [*c]SDL_Rect, dst: [*c]SDL_Surface, dstrect: [*c]SDL_Rect) c_int;
pub extern fn SDL_SetYUVConversionMode(mode: SDL_YUV_CONVERSION_MODE) void;
pub extern fn SDL_GetYUVConversionMode() SDL_YUV_CONVERSION_MODE;
pub extern fn SDL_GetYUVConversionModeForResolution(width: c_int, height: c_int) SDL_YUV_CONVERSION_MODE;
const struct_unnamed_39 = extern struct {
    format: Uint32,
    w: c_int,
    h: c_int,
    refresh_rate: c_int,
    driverdata: ?*c_void,
};
pub const SDL_DisplayMode = struct_unnamed_39;
pub const struct_SDL_Window = @Type(.Opaque);
pub const SDL_Window = struct_SDL_Window;

pub const SDL_WindowFlags = extern enum(c_int) {
    SDL_WINDOW_FULLSCREEN = 1,
    SDL_WINDOW_OPENGL = 2,
    SDL_WINDOW_SHOWN = 4,
    SDL_WINDOW_HIDDEN = 8,
    SDL_WINDOW_BORDERLESS = 16,
    SDL_WINDOW_RESIZABLE = 32,
    SDL_WINDOW_MINIMIZED = 64,
    SDL_WINDOW_MAXIMIZED = 128,
    SDL_WINDOW_INPUT_GRABBED = 256,
    SDL_WINDOW_INPUT_FOCUS = 512,
    SDL_WINDOW_MOUSE_FOCUS = 1024,
    SDL_WINDOW_FULLSCREEN_DESKTOP = 4097,
    SDL_WINDOW_FOREIGN = 2048,
    SDL_WINDOW_ALLOW_HIGHDPI = 8192,
    SDL_WINDOW_MOUSE_CAPTURE = 16384,
    SDL_WINDOW_ALWAYS_ON_TOP = 32768,
    SDL_WINDOW_SKIP_TASKBAR = 65536,
    SDL_WINDOW_UTILITY = 131072,
    SDL_WINDOW_TOOLTIP = 262144,
    SDL_WINDOW_POPUP_MENU = 524288,
    SDL_WINDOW_VULKAN = 268435456,
};

pub const SDL_WindowEventID = extern enum(c_int) {
    SDL_WINDOWEVENT_NONE,
    SDL_WINDOWEVENT_SHOWN,
    SDL_WINDOWEVENT_HIDDEN,
    SDL_WINDOWEVENT_EXPOSED,
    SDL_WINDOWEVENT_MOVED,
    SDL_WINDOWEVENT_RESIZED,
    SDL_WINDOWEVENT_SIZE_CHANGED,
    SDL_WINDOWEVENT_MINIMIZED,
    SDL_WINDOWEVENT_MAXIMIZED,
    SDL_WINDOWEVENT_RESTORED,
    SDL_WINDOWEVENT_ENTER,
    SDL_WINDOWEVENT_LEAVE,
    SDL_WINDOWEVENT_FOCUS_GAINED,
    SDL_WINDOWEVENT_FOCUS_LOST,
    SDL_WINDOWEVENT_CLOSE,
    SDL_WINDOWEVENT_TAKE_FOCUS,
    SDL_WINDOWEVENT_HIT_TEST,
};

const SDL_DisplayEventID = extern enum(c_int) {
    SDL_DISPLAYEVENT_NONE,
    SDL_DISPLAYEVENT_ORIENTATION,
};

const SDL_DisplayOrientation = extern enum(c_int) {
    SDL_ORIENTATION_UNKNOWN,
    SDL_ORIENTATION_LANDSCAPE,
    SDL_ORIENTATION_LANDSCAPE_FLIPPED,
    SDL_ORIENTATION_PORTRAIT,
    SDL_ORIENTATION_PORTRAIT_FLIPPED,
};
pub const SDL_GLContext = ?*c_void;

const SDL_GLattr = extern enum(c_int) {
    SDL_GL_RED_SIZE,
    SDL_GL_GREEN_SIZE,
    SDL_GL_BLUE_SIZE,
    SDL_GL_ALPHA_SIZE,
    SDL_GL_BUFFER_SIZE,
    SDL_GL_DOUBLEBUFFER,
    SDL_GL_DEPTH_SIZE,
    SDL_GL_STENCIL_SIZE,
    SDL_GL_ACCUM_RED_SIZE,
    SDL_GL_ACCUM_GREEN_SIZE,
    SDL_GL_ACCUM_BLUE_SIZE,
    SDL_GL_ACCUM_ALPHA_SIZE,
    SDL_GL_STEREO,
    SDL_GL_MULTISAMPLEBUFFERS,
    SDL_GL_MULTISAMPLESAMPLES,
    SDL_GL_ACCELERATED_VISUAL,
    SDL_GL_RETAINED_BACKING,
    SDL_GL_CONTEXT_MAJOR_VERSION,
    SDL_GL_CONTEXT_MINOR_VERSION,
    SDL_GL_CONTEXT_EGL,
    SDL_GL_CONTEXT_FLAGS,
    SDL_GL_CONTEXT_PROFILE_MASK,
    SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
    SDL_GL_FRAMEBUFFER_SRGB_CAPABLE,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR,
    SDL_GL_CONTEXT_RESET_NOTIFICATION,
    SDL_GL_CONTEXT_NO_ERROR,
};

const SDL_GLprofile = extern enum(c_int) {
    SDL_GL_CONTEXT_PROFILE_CORE = 1,
    SDL_GL_CONTEXT_PROFILE_COMPATIBILITY = 2,
    SDL_GL_CONTEXT_PROFILE_ES = 4,
};

const enum_unnamed_46 = extern enum(c_int) {
    SDL_GL_CONTEXT_DEBUG_FLAG = 1,
    SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = 2,
    SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG = 4,
    SDL_GL_CONTEXT_RESET_ISOLATION_FLAG = 8,
    _,
};
pub const SDL_GLcontextFlag = enum_unnamed_46;
pub const SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = @enumToInt(enum_unnamed_47.SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE);
pub const SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = @enumToInt(enum_unnamed_47.SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH);
const enum_unnamed_47 = extern enum(c_int) {
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = 0,
    SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 1,
    _,
};
pub const SDL_GLcontextReleaseFlag = enum_unnamed_47;
pub const SDL_GL_CONTEXT_RESET_NO_NOTIFICATION = @enumToInt(enum_unnamed_48.SDL_GL_CONTEXT_RESET_NO_NOTIFICATION);
pub const SDL_GL_CONTEXT_RESET_LOSE_CONTEXT = @enumToInt(enum_unnamed_48.SDL_GL_CONTEXT_RESET_LOSE_CONTEXT);
const enum_unnamed_48 = extern enum(c_int) {
    SDL_GL_CONTEXT_RESET_NO_NOTIFICATION = 0,
    SDL_GL_CONTEXT_RESET_LOSE_CONTEXT = 1,
    _,
};
pub const SDL_GLContextResetNotification = enum_unnamed_48;
pub extern fn SDL_GetNumVideoDrivers() c_int;
pub extern fn SDL_GetVideoDriver(index: c_int) [*c]const u8;
pub extern fn SDL_VideoInit(driver_name: [*c]const u8) c_int;
pub extern fn SDL_VideoQuit() void;
pub extern fn SDL_GetCurrentVideoDriver() [*c]const u8;
pub extern fn SDL_GetNumVideoDisplays() c_int;
pub extern fn SDL_GetDisplayName(displayIndex: c_int) [*c]const u8;
pub extern fn SDL_GetDisplayBounds(displayIndex: c_int, rect: [*c]SDL_Rect) c_int;
pub extern fn SDL_GetDisplayUsableBounds(displayIndex: c_int, rect: [*c]SDL_Rect) c_int;
pub extern fn SDL_GetDisplayDPI(displayIndex: c_int, ddpi: [*c]f32, hdpi: [*c]f32, vdpi: [*c]f32) c_int;
pub extern fn SDL_GetDisplayOrientation(displayIndex: c_int) SDL_DisplayOrientation;
pub extern fn SDL_GetNumDisplayModes(displayIndex: c_int) c_int;
pub extern fn SDL_GetDisplayMode(displayIndex: c_int, modeIndex: c_int, mode: [*c]SDL_DisplayMode) c_int;
pub extern fn SDL_GetDesktopDisplayMode(displayIndex: c_int, mode: [*c]SDL_DisplayMode) c_int;
pub extern fn SDL_GetCurrentDisplayMode(displayIndex: c_int, mode: [*c]SDL_DisplayMode) c_int;
pub extern fn SDL_GetClosestDisplayMode(displayIndex: c_int, mode: [*c]const SDL_DisplayMode, closest: [*c]SDL_DisplayMode) [*c]SDL_DisplayMode;
pub extern fn SDL_GetWindowDisplayIndex(window: ?*SDL_Window) c_int;
pub extern fn SDL_SetWindowDisplayMode(window: ?*SDL_Window, mode: [*c]const SDL_DisplayMode) c_int;
pub extern fn SDL_GetWindowDisplayMode(window: ?*SDL_Window, mode: [*c]SDL_DisplayMode) c_int;
pub extern fn SDL_GetWindowPixelFormat(window: ?*SDL_Window) Uint32;
pub extern fn SDL_CreateWindow(title: [*c]const u8, x: c_int, y: c_int, w: c_int, h: c_int, flags: Uint32) ?*SDL_Window;
pub extern fn SDL_CreateWindowFrom(data: ?*const c_void) ?*SDL_Window;
pub extern fn SDL_GetWindowID(window: ?*SDL_Window) Uint32;
pub extern fn SDL_GetWindowFromID(id: Uint32) ?*SDL_Window;
pub extern fn SDL_GetWindowFlags(window: ?*SDL_Window) Uint32;
pub extern fn SDL_SetWindowTitle(window: ?*SDL_Window, title: [*c]const u8) void;
pub extern fn SDL_GetWindowTitle(window: ?*SDL_Window) [*c]const u8;
pub extern fn SDL_SetWindowIcon(window: ?*SDL_Window, icon: [*c]SDL_Surface) void;
pub extern fn SDL_SetWindowData(window: ?*SDL_Window, name: [*c]const u8, userdata: ?*c_void) ?*c_void;
pub extern fn SDL_GetWindowData(window: ?*SDL_Window, name: [*c]const u8) ?*c_void;
pub extern fn SDL_SetWindowPosition(window: ?*SDL_Window, x: c_int, y: c_int) void;
pub extern fn SDL_GetWindowPosition(window: ?*SDL_Window, x: [*c]c_int, y: [*c]c_int) void;
pub extern fn SDL_SetWindowSize(window: ?*SDL_Window, w: c_int, h: c_int) void;
pub extern fn SDL_GetWindowSize(window: ?*SDL_Window, w: [*c]c_int, h: [*c]c_int) void;
pub extern fn SDL_GetWindowBordersSize(window: ?*SDL_Window, top: [*c]c_int, left: [*c]c_int, bottom: [*c]c_int, right: [*c]c_int) c_int;
pub extern fn SDL_SetWindowMinimumSize(window: ?*SDL_Window, min_w: c_int, min_h: c_int) void;
pub extern fn SDL_GetWindowMinimumSize(window: ?*SDL_Window, w: [*c]c_int, h: [*c]c_int) void;
pub extern fn SDL_SetWindowMaximumSize(window: ?*SDL_Window, max_w: c_int, max_h: c_int) void;
pub extern fn SDL_GetWindowMaximumSize(window: ?*SDL_Window, w: [*c]c_int, h: [*c]c_int) void;
pub extern fn SDL_SetWindowBordered(window: ?*SDL_Window, bordered: SDL_bool) void;
pub extern fn SDL_SetWindowResizable(window: ?*SDL_Window, resizable: SDL_bool) void;
pub extern fn SDL_ShowWindow(window: ?*SDL_Window) void;
pub extern fn SDL_HideWindow(window: ?*SDL_Window) void;
pub extern fn SDL_RaiseWindow(window: ?*SDL_Window) void;
pub extern fn SDL_MaximizeWindow(window: ?*SDL_Window) void;
pub extern fn SDL_MinimizeWindow(window: ?*SDL_Window) void;
pub extern fn SDL_RestoreWindow(window: ?*SDL_Window) void;
pub extern fn SDL_SetWindowFullscreen(window: ?*SDL_Window, flags: Uint32) c_int;
pub extern fn SDL_GetWindowSurface(window: ?*SDL_Window) [*c]SDL_Surface;
pub extern fn SDL_UpdateWindowSurface(window: ?*SDL_Window) c_int;
pub extern fn SDL_UpdateWindowSurfaceRects(window: ?*SDL_Window, rects: [*c]const SDL_Rect, numrects: c_int) c_int;
pub extern fn SDL_SetWindowGrab(window: ?*SDL_Window, grabbed: SDL_bool) void;
pub extern fn SDL_GetWindowGrab(window: ?*SDL_Window) SDL_bool;
pub extern fn SDL_GetGrabbedWindow() ?*SDL_Window;
pub extern fn SDL_SetWindowBrightness(window: ?*SDL_Window, brightness: f32) c_int;
pub extern fn SDL_GetWindowBrightness(window: ?*SDL_Window) f32;
pub extern fn SDL_SetWindowOpacity(window: ?*SDL_Window, opacity: f32) c_int;
pub extern fn SDL_GetWindowOpacity(window: ?*SDL_Window, out_opacity: [*c]f32) c_int;
pub extern fn SDL_SetWindowModalFor(modal_window: ?*SDL_Window, parent_window: ?*SDL_Window) c_int;
pub extern fn SDL_SetWindowInputFocus(window: ?*SDL_Window) c_int;
pub extern fn SDL_SetWindowGammaRamp(window: ?*SDL_Window, red: [*c]const Uint16, green: [*c]const Uint16, blue: [*c]const Uint16) c_int;
pub extern fn SDL_GetWindowGammaRamp(window: ?*SDL_Window, red: [*c]Uint16, green: [*c]Uint16, blue: [*c]Uint16) c_int;

const enum_unnamed_49 = extern enum(c_int) {
    SDL_HITTEST_NORMAL,
    SDL_HITTEST_DRAGGABLE,
    SDL_HITTEST_RESIZE_TOPLEFT,
    SDL_HITTEST_RESIZE_TOP,
    SDL_HITTEST_RESIZE_TOPRIGHT,
    SDL_HITTEST_RESIZE_RIGHT,
    SDL_HITTEST_RESIZE_BOTTOMRIGHT,
    SDL_HITTEST_RESIZE_BOTTOM,
    SDL_HITTEST_RESIZE_BOTTOMLEFT,
    SDL_HITTEST_RESIZE_LEFT,
    _,
};
pub const SDL_HitTestResult = enum_unnamed_49;
pub const SDL_HitTest = ?fn (?*SDL_Window, [*c]const SDL_Point, ?*c_void) callconv(.C) SDL_HitTestResult;
pub extern fn SDL_SetWindowHitTest(window: ?*SDL_Window, callback: SDL_HitTest, callback_data: ?*c_void) c_int;
pub extern fn SDL_DestroyWindow(window: ?*SDL_Window) void;
pub extern fn SDL_IsScreenSaverEnabled() SDL_bool;
pub extern fn SDL_EnableScreenSaver() void;
pub extern fn SDL_DisableScreenSaver() void;
pub extern fn SDL_GL_LoadLibrary(path: [*c]const u8) c_int;
pub extern fn SDL_GL_GetProcAddress(proc: [*c]const u8) ?*c_void;
pub extern fn SDL_GL_UnloadLibrary() void;
pub extern fn SDL_GL_ExtensionSupported(extension: [*c]const u8) SDL_bool;
pub extern fn SDL_GL_ResetAttributes() void;
pub extern fn SDL_GL_SetAttribute(attr: SDL_GLattr, value: c_int) c_int;
pub extern fn SDL_GL_GetAttribute(attr: SDL_GLattr, value: [*c]c_int) c_int;
pub extern fn SDL_GL_CreateContext(window: ?*SDL_Window) SDL_GLContext;
pub extern fn SDL_GL_MakeCurrent(window: ?*SDL_Window, context: SDL_GLContext) c_int;
pub extern fn SDL_GL_GetCurrentWindow() ?*SDL_Window;
pub extern fn SDL_GL_GetCurrentContext() SDL_GLContext;
pub extern fn SDL_GL_GetDrawableSize(window: ?*SDL_Window, w: [*c]c_int, h: [*c]c_int) void;
pub extern fn SDL_GL_SetSwapInterval(interval: c_int) c_int;
pub extern fn SDL_GL_GetSwapInterval() c_int;
pub extern fn SDL_GL_SwapWindow(window: ?*SDL_Window) void;
pub extern fn SDL_GL_DeleteContext(context: SDL_GLContext) void;

pub const SDL_Scancode = extern enum(c_int) {
    SDL_SCANCODE_UNKNOWN = 0,
    SDL_SCANCODE_A = 4,
    SDL_SCANCODE_B = 5,
    SDL_SCANCODE_C = 6,
    SDL_SCANCODE_D = 7,
    SDL_SCANCODE_E = 8,
    SDL_SCANCODE_F = 9,
    SDL_SCANCODE_G = 10,
    SDL_SCANCODE_H = 11,
    SDL_SCANCODE_I = 12,
    SDL_SCANCODE_J = 13,
    SDL_SCANCODE_K = 14,
    SDL_SCANCODE_L = 15,
    SDL_SCANCODE_M = 16,
    SDL_SCANCODE_N = 17,
    SDL_SCANCODE_O = 18,
    SDL_SCANCODE_P = 19,
    SDL_SCANCODE_Q = 20,
    SDL_SCANCODE_R = 21,
    SDL_SCANCODE_S = 22,
    SDL_SCANCODE_T = 23,
    SDL_SCANCODE_U = 24,
    SDL_SCANCODE_V = 25,
    SDL_SCANCODE_W = 26,
    SDL_SCANCODE_X = 27,
    SDL_SCANCODE_Y = 28,
    SDL_SCANCODE_Z = 29,
    SDL_SCANCODE_1 = 30,
    SDL_SCANCODE_2 = 31,
    SDL_SCANCODE_3 = 32,
    SDL_SCANCODE_4 = 33,
    SDL_SCANCODE_5 = 34,
    SDL_SCANCODE_6 = 35,
    SDL_SCANCODE_7 = 36,
    SDL_SCANCODE_8 = 37,
    SDL_SCANCODE_9 = 38,
    SDL_SCANCODE_0 = 39,
    SDL_SCANCODE_RETURN = 40,
    SDL_SCANCODE_ESCAPE = 41,
    SDL_SCANCODE_BACKSPACE = 42,
    SDL_SCANCODE_TAB = 43,
    SDL_SCANCODE_SPACE = 44,
    SDL_SCANCODE_MINUS = 45,
    SDL_SCANCODE_EQUALS = 46,
    SDL_SCANCODE_LEFTBRACKET = 47,
    SDL_SCANCODE_RIGHTBRACKET = 48,
    SDL_SCANCODE_BACKSLASH = 49,
    SDL_SCANCODE_NONUSHASH = 50,
    SDL_SCANCODE_SEMICOLON = 51,
    SDL_SCANCODE_APOSTROPHE = 52,
    SDL_SCANCODE_GRAVE = 53,
    SDL_SCANCODE_COMMA = 54,
    SDL_SCANCODE_PERIOD = 55,
    SDL_SCANCODE_SLASH = 56,
    SDL_SCANCODE_CAPSLOCK = 57,
    SDL_SCANCODE_F1 = 58,
    SDL_SCANCODE_F2 = 59,
    SDL_SCANCODE_F3 = 60,
    SDL_SCANCODE_F4 = 61,
    SDL_SCANCODE_F5 = 62,
    SDL_SCANCODE_F6 = 63,
    SDL_SCANCODE_F7 = 64,
    SDL_SCANCODE_F8 = 65,
    SDL_SCANCODE_F9 = 66,
    SDL_SCANCODE_F10 = 67,
    SDL_SCANCODE_F11 = 68,
    SDL_SCANCODE_F12 = 69,
    SDL_SCANCODE_PRINTSCREEN = 70,
    SDL_SCANCODE_SCROLLLOCK = 71,
    SDL_SCANCODE_PAUSE = 72,
    SDL_SCANCODE_INSERT = 73,
    SDL_SCANCODE_HOME = 74,
    SDL_SCANCODE_PAGEUP = 75,
    SDL_SCANCODE_DELETE = 76,
    SDL_SCANCODE_END = 77,
    SDL_SCANCODE_PAGEDOWN = 78,
    SDL_SCANCODE_RIGHT = 79,
    SDL_SCANCODE_LEFT = 80,
    SDL_SCANCODE_DOWN = 81,
    SDL_SCANCODE_UP = 82,
    SDL_SCANCODE_NUMLOCKCLEAR = 83,
    SDL_SCANCODE_KP_DIVIDE = 84,
    SDL_SCANCODE_KP_MULTIPLY = 85,
    SDL_SCANCODE_KP_MINUS = 86,
    SDL_SCANCODE_KP_PLUS = 87,
    SDL_SCANCODE_KP_ENTER = 88,
    SDL_SCANCODE_KP_1 = 89,
    SDL_SCANCODE_KP_2 = 90,
    SDL_SCANCODE_KP_3 = 91,
    SDL_SCANCODE_KP_4 = 92,
    SDL_SCANCODE_KP_5 = 93,
    SDL_SCANCODE_KP_6 = 94,
    SDL_SCANCODE_KP_7 = 95,
    SDL_SCANCODE_KP_8 = 96,
    SDL_SCANCODE_KP_9 = 97,
    SDL_SCANCODE_KP_0 = 98,
    SDL_SCANCODE_KP_PERIOD = 99,
    SDL_SCANCODE_NONUSBACKSLASH = 100,
    SDL_SCANCODE_APPLICATION = 101,
    SDL_SCANCODE_POWER = 102,
    SDL_SCANCODE_KP_EQUALS = 103,
    SDL_SCANCODE_F13 = 104,
    SDL_SCANCODE_F14 = 105,
    SDL_SCANCODE_F15 = 106,
    SDL_SCANCODE_F16 = 107,
    SDL_SCANCODE_F17 = 108,
    SDL_SCANCODE_F18 = 109,
    SDL_SCANCODE_F19 = 110,
    SDL_SCANCODE_F20 = 111,
    SDL_SCANCODE_F21 = 112,
    SDL_SCANCODE_F22 = 113,
    SDL_SCANCODE_F23 = 114,
    SDL_SCANCODE_F24 = 115,
    SDL_SCANCODE_EXECUTE = 116,
    SDL_SCANCODE_HELP = 117,
    SDL_SCANCODE_MENU = 118,
    SDL_SCANCODE_SELECT = 119,
    SDL_SCANCODE_STOP = 120,
    SDL_SCANCODE_AGAIN = 121,
    SDL_SCANCODE_UNDO = 122,
    SDL_SCANCODE_CUT = 123,
    SDL_SCANCODE_COPY = 124,
    SDL_SCANCODE_PASTE = 125,
    SDL_SCANCODE_FIND = 126,
    SDL_SCANCODE_MUTE = 127,
    SDL_SCANCODE_VOLUMEUP = 128,
    SDL_SCANCODE_VOLUMEDOWN = 129,
    SDL_SCANCODE_KP_COMMA = 133,
    SDL_SCANCODE_KP_EQUALSAS400 = 134,
    SDL_SCANCODE_INTERNATIONAL1 = 135,
    SDL_SCANCODE_INTERNATIONAL2 = 136,
    SDL_SCANCODE_INTERNATIONAL3 = 137,
    SDL_SCANCODE_INTERNATIONAL4 = 138,
    SDL_SCANCODE_INTERNATIONAL5 = 139,
    SDL_SCANCODE_INTERNATIONAL6 = 140,
    SDL_SCANCODE_INTERNATIONAL7 = 141,
    SDL_SCANCODE_INTERNATIONAL8 = 142,
    SDL_SCANCODE_INTERNATIONAL9 = 143,
    SDL_SCANCODE_LANG1 = 144,
    SDL_SCANCODE_LANG2 = 145,
    SDL_SCANCODE_LANG3 = 146,
    SDL_SCANCODE_LANG4 = 147,
    SDL_SCANCODE_LANG5 = 148,
    SDL_SCANCODE_LANG6 = 149,
    SDL_SCANCODE_LANG7 = 150,
    SDL_SCANCODE_LANG8 = 151,
    SDL_SCANCODE_LANG9 = 152,
    SDL_SCANCODE_ALTERASE = 153,
    SDL_SCANCODE_SYSREQ = 154,
    SDL_SCANCODE_CANCEL = 155,
    SDL_SCANCODE_CLEAR = 156,
    SDL_SCANCODE_PRIOR = 157,
    SDL_SCANCODE_RETURN2 = 158,
    SDL_SCANCODE_SEPARATOR = 159,
    SDL_SCANCODE_OUT = 160,
    SDL_SCANCODE_OPER = 161,
    SDL_SCANCODE_CLEARAGAIN = 162,
    SDL_SCANCODE_CRSEL = 163,
    SDL_SCANCODE_EXSEL = 164,
    SDL_SCANCODE_KP_00 = 176,
    SDL_SCANCODE_KP_000 = 177,
    SDL_SCANCODE_THOUSANDSSEPARATOR = 178,
    SDL_SCANCODE_DECIMALSEPARATOR = 179,
    SDL_SCANCODE_CURRENCYUNIT = 180,
    SDL_SCANCODE_CURRENCYSUBUNIT = 181,
    SDL_SCANCODE_KP_LEFTPAREN = 182,
    SDL_SCANCODE_KP_RIGHTPAREN = 183,
    SDL_SCANCODE_KP_LEFTBRACE = 184,
    SDL_SCANCODE_KP_RIGHTBRACE = 185,
    SDL_SCANCODE_KP_TAB = 186,
    SDL_SCANCODE_KP_BACKSPACE = 187,
    SDL_SCANCODE_KP_A = 188,
    SDL_SCANCODE_KP_B = 189,
    SDL_SCANCODE_KP_C = 190,
    SDL_SCANCODE_KP_D = 191,
    SDL_SCANCODE_KP_E = 192,
    SDL_SCANCODE_KP_F = 193,
    SDL_SCANCODE_KP_XOR = 194,
    SDL_SCANCODE_KP_POWER = 195,
    SDL_SCANCODE_KP_PERCENT = 196,
    SDL_SCANCODE_KP_LESS = 197,
    SDL_SCANCODE_KP_GREATER = 198,
    SDL_SCANCODE_KP_AMPERSAND = 199,
    SDL_SCANCODE_KP_DBLAMPERSAND = 200,
    SDL_SCANCODE_KP_VERTICALBAR = 201,
    SDL_SCANCODE_KP_DBLVERTICALBAR = 202,
    SDL_SCANCODE_KP_COLON = 203,
    SDL_SCANCODE_KP_HASH = 204,
    SDL_SCANCODE_KP_SPACE = 205,
    SDL_SCANCODE_KP_AT = 206,
    SDL_SCANCODE_KP_EXCLAM = 207,
    SDL_SCANCODE_KP_MEMSTORE = 208,
    SDL_SCANCODE_KP_MEMRECALL = 209,
    SDL_SCANCODE_KP_MEMCLEAR = 210,
    SDL_SCANCODE_KP_MEMADD = 211,
    SDL_SCANCODE_KP_MEMSUBTRACT = 212,
    SDL_SCANCODE_KP_MEMMULTIPLY = 213,
    SDL_SCANCODE_KP_MEMDIVIDE = 214,
    SDL_SCANCODE_KP_PLUSMINUS = 215,
    SDL_SCANCODE_KP_CLEAR = 216,
    SDL_SCANCODE_KP_CLEARENTRY = 217,
    SDL_SCANCODE_KP_BINARY = 218,
    SDL_SCANCODE_KP_OCTAL = 219,
    SDL_SCANCODE_KP_DECIMAL = 220,
    SDL_SCANCODE_KP_HEXADECIMAL = 221,
    SDL_SCANCODE_LCTRL = 224,
    SDL_SCANCODE_LSHIFT = 225,
    SDL_SCANCODE_LALT = 226,
    SDL_SCANCODE_LGUI = 227,
    SDL_SCANCODE_RCTRL = 228,
    SDL_SCANCODE_RSHIFT = 229,
    SDL_SCANCODE_RALT = 230,
    SDL_SCANCODE_RGUI = 231,
    SDL_SCANCODE_MODE = 257,
    SDL_SCANCODE_AUDIONEXT = 258,
    SDL_SCANCODE_AUDIOPREV = 259,
    SDL_SCANCODE_AUDIOSTOP = 260,
    SDL_SCANCODE_AUDIOPLAY = 261,
    SDL_SCANCODE_AUDIOMUTE = 262,
    SDL_SCANCODE_MEDIASELECT = 263,
    SDL_SCANCODE_WWW = 264,
    SDL_SCANCODE_MAIL = 265,
    SDL_SCANCODE_CALCULATOR = 266,
    SDL_SCANCODE_COMPUTER = 267,
    SDL_SCANCODE_AC_SEARCH = 268,
    SDL_SCANCODE_AC_HOME = 269,
    SDL_SCANCODE_AC_BACK = 270,
    SDL_SCANCODE_AC_FORWARD = 271,
    SDL_SCANCODE_AC_STOP = 272,
    SDL_SCANCODE_AC_REFRESH = 273,
    SDL_SCANCODE_AC_BOOKMARKS = 274,
    SDL_SCANCODE_BRIGHTNESSDOWN = 275,
    SDL_SCANCODE_BRIGHTNESSUP = 276,
    SDL_SCANCODE_DISPLAYSWITCH = 277,
    SDL_SCANCODE_KBDILLUMTOGGLE = 278,
    SDL_SCANCODE_KBDILLUMDOWN = 279,
    SDL_SCANCODE_KBDILLUMUP = 280,
    SDL_SCANCODE_EJECT = 281,
    SDL_SCANCODE_SLEEP = 282,
    SDL_SCANCODE_APP1 = 283,
    SDL_SCANCODE_APP2 = 284,
    SDL_SCANCODE_AUDIOREWIND = 285,
    SDL_SCANCODE_AUDIOFASTFORWARD = 286,
    SDL_NUM_SCANCODES = 512,
};

pub const SDL_Keycode = i32;

const SDL_KeyCode = extern enum(c_int) {
    SDLK_UNKNOWN = 0,
    SDLK_RETURN = 13,
    SDLK_ESCAPE = 27,
    SDLK_BACKSPACE = 8,
    SDLK_TAB = 9,
    SDLK_SPACE = 32,
    SDLK_EXCLAIM = 33,
    SDLK_QUOTEDBL = 34,
    SDLK_HASH = 35,
    SDLK_PERCENT = 37,
    SDLK_DOLLAR = 36,
    SDLK_AMPERSAND = 38,
    SDLK_QUOTE = 39,
    SDLK_LEFTPAREN = 40,
    SDLK_RIGHTPAREN = 41,
    SDLK_ASTERISK = 42,
    SDLK_PLUS = 43,
    SDLK_COMMA = 44,
    SDLK_MINUS = 45,
    SDLK_PERIOD = 46,
    SDLK_SLASH = 47,
    SDLK_0 = 48,
    SDLK_1 = 49,
    SDLK_2 = 50,
    SDLK_3 = 51,
    SDLK_4 = 52,
    SDLK_5 = 53,
    SDLK_6 = 54,
    SDLK_7 = 55,
    SDLK_8 = 56,
    SDLK_9 = 57,
    SDLK_COLON = 58,
    SDLK_SEMICOLON = 59,
    SDLK_LESS = 60,
    SDLK_EQUALS = 61,
    SDLK_GREATER = 62,
    SDLK_QUESTION = 63,
    SDLK_AT = 64,
    SDLK_LEFTBRACKET = 91,
    SDLK_BACKSLASH = 92,
    SDLK_RIGHTBRACKET = 93,
    SDLK_CARET = 94,
    SDLK_UNDERSCORE = 95,
    SDLK_BACKQUOTE = 96,
    SDLK_a = 97,
    SDLK_b = 98,
    SDLK_c = 99,
    SDLK_d = 100,
    SDLK_e = 101,
    SDLK_f = 102,
    SDLK_g = 103,
    SDLK_h = 104,
    SDLK_i = 105,
    SDLK_j = 106,
    SDLK_k = 107,
    SDLK_l = 108,
    SDLK_m = 109,
    SDLK_n = 110,
    SDLK_o = 111,
    SDLK_p = 112,
    SDLK_q = 113,
    SDLK_r = 114,
    SDLK_s = 115,
    SDLK_t = 116,
    SDLK_u = 117,
    SDLK_v = 118,
    SDLK_w = 119,
    SDLK_x = 120,
    SDLK_y = 121,
    SDLK_z = 122,
    SDLK_CAPSLOCK = 1073741881,
    SDLK_F1 = 1073741882,
    SDLK_F2 = 1073741883,
    SDLK_F3 = 1073741884,
    SDLK_F4 = 1073741885,
    SDLK_F5 = 1073741886,
    SDLK_F6 = 1073741887,
    SDLK_F7 = 1073741888,
    SDLK_F8 = 1073741889,
    SDLK_F9 = 1073741890,
    SDLK_F10 = 1073741891,
    SDLK_F11 = 1073741892,
    SDLK_F12 = 1073741893,
    SDLK_PRINTSCREEN = 1073741894,
    SDLK_SCROLLLOCK = 1073741895,
    SDLK_PAUSE = 1073741896,
    SDLK_INSERT = 1073741897,
    SDLK_HOME = 1073741898,
    SDLK_PAGEUP = 1073741899,
    SDLK_DELETE = 127,
    SDLK_END = 1073741901,
    SDLK_PAGEDOWN = 1073741902,
    SDLK_RIGHT = 1073741903,
    SDLK_LEFT = 1073741904,
    SDLK_DOWN = 1073741905,
    SDLK_UP = 1073741906,
    SDLK_NUMLOCKCLEAR = 1073741907,
    SDLK_KP_DIVIDE = 1073741908,
    SDLK_KP_MULTIPLY = 1073741909,
    SDLK_KP_MINUS = 1073741910,
    SDLK_KP_PLUS = 1073741911,
    SDLK_KP_ENTER = 1073741912,
    SDLK_KP_1 = 1073741913,
    SDLK_KP_2 = 1073741914,
    SDLK_KP_3 = 1073741915,
    SDLK_KP_4 = 1073741916,
    SDLK_KP_5 = 1073741917,
    SDLK_KP_6 = 1073741918,
    SDLK_KP_7 = 1073741919,
    SDLK_KP_8 = 1073741920,
    SDLK_KP_9 = 1073741921,
    SDLK_KP_0 = 1073741922,
    SDLK_KP_PERIOD = 1073741923,
    SDLK_APPLICATION = 1073741925,
    SDLK_POWER = 1073741926,
    SDLK_KP_EQUALS = 1073741927,
    SDLK_F13 = 1073741928,
    SDLK_F14 = 1073741929,
    SDLK_F15 = 1073741930,
    SDLK_F16 = 1073741931,
    SDLK_F17 = 1073741932,
    SDLK_F18 = 1073741933,
    SDLK_F19 = 1073741934,
    SDLK_F20 = 1073741935,
    SDLK_F21 = 1073741936,
    SDLK_F22 = 1073741937,
    SDLK_F23 = 1073741938,
    SDLK_F24 = 1073741939,
    SDLK_EXECUTE = 1073741940,
    SDLK_HELP = 1073741941,
    SDLK_MENU = 1073741942,
    SDLK_SELECT = 1073741943,
    SDLK_STOP = 1073741944,
    SDLK_AGAIN = 1073741945,
    SDLK_UNDO = 1073741946,
    SDLK_CUT = 1073741947,
    SDLK_COPY = 1073741948,
    SDLK_PASTE = 1073741949,
    SDLK_FIND = 1073741950,
    SDLK_MUTE = 1073741951,
    SDLK_VOLUMEUP = 1073741952,
    SDLK_VOLUMEDOWN = 1073741953,
    SDLK_KP_COMMA = 1073741957,
    SDLK_KP_EQUALSAS400 = 1073741958,
    SDLK_ALTERASE = 1073741977,
    SDLK_SYSREQ = 1073741978,
    SDLK_CANCEL = 1073741979,
    SDLK_CLEAR = 1073741980,
    SDLK_PRIOR = 1073741981,
    SDLK_RETURN2 = 1073741982,
    SDLK_SEPARATOR = 1073741983,
    SDLK_OUT = 1073741984,
    SDLK_OPER = 1073741985,
    SDLK_CLEARAGAIN = 1073741986,
    SDLK_CRSEL = 1073741987,
    SDLK_EXSEL = 1073741988,
    SDLK_KP_00 = 1073742000,
    SDLK_KP_000 = 1073742001,
    SDLK_THOUSANDSSEPARATOR = 1073742002,
    SDLK_DECIMALSEPARATOR = 1073742003,
    SDLK_CURRENCYUNIT = 1073742004,
    SDLK_CURRENCYSUBUNIT = 1073742005,
    SDLK_KP_LEFTPAREN = 1073742006,
    SDLK_KP_RIGHTPAREN = 1073742007,
    SDLK_KP_LEFTBRACE = 1073742008,
    SDLK_KP_RIGHTBRACE = 1073742009,
    SDLK_KP_TAB = 1073742010,
    SDLK_KP_BACKSPACE = 1073742011,
    SDLK_KP_A = 1073742012,
    SDLK_KP_B = 1073742013,
    SDLK_KP_C = 1073742014,
    SDLK_KP_D = 1073742015,
    SDLK_KP_E = 1073742016,
    SDLK_KP_F = 1073742017,
    SDLK_KP_XOR = 1073742018,
    SDLK_KP_POWER = 1073742019,
    SDLK_KP_PERCENT = 1073742020,
    SDLK_KP_LESS = 1073742021,
    SDLK_KP_GREATER = 1073742022,
    SDLK_KP_AMPERSAND = 1073742023,
    SDLK_KP_DBLAMPERSAND = 1073742024,
    SDLK_KP_VERTICALBAR = 1073742025,
    SDLK_KP_DBLVERTICALBAR = 1073742026,
    SDLK_KP_COLON = 1073742027,
    SDLK_KP_HASH = 1073742028,
    SDLK_KP_SPACE = 1073742029,
    SDLK_KP_AT = 1073742030,
    SDLK_KP_EXCLAM = 1073742031,
    SDLK_KP_MEMSTORE = 1073742032,
    SDLK_KP_MEMRECALL = 1073742033,
    SDLK_KP_MEMCLEAR = 1073742034,
    SDLK_KP_MEMADD = 1073742035,
    SDLK_KP_MEMSUBTRACT = 1073742036,
    SDLK_KP_MEMMULTIPLY = 1073742037,
    SDLK_KP_MEMDIVIDE = 1073742038,
    SDLK_KP_PLUSMINUS = 1073742039,
    SDLK_KP_CLEAR = 1073742040,
    SDLK_KP_CLEARENTRY = 1073742041,
    SDLK_KP_BINARY = 1073742042,
    SDLK_KP_OCTAL = 1073742043,
    SDLK_KP_DECIMAL = 1073742044,
    SDLK_KP_HEXADECIMAL = 1073742045,
    SDLK_LCTRL = 1073742048,
    SDLK_LSHIFT = 1073742049,
    SDLK_LALT = 1073742050,
    SDLK_LGUI = 1073742051,
    SDLK_RCTRL = 1073742052,
    SDLK_RSHIFT = 1073742053,
    SDLK_RALT = 1073742054,
    SDLK_RGUI = 1073742055,
    SDLK_MODE = 1073742081,
    SDLK_AUDIONEXT = 1073742082,
    SDLK_AUDIOPREV = 1073742083,
    SDLK_AUDIOSTOP = 1073742084,
    SDLK_AUDIOPLAY = 1073742085,
    SDLK_AUDIOMUTE = 1073742086,
    SDLK_MEDIASELECT = 1073742087,
    SDLK_WWW = 1073742088,
    SDLK_MAIL = 1073742089,
    SDLK_CALCULATOR = 1073742090,
    SDLK_COMPUTER = 1073742091,
    SDLK_AC_SEARCH = 1073742092,
    SDLK_AC_HOME = 1073742093,
    SDLK_AC_BACK = 1073742094,
    SDLK_AC_FORWARD = 1073742095,
    SDLK_AC_STOP = 1073742096,
    SDLK_AC_REFRESH = 1073742097,
    SDLK_AC_BOOKMARKS = 1073742098,
    SDLK_BRIGHTNESSDOWN = 1073742099,
    SDLK_BRIGHTNESSUP = 1073742100,
    SDLK_DISPLAYSWITCH = 1073742101,
    SDLK_KBDILLUMTOGGLE = 1073742102,
    SDLK_KBDILLUMDOWN = 1073742103,
    SDLK_KBDILLUMUP = 1073742104,
    SDLK_EJECT = 1073742105,
    SDLK_SLEEP = 1073742106,
    SDLK_APP1 = 1073742107,
    SDLK_APP2 = 1073742108,
    SDLK_AUDIOREWIND = 1073742109,
    SDLK_AUDIOFASTFORWARD = 1073742110,
};

pub const SDL_Keymod = extern enum(c_int) {
    KMOD_NONE = 0,
    KMOD_LSHIFT = 1,
    KMOD_RSHIFT = 2,
    KMOD_LCTRL = 64,
    KMOD_RCTRL = 128,
    KMOD_LALT = 256,
    KMOD_RALT = 512,
    KMOD_LGUI = 1024,
    KMOD_RGUI = 2048,
    KMOD_NUM = 4096,
    KMOD_CAPS = 8192,
    KMOD_MODE = 16384,
    KMOD_RESERVED = 32768,
    shift = 1 | 2,
    alt = 256 | 512,
    ctrl = 64 | 128,
    gui = 1024 | 2048,
};

pub const SDL_Keysym = extern struct {
    scancode: SDL_Scancode,
    sym: SDL_Keycode,
    mod: Uint16,
    unused: Uint32,
};

pub extern fn SDL_GetKeyboardFocus() ?*SDL_Window;
pub extern fn SDL_GetKeyboardState(numkeys: [*c]c_int) [*c]const Uint8;
pub extern fn SDL_GetModState() SDL_Keymod;
pub extern fn SDL_SetModState(modstate: SDL_Keymod) void;
pub extern fn SDL_GetKeyFromScancode(scancode: SDL_Scancode) SDL_Keycode;
pub extern fn SDL_GetScancodeFromKey(key: SDL_Keycode) SDL_Scancode;
pub extern fn SDL_GetScancodeName(scancode: SDL_Scancode) [*c]const u8;
pub extern fn SDL_GetScancodeFromName(name: [*c]const u8) SDL_Scancode;
pub extern fn SDL_GetKeyName(key: SDL_Keycode) [*c]const u8;
pub extern fn SDL_GetKeyFromName(name: [*c]const u8) SDL_Keycode;
pub extern fn SDL_StartTextInput() void;
pub extern fn SDL_IsTextInputActive() SDL_bool;
pub extern fn SDL_StopTextInput() void;
pub extern fn SDL_SetTextInputRect(rect: [*c]SDL_Rect) void;
pub extern fn SDL_HasScreenKeyboardSupport() SDL_bool;
pub extern fn SDL_IsScreenKeyboardShown(window: ?*SDL_Window) SDL_bool;
pub const struct_SDL_Cursor = @Type(.Opaque);
pub const SDL_Cursor = struct_SDL_Cursor;

pub const SDL_SystemCursor = extern enum(c_int) {
    SDL_SYSTEM_CURSOR_ARROW,
    SDL_SYSTEM_CURSOR_IBEAM,
    SDL_SYSTEM_CURSOR_WAIT,
    SDL_SYSTEM_CURSOR_CROSSHAIR,
    SDL_SYSTEM_CURSOR_WAITARROW,
    SDL_SYSTEM_CURSOR_SIZENWSE,
    SDL_SYSTEM_CURSOR_SIZENESW,
    SDL_SYSTEM_CURSOR_SIZEWE,
    SDL_SYSTEM_CURSOR_SIZENS,
    SDL_SYSTEM_CURSOR_SIZEALL,
    SDL_SYSTEM_CURSOR_NO,
    SDL_SYSTEM_CURSOR_HAND,
    SDL_NUM_SYSTEM_CURSORS,
};

pub const SDL_MouseWheelDirection = extern enum(c_int) {
    SDL_MOUSEWHEEL_NORMAL,
    SDL_MOUSEWHEEL_FLIPPED,
};

pub extern fn SDL_GetMouseFocus() ?*SDL_Window;
pub extern fn SDL_GetMouseState(x: [*c]c_int, y: [*c]c_int) Uint32;
pub extern fn SDL_GetGlobalMouseState(x: [*c]c_int, y: [*c]c_int) Uint32;
pub extern fn SDL_GetRelativeMouseState(x: [*c]c_int, y: [*c]c_int) Uint32;
pub extern fn SDL_WarpMouseInWindow(window: ?*SDL_Window, x: c_int, y: c_int) void;
pub extern fn SDL_WarpMouseGlobal(x: c_int, y: c_int) c_int;
pub extern fn SDL_SetRelativeMouseMode(enabled: SDL_bool) c_int;
pub extern fn SDL_CaptureMouse(enabled: SDL_bool) c_int;
pub extern fn SDL_GetRelativeMouseMode() SDL_bool;
pub extern fn SDL_CreateCursor(data: [*c]const Uint8, mask: [*c]const Uint8, w: c_int, h: c_int, hot_x: c_int, hot_y: c_int) ?*SDL_Cursor;
pub extern fn SDL_CreateColorCursor(surface: [*c]SDL_Surface, hot_x: c_int, hot_y: c_int) ?*SDL_Cursor;
pub extern fn SDL_CreateSystemCursor(id: SDL_SystemCursor) ?*SDL_Cursor;
pub extern fn SDL_SetCursor(cursor: ?*SDL_Cursor) void;
pub extern fn SDL_GetCursor() ?*SDL_Cursor;
pub extern fn SDL_GetDefaultCursor() ?*SDL_Cursor;
pub extern fn SDL_FreeCursor(cursor: ?*SDL_Cursor) void;
pub extern fn SDL_ShowCursor(toggle: c_int) c_int;
pub const struct__SDL_Joystick = @Type(.Opaque);
pub const SDL_Joystick = struct__SDL_Joystick;
pub const struct_unnamed_55 = extern struct {
    data: [16]Uint8,
};
pub const SDL_JoystickGUID = struct_unnamed_55;
pub const SDL_JoystickID = i32;

pub const SDL_JoystickType = extern enum(c_int) {
    SDL_JOYSTICK_TYPE_UNKNOWN,
    SDL_JOYSTICK_TYPE_GAMECONTROLLER,
    SDL_JOYSTICK_TYPE_WHEEL,
    SDL_JOYSTICK_TYPE_ARCADE_STICK,
    SDL_JOYSTICK_TYPE_FLIGHT_STICK,
    SDL_JOYSTICK_TYPE_DANCE_PAD,
    SDL_JOYSTICK_TYPE_GUITAR,
    SDL_JOYSTICK_TYPE_DRUM_KIT,
    SDL_JOYSTICK_TYPE_ARCADE_PAD,
    SDL_JOYSTICK_TYPE_THROTTLE,
};

pub const SDL_JOYSTICK_POWER_UNKNOWN = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_UNKNOWN);
pub const SDL_JOYSTICK_POWER_EMPTY = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_EMPTY);
pub const SDL_JOYSTICK_POWER_LOW = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_LOW);
pub const SDL_JOYSTICK_POWER_MEDIUM = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_MEDIUM);
pub const SDL_JOYSTICK_POWER_FULL = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_FULL);
pub const SDL_JOYSTICK_POWER_WIRED = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_WIRED);
pub const SDL_JOYSTICK_POWER_MAX = @enumToInt(enum_unnamed_57.SDL_JOYSTICK_POWER_MAX);
const enum_unnamed_57 = extern enum(c_int) {
    SDL_JOYSTICK_POWER_UNKNOWN = -1,
    SDL_JOYSTICK_POWER_EMPTY = 0,
    SDL_JOYSTICK_POWER_LOW = 1,
    SDL_JOYSTICK_POWER_MEDIUM = 2,
    SDL_JOYSTICK_POWER_FULL = 3,
    SDL_JOYSTICK_POWER_WIRED = 4,
    SDL_JOYSTICK_POWER_MAX = 5,
    _,
};
pub const SDL_JoystickPowerLevel = enum_unnamed_57;
pub extern fn SDL_LockJoysticks() void;
pub extern fn SDL_UnlockJoysticks() void;
pub extern fn SDL_NumJoysticks() c_int;
pub extern fn SDL_JoystickNameForIndex(device_index: c_int) [*c]const u8;
pub extern fn SDL_JoystickGetDevicePlayerIndex(device_index: c_int) c_int;
pub extern fn SDL_JoystickGetDeviceGUID(device_index: c_int) SDL_JoystickGUID;
pub extern fn SDL_JoystickGetDeviceVendor(device_index: c_int) Uint16;
pub extern fn SDL_JoystickGetDeviceProduct(device_index: c_int) Uint16;
pub extern fn SDL_JoystickGetDeviceProductVersion(device_index: c_int) Uint16;
pub extern fn SDL_JoystickGetDeviceType(device_index: c_int) SDL_JoystickType;
pub extern fn SDL_JoystickGetDeviceInstanceID(device_index: c_int) SDL_JoystickID;
pub extern fn SDL_JoystickOpen(device_index: c_int) ?*SDL_Joystick;
pub extern fn SDL_JoystickFromInstanceID(instance_id: SDL_JoystickID) ?*SDL_Joystick;
pub extern fn SDL_JoystickFromPlayerIndex(player_index: c_int) ?*SDL_Joystick;
pub extern fn SDL_JoystickName(joystick: ?*SDL_Joystick) [*c]const u8;
pub extern fn SDL_JoystickGetPlayerIndex(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_JoystickSetPlayerIndex(joystick: ?*SDL_Joystick, player_index: c_int) void;
pub extern fn SDL_JoystickGetGUID(joystick: ?*SDL_Joystick) SDL_JoystickGUID;
pub extern fn SDL_JoystickGetVendor(joystick: ?*SDL_Joystick) Uint16;
pub extern fn SDL_JoystickGetProduct(joystick: ?*SDL_Joystick) Uint16;
pub extern fn SDL_JoystickGetProductVersion(joystick: ?*SDL_Joystick) Uint16;
pub extern fn SDL_JoystickGetType(joystick: ?*SDL_Joystick) SDL_JoystickType;
pub extern fn SDL_JoystickGetGUIDString(guid: SDL_JoystickGUID, pszGUID: [*c]u8, cbGUID: c_int) void;
pub extern fn SDL_JoystickGetGUIDFromString(pchGUID: [*c]const u8) SDL_JoystickGUID;
pub extern fn SDL_JoystickGetAttached(joystick: ?*SDL_Joystick) SDL_bool;
pub extern fn SDL_JoystickInstanceID(joystick: ?*SDL_Joystick) SDL_JoystickID;
pub extern fn SDL_JoystickNumAxes(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_JoystickNumBalls(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_JoystickNumHats(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_JoystickNumButtons(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_JoystickUpdate() void;
pub extern fn SDL_JoystickEventState(state: c_int) c_int;
pub extern fn SDL_JoystickGetAxis(joystick: ?*SDL_Joystick, axis: c_int) Sint16;
pub extern fn SDL_JoystickGetAxisInitialState(joystick: ?*SDL_Joystick, axis: c_int, state: [*c]Sint16) SDL_bool;
pub extern fn SDL_JoystickGetHat(joystick: ?*SDL_Joystick, hat: c_int) Uint8;
pub extern fn SDL_JoystickGetBall(joystick: ?*SDL_Joystick, ball: c_int, dx: [*c]c_int, dy: [*c]c_int) c_int;
pub extern fn SDL_JoystickGetButton(joystick: ?*SDL_Joystick, button: c_int) Uint8;
pub extern fn SDL_JoystickRumble(joystick: ?*SDL_Joystick, low_frequency_rumble: Uint16, high_frequency_rumble: Uint16, duration_ms: Uint32) c_int;
pub extern fn SDL_JoystickClose(joystick: ?*SDL_Joystick) void;
pub extern fn SDL_JoystickCurrentPowerLevel(joystick: ?*SDL_Joystick) SDL_JoystickPowerLevel;
pub const struct__SDL_GameController = @Type(.Opaque);
pub const SDL_GameController = struct__SDL_GameController;
pub const SDL_CONTROLLER_TYPE_UNKNOWN = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_UNKNOWN);
pub const SDL_CONTROLLER_TYPE_XBOX360 = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_XBOX360);
pub const SDL_CONTROLLER_TYPE_XBOXONE = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_XBOXONE);
pub const SDL_CONTROLLER_TYPE_PS3 = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_PS3);
pub const SDL_CONTROLLER_TYPE_PS4 = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_PS4);
pub const SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO = @enumToInt(enum_unnamed_58.SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO);
const enum_unnamed_58 = extern enum(c_int) {
    SDL_CONTROLLER_TYPE_UNKNOWN = 0,
    SDL_CONTROLLER_TYPE_XBOX360 = 1,
    SDL_CONTROLLER_TYPE_XBOXONE = 2,
    SDL_CONTROLLER_TYPE_PS3 = 3,
    SDL_CONTROLLER_TYPE_PS4 = 4,
    SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO = 5,
    _,
};
pub const SDL_GameControllerType = enum_unnamed_58;
pub const SDL_CONTROLLER_BINDTYPE_NONE = @enumToInt(enum_unnamed_59.SDL_CONTROLLER_BINDTYPE_NONE);
pub const SDL_CONTROLLER_BINDTYPE_BUTTON = @enumToInt(enum_unnamed_59.SDL_CONTROLLER_BINDTYPE_BUTTON);
pub const SDL_CONTROLLER_BINDTYPE_AXIS = @enumToInt(enum_unnamed_59.SDL_CONTROLLER_BINDTYPE_AXIS);
pub const SDL_CONTROLLER_BINDTYPE_HAT = @enumToInt(enum_unnamed_59.SDL_CONTROLLER_BINDTYPE_HAT);
const enum_unnamed_59 = extern enum(c_int) {
    SDL_CONTROLLER_BINDTYPE_NONE = 0,
    SDL_CONTROLLER_BINDTYPE_BUTTON = 1,
    SDL_CONTROLLER_BINDTYPE_AXIS = 2,
    SDL_CONTROLLER_BINDTYPE_HAT = 3,
    _,
};
pub const SDL_GameControllerBindType = enum_unnamed_59;
const struct_unnamed_61 = extern struct {
    hat: c_int,
    hat_mask: c_int,
};
const union_unnamed_60 = extern union {
    button: c_int,
    axis: c_int,
    hat: struct_unnamed_61,
};
pub const struct_SDL_GameControllerButtonBind = extern struct {
    bindType: SDL_GameControllerBindType,
    value: union_unnamed_60,
};
pub const SDL_GameControllerButtonBind = struct_SDL_GameControllerButtonBind;
pub extern fn SDL_GameControllerAddMappingsFromRW(rw: [*c]SDL_RWops, freerw: c_int) c_int;
pub extern fn SDL_GameControllerAddMapping(mappingString: [*c]const u8) c_int;
pub extern fn SDL_GameControllerNumMappings() c_int;
pub extern fn SDL_GameControllerMappingForIndex(mapping_index: c_int) [*c]u8;
pub extern fn SDL_GameControllerMappingForGUID(guid: SDL_JoystickGUID) [*c]u8;
pub extern fn SDL_GameControllerMapping(gamecontroller: ?*SDL_GameController) [*c]u8;
pub extern fn SDL_IsGameController(joystick_index: c_int) SDL_bool;
pub extern fn SDL_GameControllerNameForIndex(joystick_index: c_int) [*c]const u8;
pub extern fn SDL_GameControllerTypeForIndex(joystick_index: c_int) SDL_GameControllerType;
pub extern fn SDL_GameControllerMappingForDeviceIndex(joystick_index: c_int) [*c]u8;
pub extern fn SDL_GameControllerOpen(joystick_index: c_int) ?*SDL_GameController;
pub extern fn SDL_GameControllerFromInstanceID(joyid: SDL_JoystickID) ?*SDL_GameController;
pub extern fn SDL_GameControllerFromPlayerIndex(player_index: c_int) ?*SDL_GameController;
pub extern fn SDL_GameControllerName(gamecontroller: ?*SDL_GameController) [*c]const u8;
pub extern fn SDL_GameControllerGetType(gamecontroller: ?*SDL_GameController) SDL_GameControllerType;
pub extern fn SDL_GameControllerGetPlayerIndex(gamecontroller: ?*SDL_GameController) c_int;
pub extern fn SDL_GameControllerSetPlayerIndex(gamecontroller: ?*SDL_GameController, player_index: c_int) void;
pub extern fn SDL_GameControllerGetVendor(gamecontroller: ?*SDL_GameController) Uint16;
pub extern fn SDL_GameControllerGetProduct(gamecontroller: ?*SDL_GameController) Uint16;
pub extern fn SDL_GameControllerGetProductVersion(gamecontroller: ?*SDL_GameController) Uint16;
pub extern fn SDL_GameControllerGetAttached(gamecontroller: ?*SDL_GameController) SDL_bool;
pub extern fn SDL_GameControllerGetJoystick(gamecontroller: ?*SDL_GameController) ?*SDL_Joystick;
pub extern fn SDL_GameControllerEventState(state: c_int) c_int;
pub extern fn SDL_GameControllerUpdate() void;
pub const SDL_CONTROLLER_AXIS_INVALID = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_INVALID);
pub const SDL_CONTROLLER_AXIS_LEFTX = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_LEFTX);
pub const SDL_CONTROLLER_AXIS_LEFTY = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_LEFTY);
pub const SDL_CONTROLLER_AXIS_RIGHTX = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_RIGHTX);
pub const SDL_CONTROLLER_AXIS_RIGHTY = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_RIGHTY);
pub const SDL_CONTROLLER_AXIS_TRIGGERLEFT = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_TRIGGERLEFT);
pub const SDL_CONTROLLER_AXIS_TRIGGERRIGHT = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_TRIGGERRIGHT);
pub const SDL_CONTROLLER_AXIS_MAX = @enumToInt(enum_unnamed_62.SDL_CONTROLLER_AXIS_MAX);
const enum_unnamed_62 = extern enum(c_int) {
    SDL_CONTROLLER_AXIS_INVALID = -1,
    SDL_CONTROLLER_AXIS_LEFTX = 0,
    SDL_CONTROLLER_AXIS_LEFTY = 1,
    SDL_CONTROLLER_AXIS_RIGHTX = 2,
    SDL_CONTROLLER_AXIS_RIGHTY = 3,
    SDL_CONTROLLER_AXIS_TRIGGERLEFT = 4,
    SDL_CONTROLLER_AXIS_TRIGGERRIGHT = 5,
    SDL_CONTROLLER_AXIS_MAX = 6,
    _,
};
pub const SDL_GameControllerAxis = enum_unnamed_62;
pub extern fn SDL_GameControllerGetAxisFromString(pchString: [*c]const u8) SDL_GameControllerAxis;
pub extern fn SDL_GameControllerGetStringForAxis(axis: SDL_GameControllerAxis) [*c]const u8;
pub extern fn SDL_GameControllerGetBindForAxis(gamecontroller: ?*SDL_GameController, axis: SDL_GameControllerAxis) SDL_GameControllerButtonBind;
pub extern fn SDL_GameControllerGetAxis(gamecontroller: ?*SDL_GameController, axis: SDL_GameControllerAxis) Sint16;
pub const SDL_CONTROLLER_BUTTON_INVALID = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_INVALID);
pub const SDL_CONTROLLER_BUTTON_A = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_A);
pub const SDL_CONTROLLER_BUTTON_B = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_B);
pub const SDL_CONTROLLER_BUTTON_X = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_X);
pub const SDL_CONTROLLER_BUTTON_Y = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_Y);
pub const SDL_CONTROLLER_BUTTON_BACK = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_BACK);
pub const SDL_CONTROLLER_BUTTON_GUIDE = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_GUIDE);
pub const SDL_CONTROLLER_BUTTON_START = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_START);
pub const SDL_CONTROLLER_BUTTON_LEFTSTICK = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_LEFTSTICK);
pub const SDL_CONTROLLER_BUTTON_RIGHTSTICK = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_RIGHTSTICK);
pub const SDL_CONTROLLER_BUTTON_LEFTSHOULDER = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_LEFTSHOULDER);
pub const SDL_CONTROLLER_BUTTON_RIGHTSHOULDER = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_RIGHTSHOULDER);
pub const SDL_CONTROLLER_BUTTON_DPAD_UP = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_DPAD_UP);
pub const SDL_CONTROLLER_BUTTON_DPAD_DOWN = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_DPAD_DOWN);
pub const SDL_CONTROLLER_BUTTON_DPAD_LEFT = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_DPAD_LEFT);
pub const SDL_CONTROLLER_BUTTON_DPAD_RIGHT = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_DPAD_RIGHT);
pub const SDL_CONTROLLER_BUTTON_MAX = @enumToInt(enum_unnamed_63.SDL_CONTROLLER_BUTTON_MAX);
const enum_unnamed_63 = extern enum(c_int) {
    SDL_CONTROLLER_BUTTON_INVALID = -1,
    SDL_CONTROLLER_BUTTON_A = 0,
    SDL_CONTROLLER_BUTTON_B = 1,
    SDL_CONTROLLER_BUTTON_X = 2,
    SDL_CONTROLLER_BUTTON_Y = 3,
    SDL_CONTROLLER_BUTTON_BACK = 4,
    SDL_CONTROLLER_BUTTON_GUIDE = 5,
    SDL_CONTROLLER_BUTTON_START = 6,
    SDL_CONTROLLER_BUTTON_LEFTSTICK = 7,
    SDL_CONTROLLER_BUTTON_RIGHTSTICK = 8,
    SDL_CONTROLLER_BUTTON_LEFTSHOULDER = 9,
    SDL_CONTROLLER_BUTTON_RIGHTSHOULDER = 10,
    SDL_CONTROLLER_BUTTON_DPAD_UP = 11,
    SDL_CONTROLLER_BUTTON_DPAD_DOWN = 12,
    SDL_CONTROLLER_BUTTON_DPAD_LEFT = 13,
    SDL_CONTROLLER_BUTTON_DPAD_RIGHT = 14,
    SDL_CONTROLLER_BUTTON_MAX = 15,
    _,
};
pub const SDL_GameControllerButton = enum_unnamed_63;
pub extern fn SDL_GameControllerGetButtonFromString(pchString: [*c]const u8) SDL_GameControllerButton;
pub extern fn SDL_GameControllerGetStringForButton(button: SDL_GameControllerButton) [*c]const u8;
pub extern fn SDL_GameControllerGetBindForButton(gamecontroller: ?*SDL_GameController, button: SDL_GameControllerButton) SDL_GameControllerButtonBind;
pub extern fn SDL_GameControllerGetButton(gamecontroller: ?*SDL_GameController, button: SDL_GameControllerButton) Uint8;
pub extern fn SDL_GameControllerRumble(gamecontroller: ?*SDL_GameController, low_frequency_rumble: Uint16, high_frequency_rumble: Uint16, duration_ms: Uint32) c_int;
pub extern fn SDL_GameControllerClose(gamecontroller: ?*SDL_GameController) void;
pub const SDL_TouchID = Sint64;
pub const SDL_FingerID = Sint64;
pub const SDL_TOUCH_DEVICE_INVALID = @enumToInt(enum_unnamed_64.SDL_TOUCH_DEVICE_INVALID);
pub const SDL_TOUCH_DEVICE_DIRECT = @enumToInt(enum_unnamed_64.SDL_TOUCH_DEVICE_DIRECT);
pub const SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE = @enumToInt(enum_unnamed_64.SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE);
pub const SDL_TOUCH_DEVICE_INDIRECT_RELATIVE = @enumToInt(enum_unnamed_64.SDL_TOUCH_DEVICE_INDIRECT_RELATIVE);
const enum_unnamed_64 = extern enum(c_int) {
    SDL_TOUCH_DEVICE_INVALID = -1,
    SDL_TOUCH_DEVICE_DIRECT = 0,
    SDL_TOUCH_DEVICE_INDIRECT_ABSOLUTE = 1,
    SDL_TOUCH_DEVICE_INDIRECT_RELATIVE = 2,
    _,
};
pub const SDL_TouchDeviceType = enum_unnamed_64;
pub const struct_SDL_Finger = extern struct {
    id: SDL_FingerID,
    x: f32,
    y: f32,
    pressure: f32,
};
pub const SDL_Finger = struct_SDL_Finger;
pub extern fn SDL_GetNumTouchDevices() c_int;
pub extern fn SDL_GetTouchDevice(index: c_int) SDL_TouchID;
pub extern fn SDL_GetTouchDeviceType(touchID: SDL_TouchID) SDL_TouchDeviceType;
pub extern fn SDL_GetNumTouchFingers(touchID: SDL_TouchID) c_int;
pub extern fn SDL_GetTouchFinger(touchID: SDL_TouchID, index: c_int) [*c]SDL_Finger;
pub const SDL_GestureID = Sint64;
pub extern fn SDL_RecordGesture(touchId: SDL_TouchID) c_int;
pub extern fn SDL_SaveAllDollarTemplates(dst: [*c]SDL_RWops) c_int;
pub extern fn SDL_SaveDollarTemplate(gestureId: SDL_GestureID, dst: [*c]SDL_RWops) c_int;
pub extern fn SDL_LoadDollarTemplates(touchId: SDL_TouchID, src: [*c]SDL_RWops) c_int;
pub const SDL_FIRSTEVENT = @enumToInt(enum_unnamed_65.SDL_FIRSTEVENT);
pub const SDL_QUIT = @enumToInt(enum_unnamed_65.SDL_QUIT);
pub const SDL_APP_TERMINATING = @enumToInt(enum_unnamed_65.SDL_APP_TERMINATING);
pub const SDL_APP_LOWMEMORY = @enumToInt(enum_unnamed_65.SDL_APP_LOWMEMORY);
pub const SDL_APP_WILLENTERBACKGROUND = @enumToInt(enum_unnamed_65.SDL_APP_WILLENTERBACKGROUND);
pub const SDL_APP_DIDENTERBACKGROUND = @enumToInt(enum_unnamed_65.SDL_APP_DIDENTERBACKGROUND);
pub const SDL_APP_WILLENTERFOREGROUND = @enumToInt(enum_unnamed_65.SDL_APP_WILLENTERFOREGROUND);
pub const SDL_APP_DIDENTERFOREGROUND = @enumToInt(enum_unnamed_65.SDL_APP_DIDENTERFOREGROUND);
pub const SDL_DISPLAYEVENT = @enumToInt(enum_unnamed_65.SDL_DISPLAYEVENT);
pub const SDL_WINDOWEVENT = @enumToInt(enum_unnamed_65.SDL_WINDOWEVENT);
pub const SDL_SYSWMEVENT = @enumToInt(enum_unnamed_65.SDL_SYSWMEVENT);
pub const SDL_KEYDOWN = @enumToInt(enum_unnamed_65.SDL_KEYDOWN);
pub const SDL_KEYUP = @enumToInt(enum_unnamed_65.SDL_KEYUP);
pub const SDL_TEXTEDITING = @enumToInt(enum_unnamed_65.SDL_TEXTEDITING);
pub const SDL_TEXTINPUT = @enumToInt(enum_unnamed_65.SDL_TEXTINPUT);
pub const SDL_KEYMAPCHANGED = @enumToInt(enum_unnamed_65.SDL_KEYMAPCHANGED);
pub const SDL_MOUSEMOTION = @enumToInt(enum_unnamed_65.SDL_MOUSEMOTION);
pub const SDL_MOUSEBUTTONDOWN = @enumToInt(enum_unnamed_65.SDL_MOUSEBUTTONDOWN);
pub const SDL_MOUSEBUTTONUP = @enumToInt(enum_unnamed_65.SDL_MOUSEBUTTONUP);
pub const SDL_MOUSEWHEEL = @enumToInt(enum_unnamed_65.SDL_MOUSEWHEEL);
pub const SDL_JOYAXISMOTION = @enumToInt(enum_unnamed_65.SDL_JOYAXISMOTION);
pub const SDL_JOYBALLMOTION = @enumToInt(enum_unnamed_65.SDL_JOYBALLMOTION);
pub const SDL_JOYHATMOTION = @enumToInt(enum_unnamed_65.SDL_JOYHATMOTION);
pub const SDL_JOYBUTTONDOWN = @enumToInt(enum_unnamed_65.SDL_JOYBUTTONDOWN);
pub const SDL_JOYBUTTONUP = @enumToInt(enum_unnamed_65.SDL_JOYBUTTONUP);
pub const SDL_JOYDEVICEADDED = @enumToInt(enum_unnamed_65.SDL_JOYDEVICEADDED);
pub const SDL_JOYDEVICEREMOVED = @enumToInt(enum_unnamed_65.SDL_JOYDEVICEREMOVED);
pub const SDL_CONTROLLERAXISMOTION = @enumToInt(enum_unnamed_65.SDL_CONTROLLERAXISMOTION);
pub const SDL_CONTROLLERBUTTONDOWN = @enumToInt(enum_unnamed_65.SDL_CONTROLLERBUTTONDOWN);
pub const SDL_CONTROLLERBUTTONUP = @enumToInt(enum_unnamed_65.SDL_CONTROLLERBUTTONUP);
pub const SDL_CONTROLLERDEVICEADDED = @enumToInt(enum_unnamed_65.SDL_CONTROLLERDEVICEADDED);
pub const SDL_CONTROLLERDEVICEREMOVED = @enumToInt(enum_unnamed_65.SDL_CONTROLLERDEVICEREMOVED);
pub const SDL_CONTROLLERDEVICEREMAPPED = @enumToInt(enum_unnamed_65.SDL_CONTROLLERDEVICEREMAPPED);
pub const SDL_FINGERDOWN = @enumToInt(enum_unnamed_65.SDL_FINGERDOWN);
pub const SDL_FINGERUP = @enumToInt(enum_unnamed_65.SDL_FINGERUP);
pub const SDL_FINGERMOTION = @enumToInt(enum_unnamed_65.SDL_FINGERMOTION);
pub const SDL_DOLLARGESTURE = @enumToInt(enum_unnamed_65.SDL_DOLLARGESTURE);
pub const SDL_DOLLARRECORD = @enumToInt(enum_unnamed_65.SDL_DOLLARRECORD);
pub const SDL_MULTIGESTURE = @enumToInt(enum_unnamed_65.SDL_MULTIGESTURE);
pub const SDL_CLIPBOARDUPDATE = @enumToInt(enum_unnamed_65.SDL_CLIPBOARDUPDATE);
pub const SDL_DROPFILE = @enumToInt(enum_unnamed_65.SDL_DROPFILE);
pub const SDL_DROPTEXT = @enumToInt(enum_unnamed_65.SDL_DROPTEXT);
pub const SDL_DROPBEGIN = @enumToInt(enum_unnamed_65.SDL_DROPBEGIN);
pub const SDL_DROPCOMPLETE = @enumToInt(enum_unnamed_65.SDL_DROPCOMPLETE);
pub const SDL_AUDIODEVICEADDED = @enumToInt(enum_unnamed_65.SDL_AUDIODEVICEADDED);
pub const SDL_AUDIODEVICEREMOVED = @enumToInt(enum_unnamed_65.SDL_AUDIODEVICEREMOVED);
pub const SDL_SENSORUPDATE = @enumToInt(enum_unnamed_65.SDL_SENSORUPDATE);
pub const SDL_RENDER_TARGETS_RESET = @enumToInt(enum_unnamed_65.SDL_RENDER_TARGETS_RESET);
pub const SDL_RENDER_DEVICE_RESET = @enumToInt(enum_unnamed_65.SDL_RENDER_DEVICE_RESET);
pub const SDL_USEREVENT = @enumToInt(enum_unnamed_65.SDL_USEREVENT);
pub const SDL_LASTEVENT = @enumToInt(enum_unnamed_65.SDL_LASTEVENT);
const enum_unnamed_65 = extern enum(c_int) {
    SDL_FIRSTEVENT = 0,
    SDL_QUIT = 256,
    SDL_APP_TERMINATING = 257,
    SDL_APP_LOWMEMORY = 258,
    SDL_APP_WILLENTERBACKGROUND = 259,
    SDL_APP_DIDENTERBACKGROUND = 260,
    SDL_APP_WILLENTERFOREGROUND = 261,
    SDL_APP_DIDENTERFOREGROUND = 262,
    SDL_DISPLAYEVENT = 336,
    SDL_WINDOWEVENT = 512,
    SDL_SYSWMEVENT = 513,
    SDL_KEYDOWN = 768,
    SDL_KEYUP = 769,
    SDL_TEXTEDITING = 770,
    SDL_TEXTINPUT = 771,
    SDL_KEYMAPCHANGED = 772,
    SDL_MOUSEMOTION = 1024,
    SDL_MOUSEBUTTONDOWN = 1025,
    SDL_MOUSEBUTTONUP = 1026,
    SDL_MOUSEWHEEL = 1027,
    SDL_JOYAXISMOTION = 1536,
    SDL_JOYBALLMOTION = 1537,
    SDL_JOYHATMOTION = 1538,
    SDL_JOYBUTTONDOWN = 1539,
    SDL_JOYBUTTONUP = 1540,
    SDL_JOYDEVICEADDED = 1541,
    SDL_JOYDEVICEREMOVED = 1542,
    SDL_CONTROLLERAXISMOTION = 1616,
    SDL_CONTROLLERBUTTONDOWN = 1617,
    SDL_CONTROLLERBUTTONUP = 1618,
    SDL_CONTROLLERDEVICEADDED = 1619,
    SDL_CONTROLLERDEVICEREMOVED = 1620,
    SDL_CONTROLLERDEVICEREMAPPED = 1621,
    SDL_FINGERDOWN = 1792,
    SDL_FINGERUP = 1793,
    SDL_FINGERMOTION = 1794,
    SDL_DOLLARGESTURE = 2048,
    SDL_DOLLARRECORD = 2049,
    SDL_MULTIGESTURE = 2050,
    SDL_CLIPBOARDUPDATE = 2304,
    SDL_DROPFILE = 4096,
    SDL_DROPTEXT = 4097,
    SDL_DROPBEGIN = 4098,
    SDL_DROPCOMPLETE = 4099,
    SDL_AUDIODEVICEADDED = 4352,
    SDL_AUDIODEVICEREMOVED = 4353,
    SDL_SENSORUPDATE = 4608,
    SDL_RENDER_TARGETS_RESET = 8192,
    SDL_RENDER_DEVICE_RESET = 8193,
    SDL_USEREVENT = 32768,
    SDL_LASTEVENT = 65535,
    _,
};
pub const SDL_EventType = enum_unnamed_65;
pub const struct_SDL_CommonEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
};
pub const SDL_CommonEvent = struct_SDL_CommonEvent;
pub const SDL_DisplayEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    display: Uint32,
    event: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    data1: i32,
};

pub const SDL_WindowEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    event: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    data1: i32,
    data2: i32,
};

pub const struct_SDL_KeyboardEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    state: Uint8,
    repeat: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    keysym: SDL_Keysym,
};
pub const SDL_KeyboardEvent = struct_SDL_KeyboardEvent;
pub const struct_SDL_TextEditingEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    text: [32]u8,
    start: i32,
    length: i32,
};
pub const SDL_TextEditingEvent = struct_SDL_TextEditingEvent;
pub const struct_SDL_TextInputEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    text: [32]u8,
};
pub const SDL_TextInputEvent = struct_SDL_TextInputEvent;
pub const struct_SDL_MouseMotionEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    which: Uint32,
    state: Uint32,
    x: i32,
    y: i32,
    xrel: i32,
    yrel: i32,
};
pub const SDL_MouseMotionEvent = struct_SDL_MouseMotionEvent;
pub const struct_SDL_MouseButtonEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    which: Uint32,
    button: Uint8,
    state: Uint8,
    clicks: Uint8,
    padding1: Uint8,
    x: i32,
    y: i32,
};
pub const SDL_MouseButtonEvent = struct_SDL_MouseButtonEvent;
pub const struct_SDL_MouseWheelEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    which: Uint32,
    x: i32,
    y: i32,
    direction: Uint32,
};
pub const SDL_MouseWheelEvent = struct_SDL_MouseWheelEvent;
pub const struct_SDL_JoyAxisEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    axis: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    value: Sint16,
    padding4: Uint16,
};
pub const SDL_JoyAxisEvent = struct_SDL_JoyAxisEvent;
pub const struct_SDL_JoyBallEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    ball: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    xrel: Sint16,
    yrel: Sint16,
};
pub const SDL_JoyBallEvent = struct_SDL_JoyBallEvent;
pub const struct_SDL_JoyHatEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    hat: Uint8,
    value: Uint8,
    padding1: Uint8,
    padding2: Uint8,
};
pub const SDL_JoyHatEvent = struct_SDL_JoyHatEvent;
pub const struct_SDL_JoyButtonEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    button: Uint8,
    state: Uint8,
    padding1: Uint8,
    padding2: Uint8,
};
pub const SDL_JoyButtonEvent = struct_SDL_JoyButtonEvent;
pub const struct_SDL_JoyDeviceEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: i32,
};
pub const SDL_JoyDeviceEvent = struct_SDL_JoyDeviceEvent;
pub const struct_SDL_ControllerAxisEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    axis: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
    value: Sint16,
    padding4: Uint16,
};
pub const SDL_ControllerAxisEvent = struct_SDL_ControllerAxisEvent;
pub const struct_SDL_ControllerButtonEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: SDL_JoystickID,
    button: Uint8,
    state: Uint8,
    padding1: Uint8,
    padding2: Uint8,
};
pub const SDL_ControllerButtonEvent = struct_SDL_ControllerButtonEvent;
pub const struct_SDL_ControllerDeviceEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: i32,
};
pub const SDL_ControllerDeviceEvent = struct_SDL_ControllerDeviceEvent;
pub const struct_SDL_AudioDeviceEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: Uint32,
    iscapture: Uint8,
    padding1: Uint8,
    padding2: Uint8,
    padding3: Uint8,
};
pub const SDL_AudioDeviceEvent = struct_SDL_AudioDeviceEvent;
pub const struct_SDL_TouchFingerEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    touchId: SDL_TouchID,
    fingerId: SDL_FingerID,
    x: f32,
    y: f32,
    dx: f32,
    dy: f32,
    pressure: f32,
    windowID: Uint32,
};
pub const SDL_TouchFingerEvent = struct_SDL_TouchFingerEvent;
pub const struct_SDL_MultiGestureEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    touchId: SDL_TouchID,
    dTheta: f32,
    dDist: f32,
    x: f32,
    y: f32,
    numFingers: Uint16,
    padding: Uint16,
};
pub const SDL_MultiGestureEvent = struct_SDL_MultiGestureEvent;
pub const struct_SDL_DollarGestureEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    touchId: SDL_TouchID,
    gestureId: SDL_GestureID,
    numFingers: Uint32,
    @"error": f32,
    x: f32,
    y: f32,
};
pub const SDL_DollarGestureEvent = struct_SDL_DollarGestureEvent;
pub const struct_SDL_DropEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    file: [*c]u8,
    windowID: Uint32,
};
pub const SDL_DropEvent = struct_SDL_DropEvent;
pub const struct_SDL_SensorEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    which: i32,
    data: [6]f32,
};
pub const SDL_SensorEvent = struct_SDL_SensorEvent;
pub const struct_SDL_QuitEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
};
pub const SDL_QuitEvent = struct_SDL_QuitEvent;
pub const struct_SDL_OSEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
};
pub const SDL_OSEvent = struct_SDL_OSEvent;
pub const struct_SDL_UserEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    windowID: Uint32,
    code: i32,
    data1: ?*c_void,
    data2: ?*c_void,
};
pub const SDL_UserEvent = struct_SDL_UserEvent;
pub const struct_SDL_SysWMmsg = @Type(.Opaque);
pub const SDL_SysWMmsg = struct_SDL_SysWMmsg;
pub const struct_SDL_SysWMEvent = extern struct {
    type: Uint32,
    timestamp: Uint32,
    msg: ?*SDL_SysWMmsg,
};
pub const SDL_SysWMEvent = struct_SDL_SysWMEvent;
pub const union_SDL_Event = extern union {
    type: Uint32,
    common: SDL_CommonEvent,
    display: SDL_DisplayEvent,
    window: SDL_WindowEvent,
    key: SDL_KeyboardEvent,
    edit: SDL_TextEditingEvent,
    text: SDL_TextInputEvent,
    motion: SDL_MouseMotionEvent,
    button: SDL_MouseButtonEvent,
    wheel: SDL_MouseWheelEvent,
    jaxis: SDL_JoyAxisEvent,
    jball: SDL_JoyBallEvent,
    jhat: SDL_JoyHatEvent,
    jbutton: SDL_JoyButtonEvent,
    jdevice: SDL_JoyDeviceEvent,
    caxis: SDL_ControllerAxisEvent,
    cbutton: SDL_ControllerButtonEvent,
    cdevice: SDL_ControllerDeviceEvent,
    adevice: SDL_AudioDeviceEvent,
    sensor: SDL_SensorEvent,
    quit: SDL_QuitEvent,
    user: SDL_UserEvent,
    syswm: SDL_SysWMEvent,
    tfinger: SDL_TouchFingerEvent,
    mgesture: SDL_MultiGestureEvent,
    dgesture: SDL_DollarGestureEvent,
    drop: SDL_DropEvent,
    padding: [56]Uint8,
};
pub const SDL_Event = union_SDL_Event;
pub const SDL_compile_time_assert_SDL_Event = [1]c_int;
pub extern fn SDL_PumpEvents() void;
pub const SDL_ADDEVENT = @enumToInt(enum_unnamed_66.SDL_ADDEVENT);
pub const SDL_PEEKEVENT = @enumToInt(enum_unnamed_66.SDL_PEEKEVENT);
pub const SDL_GETEVENT = @enumToInt(enum_unnamed_66.SDL_GETEVENT);
const enum_unnamed_66 = extern enum(c_int) {
    SDL_ADDEVENT,
    SDL_PEEKEVENT,
    SDL_GETEVENT,
    _,
};
pub const SDL_eventaction = enum_unnamed_66;
pub extern fn SDL_PeepEvents(events: [*c]SDL_Event, numevents: c_int, action: SDL_eventaction, minType: Uint32, maxType: Uint32) c_int;
pub extern fn SDL_HasEvent(type: Uint32) SDL_bool;
pub extern fn SDL_HasEvents(minType: Uint32, maxType: Uint32) SDL_bool;
pub extern fn SDL_FlushEvent(type: Uint32) void;
pub extern fn SDL_FlushEvents(minType: Uint32, maxType: Uint32) void;
pub extern fn SDL_PollEvent(event: [*c]SDL_Event) c_int;
pub extern fn SDL_WaitEvent(event: [*c]SDL_Event) c_int;
pub extern fn SDL_WaitEventTimeout(event: [*c]SDL_Event, timeout: c_int) c_int;
pub extern fn SDL_PushEvent(event: [*c]SDL_Event) c_int;
pub const SDL_EventFilter = ?fn (?*c_void, *SDL_Event) callconv(.C) c_int;
pub extern fn SDL_SetEventFilter(filter: SDL_EventFilter, userdata: ?*c_void) void;
pub extern fn SDL_GetEventFilter(filter: [*c]SDL_EventFilter, userdata: [*c]?*c_void) SDL_bool;
pub extern fn SDL_AddEventWatch(filter: SDL_EventFilter, userdata: ?*c_void) void;
pub extern fn SDL_DelEventWatch(filter: SDL_EventFilter, userdata: ?*c_void) void;
pub extern fn SDL_FilterEvents(filter: SDL_EventFilter, userdata: ?*c_void) void;
pub extern fn SDL_EventState(type: Uint32, state: c_int) Uint8;
pub extern fn SDL_RegisterEvents(numevents: c_int) Uint32;
pub extern fn SDL_GetBasePath() [*c]u8;
pub extern fn SDL_GetPrefPath(org: [*c]const u8, app: [*c]const u8) [*c]u8;
pub const struct__SDL_Haptic = @Type(.Opaque);
pub const SDL_Haptic = struct__SDL_Haptic;
pub const struct_SDL_HapticDirection = extern struct {
    type: Uint8,
    dir: [3]i32,
};
pub const SDL_HapticDirection = struct_SDL_HapticDirection;
pub const struct_SDL_HapticConstant = extern struct {
    type: Uint16,
    direction: SDL_HapticDirection,
    length: Uint32,
    delay: Uint16,
    button: Uint16,
    interval: Uint16,
    level: Sint16,
    attack_length: Uint16,
    attack_level: Uint16,
    fade_length: Uint16,
    fade_level: Uint16,
};
pub const SDL_HapticConstant = struct_SDL_HapticConstant;
pub const struct_SDL_HapticPeriodic = extern struct {
    type: Uint16,
    direction: SDL_HapticDirection,
    length: Uint32,
    delay: Uint16,
    button: Uint16,
    interval: Uint16,
    period: Uint16,
    magnitude: Sint16,
    offset: Sint16,
    phase: Uint16,
    attack_length: Uint16,
    attack_level: Uint16,
    fade_length: Uint16,
    fade_level: Uint16,
};
pub const SDL_HapticPeriodic = struct_SDL_HapticPeriodic;
pub const struct_SDL_HapticCondition = extern struct {
    type: Uint16,
    direction: SDL_HapticDirection,
    length: Uint32,
    delay: Uint16,
    button: Uint16,
    interval: Uint16,
    right_sat: [3]Uint16,
    left_sat: [3]Uint16,
    right_coeff: [3]Sint16,
    left_coeff: [3]Sint16,
    deadband: [3]Uint16,
    center: [3]Sint16,
};
pub const SDL_HapticCondition = struct_SDL_HapticCondition;
pub const struct_SDL_HapticRamp = extern struct {
    type: Uint16,
    direction: SDL_HapticDirection,
    length: Uint32,
    delay: Uint16,
    button: Uint16,
    interval: Uint16,
    start: Sint16,
    end: Sint16,
    attack_length: Uint16,
    attack_level: Uint16,
    fade_length: Uint16,
    fade_level: Uint16,
};
pub const SDL_HapticRamp = struct_SDL_HapticRamp;
pub const struct_SDL_HapticLeftRight = extern struct {
    type: Uint16,
    length: Uint32,
    large_magnitude: Uint16,
    small_magnitude: Uint16,
};
pub const SDL_HapticLeftRight = struct_SDL_HapticLeftRight;
pub const struct_SDL_HapticCustom = extern struct {
    type: Uint16,
    direction: SDL_HapticDirection,
    length: Uint32,
    delay: Uint16,
    button: Uint16,
    interval: Uint16,
    channels: Uint8,
    period: Uint16,
    samples: Uint16,
    data: [*c]Uint16,
    attack_length: Uint16,
    attack_level: Uint16,
    fade_length: Uint16,
    fade_level: Uint16,
};
pub const SDL_HapticCustom = struct_SDL_HapticCustom;
pub const union_SDL_HapticEffect = extern union {
    type: Uint16,
    constant: SDL_HapticConstant,
    periodic: SDL_HapticPeriodic,
    condition: SDL_HapticCondition,
    ramp: SDL_HapticRamp,
    leftright: SDL_HapticLeftRight,
    custom: SDL_HapticCustom,
};
pub const SDL_HapticEffect = union_SDL_HapticEffect;
pub extern fn SDL_NumHaptics() c_int;
pub extern fn SDL_HapticName(device_index: c_int) [*c]const u8;
pub extern fn SDL_HapticOpen(device_index: c_int) ?*SDL_Haptic;
pub extern fn SDL_HapticOpened(device_index: c_int) c_int;
pub extern fn SDL_HapticIndex(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_MouseIsHaptic() c_int;
pub extern fn SDL_HapticOpenFromMouse() ?*SDL_Haptic;
pub extern fn SDL_JoystickIsHaptic(joystick: ?*SDL_Joystick) c_int;
pub extern fn SDL_HapticOpenFromJoystick(joystick: ?*SDL_Joystick) ?*SDL_Haptic;
pub extern fn SDL_HapticClose(haptic: ?*SDL_Haptic) void;
pub extern fn SDL_HapticNumEffects(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticNumEffectsPlaying(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticQuery(haptic: ?*SDL_Haptic) c_uint;
pub extern fn SDL_HapticNumAxes(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticEffectSupported(haptic: ?*SDL_Haptic, effect: [*c]SDL_HapticEffect) c_int;
pub extern fn SDL_HapticNewEffect(haptic: ?*SDL_Haptic, effect: [*c]SDL_HapticEffect) c_int;
pub extern fn SDL_HapticUpdateEffect(haptic: ?*SDL_Haptic, effect: c_int, data: [*c]SDL_HapticEffect) c_int;
pub extern fn SDL_HapticRunEffect(haptic: ?*SDL_Haptic, effect: c_int, iterations: Uint32) c_int;
pub extern fn SDL_HapticStopEffect(haptic: ?*SDL_Haptic, effect: c_int) c_int;
pub extern fn SDL_HapticDestroyEffect(haptic: ?*SDL_Haptic, effect: c_int) void;
pub extern fn SDL_HapticGetEffectStatus(haptic: ?*SDL_Haptic, effect: c_int) c_int;
pub extern fn SDL_HapticSetGain(haptic: ?*SDL_Haptic, gain: c_int) c_int;
pub extern fn SDL_HapticSetAutocenter(haptic: ?*SDL_Haptic, autocenter: c_int) c_int;
pub extern fn SDL_HapticPause(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticUnpause(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticStopAll(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticRumbleSupported(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticRumbleInit(haptic: ?*SDL_Haptic) c_int;
pub extern fn SDL_HapticRumblePlay(haptic: ?*SDL_Haptic, strength: f32, length: Uint32) c_int;
pub extern fn SDL_HapticRumbleStop(haptic: ?*SDL_Haptic) c_int;
pub const SDL_HINT_DEFAULT = @enumToInt(enum_unnamed_67.SDL_HINT_DEFAULT);
pub const SDL_HINT_NORMAL = @enumToInt(enum_unnamed_67.SDL_HINT_NORMAL);
pub const SDL_HINT_OVERRIDE = @enumToInt(enum_unnamed_67.SDL_HINT_OVERRIDE);
const enum_unnamed_67 = extern enum(c_int) {
    SDL_HINT_DEFAULT,
    SDL_HINT_NORMAL,
    SDL_HINT_OVERRIDE,
    _,
};
pub const SDL_HintPriority = enum_unnamed_67;
pub extern fn SDL_SetHintWithPriority(name: [*c]const u8, value: [*c]const u8, priority: SDL_HintPriority) SDL_bool;
pub extern fn SDL_SetHint(name: [*c]const u8, value: [*c]const u8) SDL_bool;
pub extern fn SDL_GetHint(name: [*c]const u8) [*c]const u8;
pub extern fn SDL_GetHintBoolean(name: [*c]const u8, default_value: SDL_bool) SDL_bool;
pub const SDL_HintCallback = ?fn (?*c_void, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.C) void;
pub extern fn SDL_AddHintCallback(name: [*c]const u8, callback: SDL_HintCallback, userdata: ?*c_void) void;
pub extern fn SDL_DelHintCallback(name: [*c]const u8, callback: SDL_HintCallback, userdata: ?*c_void) void;
pub extern fn SDL_ClearHints() void;
pub extern fn SDL_LoadObject(sofile: [*c]const u8) ?*c_void;
pub extern fn SDL_LoadFunction(handle: ?*c_void, name: [*c]const u8) ?*c_void;
pub extern fn SDL_UnloadObject(handle: ?*c_void) void;
pub const SDL_LOG_CATEGORY_APPLICATION = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_APPLICATION);
pub const SDL_LOG_CATEGORY_ERROR = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_ERROR);
pub const SDL_LOG_CATEGORY_ASSERT = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_ASSERT);
pub const SDL_LOG_CATEGORY_SYSTEM = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_SYSTEM);
pub const SDL_LOG_CATEGORY_AUDIO = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_AUDIO);
pub const SDL_LOG_CATEGORY_VIDEO = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_VIDEO);
pub const SDL_LOG_CATEGORY_RENDER = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RENDER);
pub const SDL_LOG_CATEGORY_INPUT = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_INPUT);
pub const SDL_LOG_CATEGORY_TEST = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_TEST);
pub const SDL_LOG_CATEGORY_RESERVED1 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED1);
pub const SDL_LOG_CATEGORY_RESERVED2 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED2);
pub const SDL_LOG_CATEGORY_RESERVED3 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED3);
pub const SDL_LOG_CATEGORY_RESERVED4 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED4);
pub const SDL_LOG_CATEGORY_RESERVED5 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED5);
pub const SDL_LOG_CATEGORY_RESERVED6 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED6);
pub const SDL_LOG_CATEGORY_RESERVED7 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED7);
pub const SDL_LOG_CATEGORY_RESERVED8 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED8);
pub const SDL_LOG_CATEGORY_RESERVED9 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED9);
pub const SDL_LOG_CATEGORY_RESERVED10 = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_RESERVED10);
pub const SDL_LOG_CATEGORY_CUSTOM = @enumToInt(enum_unnamed_68.SDL_LOG_CATEGORY_CUSTOM);
const enum_unnamed_68 = extern enum(c_int) {
    SDL_LOG_CATEGORY_APPLICATION,
    SDL_LOG_CATEGORY_ERROR,
    SDL_LOG_CATEGORY_ASSERT,
    SDL_LOG_CATEGORY_SYSTEM,
    SDL_LOG_CATEGORY_AUDIO,
    SDL_LOG_CATEGORY_VIDEO,
    SDL_LOG_CATEGORY_RENDER,
    SDL_LOG_CATEGORY_INPUT,
    SDL_LOG_CATEGORY_TEST,
    SDL_LOG_CATEGORY_RESERVED1,
    SDL_LOG_CATEGORY_RESERVED2,
    SDL_LOG_CATEGORY_RESERVED3,
    SDL_LOG_CATEGORY_RESERVED4,
    SDL_LOG_CATEGORY_RESERVED5,
    SDL_LOG_CATEGORY_RESERVED6,
    SDL_LOG_CATEGORY_RESERVED7,
    SDL_LOG_CATEGORY_RESERVED8,
    SDL_LOG_CATEGORY_RESERVED9,
    SDL_LOG_CATEGORY_RESERVED10,
    SDL_LOG_CATEGORY_CUSTOM,
    _,
};
pub const SDL_LogCategory = enum_unnamed_68;
pub const SDL_LOG_PRIORITY_VERBOSE = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_VERBOSE);
pub const SDL_LOG_PRIORITY_DEBUG = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_DEBUG);
pub const SDL_LOG_PRIORITY_INFO = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_INFO);
pub const SDL_LOG_PRIORITY_WARN = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_WARN);
pub const SDL_LOG_PRIORITY_ERROR = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_ERROR);
pub const SDL_LOG_PRIORITY_CRITICAL = @enumToInt(enum_unnamed_69.SDL_LOG_PRIORITY_CRITICAL);
pub const SDL_NUM_LOG_PRIORITIES = @enumToInt(enum_unnamed_69.SDL_NUM_LOG_PRIORITIES);
const enum_unnamed_69 = extern enum(c_int) {
    SDL_LOG_PRIORITY_VERBOSE = 1,
    SDL_LOG_PRIORITY_DEBUG = 2,
    SDL_LOG_PRIORITY_INFO = 3,
    SDL_LOG_PRIORITY_WARN = 4,
    SDL_LOG_PRIORITY_ERROR = 5,
    SDL_LOG_PRIORITY_CRITICAL = 6,
    SDL_NUM_LOG_PRIORITIES = 7,
    _,
};
pub const SDL_LogPriority = enum_unnamed_69;
pub extern fn SDL_LogSetAllPriority(priority: SDL_LogPriority) void;
pub extern fn SDL_LogSetPriority(category: c_int, priority: SDL_LogPriority) void;
pub extern fn SDL_LogGetPriority(category: c_int) SDL_LogPriority;
pub extern fn SDL_LogResetPriorities() void;
pub extern fn SDL_Log(fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogVerbose(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogDebug(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogInfo(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogWarn(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogError(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogCritical(category: c_int, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogMessage(category: c_int, priority: SDL_LogPriority, fmt: [*c]const u8, ...) void;
pub extern fn SDL_LogMessageV(category: c_int, priority: SDL_LogPriority, fmt: [*c]const u8, ap: [*c]struct___va_list_tag) void;
pub const SDL_LogOutputFunction = ?fn (?*c_void, c_int, SDL_LogPriority, [*c]const u8) callconv(.C) void;
pub extern fn SDL_LogGetOutputFunction(callback: [*c]SDL_LogOutputFunction, userdata: [*c]?*c_void) void;
pub extern fn SDL_LogSetOutputFunction(callback: SDL_LogOutputFunction, userdata: ?*c_void) void;
pub const SDL_MESSAGEBOX_ERROR = @enumToInt(enum_unnamed_70.SDL_MESSAGEBOX_ERROR);
pub const SDL_MESSAGEBOX_WARNING = @enumToInt(enum_unnamed_70.SDL_MESSAGEBOX_WARNING);
pub const SDL_MESSAGEBOX_INFORMATION = @enumToInt(enum_unnamed_70.SDL_MESSAGEBOX_INFORMATION);
pub const SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = @enumToInt(enum_unnamed_70.SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT);
pub const SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = @enumToInt(enum_unnamed_70.SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT);
const enum_unnamed_70 = extern enum(c_int) {
    SDL_MESSAGEBOX_ERROR = 16,
    SDL_MESSAGEBOX_WARNING = 32,
    SDL_MESSAGEBOX_INFORMATION = 64,
    SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = 128,
    SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = 256,
    _,
};
pub const SDL_MessageBoxFlags = enum_unnamed_70;
pub const SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = @enumToInt(enum_unnamed_71.SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT);
pub const SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = @enumToInt(enum_unnamed_71.SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT);
const enum_unnamed_71 = extern enum(c_int) {
    SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 1,
    SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 2,
    _,
};
pub const SDL_MessageBoxButtonFlags = enum_unnamed_71;
const struct_unnamed_72 = extern struct {
    flags: Uint32,
    buttonid: c_int,
    text: [*c]const u8,
};
pub const SDL_MessageBoxButtonData = struct_unnamed_72;
const struct_unnamed_73 = extern struct {
    r: Uint8,
    g: Uint8,
    b: Uint8,
};
pub const SDL_MessageBoxColor = struct_unnamed_73;
pub const SDL_MESSAGEBOX_COLOR_BACKGROUND = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_BACKGROUND);
pub const SDL_MESSAGEBOX_COLOR_TEXT = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_TEXT);
pub const SDL_MESSAGEBOX_COLOR_BUTTON_BORDER = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_BUTTON_BORDER);
pub const SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND);
pub const SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED);
pub const SDL_MESSAGEBOX_COLOR_MAX = @enumToInt(enum_unnamed_74.SDL_MESSAGEBOX_COLOR_MAX);
const enum_unnamed_74 = extern enum(c_int) {
    SDL_MESSAGEBOX_COLOR_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_TEXT,
    SDL_MESSAGEBOX_COLOR_BUTTON_BORDER,
    SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND,
    SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED,
    SDL_MESSAGEBOX_COLOR_MAX,
    _,
};
pub const SDL_MessageBoxColorType = enum_unnamed_74;
const struct_unnamed_75 = extern struct {
    colors: [5]SDL_MessageBoxColor,
};
pub const SDL_MessageBoxColorScheme = struct_unnamed_75;
const struct_unnamed_76 = extern struct {
    flags: Uint32,
    window: ?*SDL_Window,
    title: [*c]const u8,
    message: [*c]const u8,
    numbuttons: c_int,
    buttons: [*c]const SDL_MessageBoxButtonData,
    colorScheme: [*c]const SDL_MessageBoxColorScheme,
};
pub const SDL_MessageBoxData = struct_unnamed_76;
pub extern fn SDL_ShowMessageBox(messageboxdata: [*c]const SDL_MessageBoxData, buttonid: [*c]c_int) c_int;
pub extern fn SDL_ShowSimpleMessageBox(flags: Uint32, title: [*c]const u8, message: [*c]const u8, window: ?*SDL_Window) c_int;
pub const SDL_MetalView = ?*c_void;
pub extern fn SDL_Metal_CreateView(window: ?*SDL_Window) SDL_MetalView;
pub extern fn SDL_Metal_DestroyView(view: SDL_MetalView) void;
pub const SDL_POWERSTATE_UNKNOWN = @enumToInt(enum_unnamed_77.SDL_POWERSTATE_UNKNOWN);
pub const SDL_POWERSTATE_ON_BATTERY = @enumToInt(enum_unnamed_77.SDL_POWERSTATE_ON_BATTERY);
pub const SDL_POWERSTATE_NO_BATTERY = @enumToInt(enum_unnamed_77.SDL_POWERSTATE_NO_BATTERY);
pub const SDL_POWERSTATE_CHARGING = @enumToInt(enum_unnamed_77.SDL_POWERSTATE_CHARGING);
pub const SDL_POWERSTATE_CHARGED = @enumToInt(enum_unnamed_77.SDL_POWERSTATE_CHARGED);
const enum_unnamed_77 = extern enum(c_int) {
    SDL_POWERSTATE_UNKNOWN,
    SDL_POWERSTATE_ON_BATTERY,
    SDL_POWERSTATE_NO_BATTERY,
    SDL_POWERSTATE_CHARGING,
    SDL_POWERSTATE_CHARGED,
    _,
};
pub const SDL_PowerState = enum_unnamed_77;
pub extern fn SDL_GetPowerInfo(secs: [*c]c_int, pct: [*c]c_int) SDL_PowerState;
pub const SDL_RENDERER_SOFTWARE = @enumToInt(enum_unnamed_78.SDL_RENDERER_SOFTWARE);
pub const SDL_RENDERER_ACCELERATED = @enumToInt(enum_unnamed_78.SDL_RENDERER_ACCELERATED);
pub const SDL_RENDERER_PRESENTVSYNC = @enumToInt(enum_unnamed_78.SDL_RENDERER_PRESENTVSYNC);
pub const SDL_RENDERER_TARGETTEXTURE = @enumToInt(enum_unnamed_78.SDL_RENDERER_TARGETTEXTURE);
const enum_unnamed_78 = extern enum(c_int) {
    SDL_RENDERER_SOFTWARE = 1,
    SDL_RENDERER_ACCELERATED = 2,
    SDL_RENDERER_PRESENTVSYNC = 4,
    SDL_RENDERER_TARGETTEXTURE = 8,
    _,
};
pub const SDL_RendererFlags = enum_unnamed_78;
pub const struct_SDL_RendererInfo = extern struct {
    name: [*c]const u8,
    flags: Uint32,
    num_texture_formats: Uint32,
    texture_formats: [16]Uint32,
    max_texture_width: c_int,
    max_texture_height: c_int,
};
pub const SDL_RendererInfo = struct_SDL_RendererInfo;
pub const SDL_ScaleModeNearest = @enumToInt(enum_unnamed_79.SDL_ScaleModeNearest);
pub const SDL_ScaleModeLinear = @enumToInt(enum_unnamed_79.SDL_ScaleModeLinear);
pub const SDL_ScaleModeBest = @enumToInt(enum_unnamed_79.SDL_ScaleModeBest);
const enum_unnamed_79 = extern enum(c_int) {
    SDL_ScaleModeNearest,
    SDL_ScaleModeLinear,
    SDL_ScaleModeBest,
    _,
};
pub const SDL_ScaleMode = enum_unnamed_79;
pub const SDL_TEXTUREACCESS_STATIC = @enumToInt(enum_unnamed_80.SDL_TEXTUREACCESS_STATIC);
pub const SDL_TEXTUREACCESS_STREAMING = @enumToInt(enum_unnamed_80.SDL_TEXTUREACCESS_STREAMING);
pub const SDL_TEXTUREACCESS_TARGET = @enumToInt(enum_unnamed_80.SDL_TEXTUREACCESS_TARGET);
const enum_unnamed_80 = extern enum(c_int) {
    SDL_TEXTUREACCESS_STATIC,
    SDL_TEXTUREACCESS_STREAMING,
    SDL_TEXTUREACCESS_TARGET,
    _,
};
pub const SDL_TextureAccess = enum_unnamed_80;
pub const SDL_TEXTUREMODULATE_NONE = @enumToInt(enum_unnamed_81.SDL_TEXTUREMODULATE_NONE);
pub const SDL_TEXTUREMODULATE_COLOR = @enumToInt(enum_unnamed_81.SDL_TEXTUREMODULATE_COLOR);
pub const SDL_TEXTUREMODULATE_ALPHA = @enumToInt(enum_unnamed_81.SDL_TEXTUREMODULATE_ALPHA);
const enum_unnamed_81 = extern enum(c_int) {
    SDL_TEXTUREMODULATE_NONE = 0,
    SDL_TEXTUREMODULATE_COLOR = 1,
    SDL_TEXTUREMODULATE_ALPHA = 2,
    _,
};
pub const SDL_TextureModulate = enum_unnamed_81;
pub const SDL_FLIP_NONE = @enumToInt(enum_unnamed_82.SDL_FLIP_NONE);
pub const SDL_FLIP_HORIZONTAL = @enumToInt(enum_unnamed_82.SDL_FLIP_HORIZONTAL);
pub const SDL_FLIP_VERTICAL = @enumToInt(enum_unnamed_82.SDL_FLIP_VERTICAL);
const enum_unnamed_82 = extern enum(c_int) {
    SDL_FLIP_NONE = 0,
    SDL_FLIP_HORIZONTAL = 1,
    SDL_FLIP_VERTICAL = 2,
    _,
};
pub const SDL_RendererFlip = enum_unnamed_82;
pub const struct_SDL_Renderer = @Type(.Opaque);
pub const SDL_Renderer = struct_SDL_Renderer;
pub const struct_SDL_Texture = @Type(.Opaque);
pub const SDL_Texture = struct_SDL_Texture;
pub extern fn SDL_GetNumRenderDrivers() c_int;
pub extern fn SDL_GetRenderDriverInfo(index: c_int, info: [*c]SDL_RendererInfo) c_int;
pub extern fn SDL_CreateWindowAndRenderer(width: c_int, height: c_int, window_flags: Uint32, window: [*c]?*SDL_Window, renderer: [*c]?*SDL_Renderer) c_int;
pub extern fn SDL_CreateRenderer(window: ?*SDL_Window, index: c_int, flags: Uint32) ?*SDL_Renderer;
pub extern fn SDL_CreateSoftwareRenderer(surface: [*c]SDL_Surface) ?*SDL_Renderer;
pub extern fn SDL_GetRenderer(window: ?*SDL_Window) ?*SDL_Renderer;
pub extern fn SDL_GetRendererInfo(renderer: ?*SDL_Renderer, info: [*c]SDL_RendererInfo) c_int;
pub extern fn SDL_GetRendererOutputSize(renderer: ?*SDL_Renderer, w: [*c]c_int, h: [*c]c_int) c_int;
pub extern fn SDL_CreateTexture(renderer: ?*SDL_Renderer, format: Uint32, access: c_int, w: c_int, h: c_int) ?*SDL_Texture;
pub extern fn SDL_CreateTextureFromSurface(renderer: ?*SDL_Renderer, surface: [*c]SDL_Surface) ?*SDL_Texture;
pub extern fn SDL_QueryTexture(texture: ?*SDL_Texture, format: [*c]Uint32, access: [*c]c_int, w: [*c]c_int, h: [*c]c_int) c_int;
pub extern fn SDL_SetTextureColorMod(texture: ?*SDL_Texture, r: Uint8, g: Uint8, b: Uint8) c_int;
pub extern fn SDL_GetTextureColorMod(texture: ?*SDL_Texture, r: [*c]Uint8, g: [*c]Uint8, b: [*c]Uint8) c_int;
pub extern fn SDL_SetTextureAlphaMod(texture: ?*SDL_Texture, alpha: Uint8) c_int;
pub extern fn SDL_GetTextureAlphaMod(texture: ?*SDL_Texture, alpha: [*c]Uint8) c_int;
pub extern fn SDL_SetTextureBlendMode(texture: ?*SDL_Texture, blendMode: SDL_BlendMode) c_int;
pub extern fn SDL_GetTextureBlendMode(texture: ?*SDL_Texture, blendMode: [*c]SDL_BlendMode) c_int;
pub extern fn SDL_SetTextureScaleMode(texture: ?*SDL_Texture, scaleMode: SDL_ScaleMode) c_int;
pub extern fn SDL_GetTextureScaleMode(texture: ?*SDL_Texture, scaleMode: [*c]SDL_ScaleMode) c_int;
pub extern fn SDL_UpdateTexture(texture: ?*SDL_Texture, rect: [*c]const SDL_Rect, pixels: ?*const c_void, pitch: c_int) c_int;
pub extern fn SDL_UpdateYUVTexture(texture: ?*SDL_Texture, rect: [*c]const SDL_Rect, Yplane: [*c]const Uint8, Ypitch: c_int, Uplane: [*c]const Uint8, Upitch: c_int, Vplane: [*c]const Uint8, Vpitch: c_int) c_int;
pub extern fn SDL_LockTexture(texture: ?*SDL_Texture, rect: [*c]const SDL_Rect, pixels: [*c]?*c_void, pitch: [*c]c_int) c_int;
pub extern fn SDL_LockTextureToSurface(texture: ?*SDL_Texture, rect: [*c]const SDL_Rect, surface: [*c][*c]SDL_Surface) c_int;
pub extern fn SDL_UnlockTexture(texture: ?*SDL_Texture) void;
pub extern fn SDL_RenderTargetSupported(renderer: ?*SDL_Renderer) SDL_bool;
pub extern fn SDL_SetRenderTarget(renderer: ?*SDL_Renderer, texture: ?*SDL_Texture) c_int;
pub extern fn SDL_GetRenderTarget(renderer: ?*SDL_Renderer) ?*SDL_Texture;
pub extern fn SDL_RenderSetLogicalSize(renderer: ?*SDL_Renderer, w: c_int, h: c_int) c_int;
pub extern fn SDL_RenderGetLogicalSize(renderer: ?*SDL_Renderer, w: [*c]c_int, h: [*c]c_int) void;
pub extern fn SDL_RenderSetIntegerScale(renderer: ?*SDL_Renderer, enable: SDL_bool) c_int;
pub extern fn SDL_RenderGetIntegerScale(renderer: ?*SDL_Renderer) SDL_bool;
pub extern fn SDL_RenderSetViewport(renderer: ?*SDL_Renderer, rect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_RenderGetViewport(renderer: ?*SDL_Renderer, rect: [*c]SDL_Rect) void;
pub extern fn SDL_RenderSetClipRect(renderer: ?*SDL_Renderer, rect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_RenderGetClipRect(renderer: ?*SDL_Renderer, rect: [*c]SDL_Rect) void;
pub extern fn SDL_RenderIsClipEnabled(renderer: ?*SDL_Renderer) SDL_bool;
pub extern fn SDL_RenderSetScale(renderer: ?*SDL_Renderer, scaleX: f32, scaleY: f32) c_int;
pub extern fn SDL_RenderGetScale(renderer: ?*SDL_Renderer, scaleX: [*c]f32, scaleY: [*c]f32) void;
pub extern fn SDL_SetRenderDrawColor(renderer: ?*SDL_Renderer, r: Uint8, g: Uint8, b: Uint8, a: Uint8) c_int;
pub extern fn SDL_GetRenderDrawColor(renderer: ?*SDL_Renderer, r: [*c]Uint8, g: [*c]Uint8, b: [*c]Uint8, a: [*c]Uint8) c_int;
pub extern fn SDL_SetRenderDrawBlendMode(renderer: ?*SDL_Renderer, blendMode: SDL_BlendMode) c_int;
pub extern fn SDL_GetRenderDrawBlendMode(renderer: ?*SDL_Renderer, blendMode: [*c]SDL_BlendMode) c_int;
pub extern fn SDL_RenderClear(renderer: ?*SDL_Renderer) c_int;
pub extern fn SDL_RenderDrawPoint(renderer: ?*SDL_Renderer, x: c_int, y: c_int) c_int;
pub extern fn SDL_RenderDrawPoints(renderer: ?*SDL_Renderer, points: [*c]const SDL_Point, count: c_int) c_int;
pub extern fn SDL_RenderDrawLine(renderer: ?*SDL_Renderer, x1: c_int, y1: c_int, x2: c_int, y2: c_int) c_int;
pub extern fn SDL_RenderDrawLines(renderer: ?*SDL_Renderer, points: [*c]const SDL_Point, count: c_int) c_int;
pub extern fn SDL_RenderDrawRect(renderer: ?*SDL_Renderer, rect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_RenderDrawRects(renderer: ?*SDL_Renderer, rects: [*c]const SDL_Rect, count: c_int) c_int;
pub extern fn SDL_RenderFillRect(renderer: ?*SDL_Renderer, rect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_RenderFillRects(renderer: ?*SDL_Renderer, rects: [*c]const SDL_Rect, count: c_int) c_int;
pub extern fn SDL_RenderCopy(renderer: ?*SDL_Renderer, texture: ?*SDL_Texture, srcrect: [*c]const SDL_Rect, dstrect: [*c]const SDL_Rect) c_int;
pub extern fn SDL_RenderCopyEx(renderer: ?*SDL_Renderer, texture: ?*SDL_Texture, srcrect: [*c]const SDL_Rect, dstrect: [*c]const SDL_Rect, angle: f64, center: [*c]const SDL_Point, flip: SDL_RendererFlip) c_int;
pub extern fn SDL_RenderDrawPointF(renderer: ?*SDL_Renderer, x: f32, y: f32) c_int;
pub extern fn SDL_RenderDrawPointsF(renderer: ?*SDL_Renderer, points: [*c]const SDL_FPoint, count: c_int) c_int;
pub extern fn SDL_RenderDrawLineF(renderer: ?*SDL_Renderer, x1: f32, y1: f32, x2: f32, y2: f32) c_int;
pub extern fn SDL_RenderDrawLinesF(renderer: ?*SDL_Renderer, points: [*c]const SDL_FPoint, count: c_int) c_int;
pub extern fn SDL_RenderDrawRectF(renderer: ?*SDL_Renderer, rect: [*c]const SDL_FRect) c_int;
pub extern fn SDL_RenderDrawRectsF(renderer: ?*SDL_Renderer, rects: [*c]const SDL_FRect, count: c_int) c_int;
pub extern fn SDL_RenderFillRectF(renderer: ?*SDL_Renderer, rect: [*c]const SDL_FRect) c_int;
pub extern fn SDL_RenderFillRectsF(renderer: ?*SDL_Renderer, rects: [*c]const SDL_FRect, count: c_int) c_int;
pub extern fn SDL_RenderCopyF(renderer: ?*SDL_Renderer, texture: ?*SDL_Texture, srcrect: [*c]const SDL_Rect, dstrect: [*c]const SDL_FRect) c_int;
pub extern fn SDL_RenderCopyExF(renderer: ?*SDL_Renderer, texture: ?*SDL_Texture, srcrect: [*c]const SDL_Rect, dstrect: [*c]const SDL_FRect, angle: f64, center: [*c]const SDL_FPoint, flip: SDL_RendererFlip) c_int;
pub extern fn SDL_RenderReadPixels(renderer: ?*SDL_Renderer, rect: [*c]const SDL_Rect, format: Uint32, pixels: ?*c_void, pitch: c_int) c_int;
pub extern fn SDL_RenderPresent(renderer: ?*SDL_Renderer) void;
pub extern fn SDL_DestroyTexture(texture: ?*SDL_Texture) void;
pub extern fn SDL_DestroyRenderer(renderer: ?*SDL_Renderer) void;
pub extern fn SDL_RenderFlush(renderer: ?*SDL_Renderer) c_int;
pub extern fn SDL_GL_BindTexture(texture: ?*SDL_Texture, texw: [*c]f32, texh: [*c]f32) c_int;
pub extern fn SDL_GL_UnbindTexture(texture: ?*SDL_Texture) c_int;
pub extern fn SDL_RenderGetMetalLayer(renderer: ?*SDL_Renderer) ?*c_void;
pub extern fn SDL_RenderGetMetalCommandEncoder(renderer: ?*SDL_Renderer) ?*c_void;
pub const struct__SDL_Sensor = @Type(.Opaque);
pub const SDL_Sensor = struct__SDL_Sensor;
pub const SDL_SensorID = i32;
pub const SDL_SENSOR_INVALID = @enumToInt(enum_unnamed_83.SDL_SENSOR_INVALID);
pub const SDL_SENSOR_UNKNOWN = @enumToInt(enum_unnamed_83.SDL_SENSOR_UNKNOWN);
pub const SDL_SENSOR_ACCEL = @enumToInt(enum_unnamed_83.SDL_SENSOR_ACCEL);
pub const SDL_SENSOR_GYRO = @enumToInt(enum_unnamed_83.SDL_SENSOR_GYRO);
const enum_unnamed_83 = extern enum(c_int) {
    SDL_SENSOR_INVALID = -1,
    SDL_SENSOR_UNKNOWN = 0,
    SDL_SENSOR_ACCEL = 1,
    SDL_SENSOR_GYRO = 2,
    _,
};
pub const SDL_SensorType = enum_unnamed_83;
pub extern fn SDL_NumSensors() c_int;
pub extern fn SDL_SensorGetDeviceName(device_index: c_int) [*c]const u8;
pub extern fn SDL_SensorGetDeviceType(device_index: c_int) SDL_SensorType;
pub extern fn SDL_SensorGetDeviceNonPortableType(device_index: c_int) c_int;
pub extern fn SDL_SensorGetDeviceInstanceID(device_index: c_int) SDL_SensorID;
pub extern fn SDL_SensorOpen(device_index: c_int) ?*SDL_Sensor;
pub extern fn SDL_SensorFromInstanceID(instance_id: SDL_SensorID) ?*SDL_Sensor;
pub extern fn SDL_SensorGetName(sensor: ?*SDL_Sensor) [*c]const u8;
pub extern fn SDL_SensorGetType(sensor: ?*SDL_Sensor) SDL_SensorType;
pub extern fn SDL_SensorGetNonPortableType(sensor: ?*SDL_Sensor) c_int;
pub extern fn SDL_SensorGetInstanceID(sensor: ?*SDL_Sensor) SDL_SensorID;
pub extern fn SDL_SensorGetData(sensor: ?*SDL_Sensor, data: [*c]f32, num_values: c_int) c_int;
pub extern fn SDL_SensorClose(sensor: ?*SDL_Sensor) void;
pub extern fn SDL_SensorUpdate() void;
pub extern fn SDL_CreateShapedWindow(title: [*c]const u8, x: c_uint, y: c_uint, w: c_uint, h: c_uint, flags: Uint32) ?*SDL_Window;
pub extern fn SDL_IsShapedWindow(window: ?*const SDL_Window) SDL_bool;
pub const ShapeModeDefault = @enumToInt(enum_unnamed_84.ShapeModeDefault);
pub const ShapeModeBinarizeAlpha = @enumToInt(enum_unnamed_84.ShapeModeBinarizeAlpha);
pub const ShapeModeReverseBinarizeAlpha = @enumToInt(enum_unnamed_84.ShapeModeReverseBinarizeAlpha);
pub const ShapeModeColorKey = @enumToInt(enum_unnamed_84.ShapeModeColorKey);
const enum_unnamed_84 = extern enum(c_int) {
    ShapeModeDefault,
    ShapeModeBinarizeAlpha,
    ShapeModeReverseBinarizeAlpha,
    ShapeModeColorKey,
    _,
};
pub const WindowShapeMode = enum_unnamed_84;
const union_unnamed_85 = extern union {
    binarizationCutoff: Uint8,
    colorKey: SDL_Color,
};
pub const SDL_WindowShapeParams = union_unnamed_85;
pub const struct_SDL_WindowShapeMode = extern struct {
    mode: WindowShapeMode,
    parameters: SDL_WindowShapeParams,
};
pub const SDL_WindowShapeMode = struct_SDL_WindowShapeMode;
pub extern fn SDL_SetWindowShape(window: ?*SDL_Window, shape: [*c]SDL_Surface, shape_mode: [*c]SDL_WindowShapeMode) c_int;
pub extern fn SDL_GetShapedWindowMode(window: ?*SDL_Window, shape_mode: [*c]SDL_WindowShapeMode) c_int;
pub extern fn SDL_IsTablet() SDL_bool;
pub extern fn SDL_OnApplicationWillTerminate() void;
pub extern fn SDL_OnApplicationDidReceiveMemoryWarning() void;
pub extern fn SDL_OnApplicationWillResignActive() void;
pub extern fn SDL_OnApplicationDidEnterBackground() void;
pub extern fn SDL_OnApplicationWillEnterForeground() void;
pub extern fn SDL_OnApplicationDidBecomeActive() void;
pub extern fn SDL_GetTicks() Uint32;
pub extern fn SDL_GetPerformanceCounter() Uint64;
pub extern fn SDL_GetPerformanceFrequency() Uint64;
pub extern fn SDL_Delay(ms: Uint32) void;
pub const SDL_TimerCallback = ?fn (Uint32, ?*c_void) callconv(.C) Uint32;
pub const SDL_TimerID = c_int;
pub extern fn SDL_AddTimer(interval: Uint32, callback: SDL_TimerCallback, param: ?*c_void) SDL_TimerID;
pub extern fn SDL_RemoveTimer(id: SDL_TimerID) SDL_bool;
pub const struct_SDL_version = extern struct {
    major: Uint8,
    minor: Uint8,
    patch: Uint8,
};
pub const SDL_version = struct_SDL_version;
pub extern fn SDL_GetVersion(ver: [*c]SDL_version) void;
pub extern fn SDL_GetRevision() [*c]const u8;
pub extern fn SDL_GetRevisionNumber() c_int;
pub extern fn SDL_Init(flags: Uint32) c_int;
pub extern fn SDL_InitSubSystem(flags: Uint32) c_int;
pub extern fn SDL_QuitSubSystem(flags: Uint32) void;
pub extern fn SDL_WasInit(flags: Uint32) Uint32;
pub extern fn SDL_Quit() void;

pub const SDL_BUTTON_RMASK = SDL_BUTTON(SDL_BUTTON_RIGHT);
pub const SDL_RLEACCEL = 0x00000002;

pub const SDL_BUTTON_RIGHT = 3;

pub const SDL_VIDEO_OPENGL_CGL = 1;
pub const SDL_HINT_WINDOWS_ENABLE_MESSAGELOOP = "SDL_WINDOWS_ENABLE_MESSAGELOOP";
pub const SDL_PREALLOC = 0x00000001;
pub const SDL_HAPTIC_SAWTOOTHUP = @as(c_uint, 1) << 4;

pub inline fn SDL_LoadWAV(file: var, spec: var, audio_buf: var, audio_len: var) @TypeOf(SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len)) {
    return SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"), 1, spec, audio_buf, audio_len);
}

pub const SDL_WINDOWPOS_UNDEFINED_MASK = @as(c_uint, 0x1FFF0000);
pub inline fn SDL_WINDOWPOS_UNDEFINED_DISPLAY(X: var) @TypeOf(SDL_WINDOWPOS_UNDEFINED_MASK | X) {
    return SDL_WINDOWPOS_UNDEFINED_MASK | X;
}
pub const SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_DISPLAY(0);
pub const SDL_WINDOWPOS_CENTERED = SDL_WINDOWPOS_CENTERED_DISPLAY(0);
pub const SDL_WINDOWPOS_CENTERED_MASK = @as(c_uint, 0x2FFF0000);

pub inline fn SDL_SCANCODE_TO_KEYCODE(X: var) @TypeOf(X | SDLK_SCANCODE_MASK) {
    return X | SDLK_SCANCODE_MASK;
}

pub const SDL_INIT_AUDIO = @as(c_uint, 0x00000010);
pub const SDL_INIT_VIDEO = @as(c_uint, 0x00000020);
pub const SDL_INIT_JOYSTICK = @as(c_uint, 0x00000200);
pub const SDL_INIT_HAPTIC = @as(c_uint, 0x00001000);
pub const SDL_INIT_EVERYTHING = SDL_INIT_TIMER | (SDL_INIT_AUDIO | (SDL_INIT_VIDEO | (SDL_INIT_EVENTS | (SDL_INIT_JOYSTICK | (SDL_INIT_HAPTIC | (SDL_INIT_GAMECONTROLLER | SDL_INIT_SENSOR))))));
