//
//  YMProcessManager.h
//  mobi
//
//  Created by Simon on 9/9/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMProcessManager : NSObject{
    
}

+ (id)sharedManager;

+ (NSMutableArray*) allUserProcesses;

+ (NSArray*) allProcesses;

+ (NSDate*)appStartedtime:(NSString*)pName;

@end


NSString *nameForProcessWithPID(pid_t pidNum);

