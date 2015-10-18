//
//  YMProcess.h
//  mobi
//
//  Created by Simon on 9/9/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMProcess : NSObject


@property (strong, nonatomic) NSString* pName;

@property ( nonatomic) pid_t pid;

@property (nonatomic, strong) NSString* pCommandLine;

@property (nonatomic, strong) NSDate* pStartTime;

@end
