//
//  watcher.c
//  FileWatcher
//
//  Created by Mike Desaro on 11/3/23.
//

#include "watcher.h"

FileWatcherCallback file_watcher_callback;

unsigned long hash(char *str) {
    unsigned long hash = 5381;
    int c;

    while ((c = *str++))
        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */

    return hash;
}

void fs_event_callback(
    ConstFSEventStreamRef streamRef,
    void *clientCallBackInfo,
    size_t numEvents,
    void *eventPaths,
    const FSEventStreamEventFlags eventFlags[],
    const FSEventStreamEventId eventIds[])
{
    int i;
    char **paths = eventPaths;

    unsigned long arr[25];
    int arr_cnt = 0;

    for (i = 0; i < numEvents; i++) {
        int len = strlen(paths[i]);
        if (paths[i][len - 1] == '~') continue;

        if (eventFlags[i] & kFSEventStreamEventFlagItemIsFile) {
            if (eventFlags[i] & kFSEventStreamEventFlagItemModified
                || eventFlags[i] & kFSEventStreamEventFlagItemCreated
                || eventFlags[i] & kFSEventStreamEventFlagItemRenamed)
            {
                bool found_file = false;
                unsigned long hashed_str = hash(paths[i]);
                for (int i = 0; i < arr_cnt; i++) {
                    if (arr[i] == hashed_str) {
                        found_file = true;
                        continue;
                    }
                }
                if (found_file) continue;

                arr[arr_cnt++] = hashed_str;

                file_watcher_callback(paths[i]);
            }
        }
   }
}


void file_watcher_watch_path(const char * path, FileWatcherCallback callback) {
    file_watcher_callback = callback;

    CFStringRef mypath = CFStringCreateWithCString(kCFAllocatorDefault, path, kCFStringEncodingUTF8);
    CFArrayRef pathsToWatch = CFArrayCreate(NULL, (const void **)&mypath, 1, NULL);

    void *callbackInfo = NULL; // could put stream-specific data here.
    CFAbsoluteTime latency = 1.0; // Latency in seconds, f64

    FSEventStreamRef stream = FSEventStreamCreate(NULL,
        &fs_event_callback,
        callbackInfo,
        pathsToWatch,
        kFSEventStreamEventIdSinceNow, /* Or a previous event ID */
        latency,
        kFSEventStreamCreateFlagFileEvents /* Flags explained in reference */
    );

    FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    FSEventStreamStart(stream);
}
