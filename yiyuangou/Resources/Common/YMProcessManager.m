//
//  YMProcessManager.m
//  mobi
//
//  Created by Simon on 9/9/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import "YMProcessManager.h"
#import "YMProcess.h"
#import <unistd.h>
#import <string.h>
#import <sys/sysctl.h>
#import <sys/time.h>
#import <sys/types.h>
#import <pwd.h>



@implementation YMProcessManager

+ (id)sharedManager {
    static YMProcessManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

+ (NSArray*) allProcesses{
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:1];
    struct kinfo_proc *kp;
    int mib[4], nentries, i;
    size_t bufSize = 0;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROC;
    mib[2] = KERN_PROC_ALL;
    mib[3] = 0;
    
    if ( sysctl(mib, 4, NULL, &bufSize, NULL, 0) < 0 ) {
        return returnArray;
    }
    
    kp = (struct kinfo_proc *)malloc( bufSize );
    if ( kp == NULL ) {
        return returnArray;
    }
    if ( sysctl(mib, 4, kp, &bufSize, NULL, 0) < 0 ) {
        free( kp );
        return returnArray;
    }
    
    nentries = bufSize / sizeof(struct kinfo_proc);
    
    if ( nentries == 0 ) {
        free( kp );
        return returnArray;
    }
    
    for ( i = (nentries - 1); --i >= 0; ) {
        
        YMProcess *ymp=[[YMProcess alloc]init];
        ymp.pid=(&kp[i])->kp_proc.p_pid;
        ymp.pName=[[NSString alloc] initWithFormat:@"%s", (&kp[i])->kp_proc.p_comm];
        
        ymp.pCommandLine=nameForProcessWithPID( (&kp[i])->kp_proc.p_pid);
        time_t procStartTime = ((&kp[i])->kp_proc.p_starttime.tv_sec);
        ymp.pStartTime = [NSDate dateWithTimeIntervalSince1970:procStartTime];
        
        [returnArray addObject:ymp];
    }
    
    free( kp );
    
    return returnArray;
    
}

+(NSMutableArray*) allUserProcesses{
    
    NSMutableArray *allUserProcess = [[NSMutableArray alloc] init];
    NSArray *allproc=[self allProcesses];
    for (YMProcess *ymp in allproc) {
        if (ymp.pCommandLine && [ymp.pCommandLine hasPrefix:@"/private/var/mobile/"]) {
            [allUserProcess addObject:ymp];
        }
    }
    return allUserProcess;
}

+(NSDate*)appStartedtime:(NSString *)pName{
    NSDate* startTime=nil;
    for (YMProcess *ymp in [YMProcessManager allUserProcesses]) {
        if ([ymp.pName isEqualToString:pName]) {
            startTime = ymp.pStartTime;
            break;
        }
    }
    return startTime;
}



@end

NSString *nameForProcessWithPID(pid_t pidNum){
    NSString *returnString = nil;
    int mib[4], maxarg = 0, numArgs = 0;
    size_t size = 0;
    char *args = NULL, *namePtr = NULL, *stringPtr = NULL;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_ARGMAX;
    
    size = sizeof(maxarg);
    if ( sysctl(mib, 2, &maxarg, &size, NULL, 0) == -1 ) {
        return nil;
    }
    
    args = (char *)malloc( maxarg );
    if ( args == NULL ) {
        return nil;
    }
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_PROCARGS2;
    mib[2] = pidNum;
    
    size = (size_t)maxarg;
    if ( sysctl(mib, 3, args, &size, NULL, 0) == -1 ) {
        free( args );
        return nil;
    }
    
    memcpy( &numArgs, args, sizeof(numArgs) );
    stringPtr = args + sizeof(numArgs);
    
    returnString = [[NSString alloc] initWithUTF8String:stringPtr];
    
//    if ( (namePtr = strrchr(stringPtr, '/')) != NULL ) {
//        *namePtr++;
//        returnString = [[NSString alloc] initWithUTF8String:namePtr];
//    } else {
//        returnString = [[NSString alloc] initWithUTF8String:stringPtr];
//    }
    
    return returnString;
}


