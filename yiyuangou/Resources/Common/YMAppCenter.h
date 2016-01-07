//
//  YMAppCenter.h
//  mobi
//
//  Created by Simon on 8/28/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMProcessManager.h"
#import "udidhelper.h"

@interface YMAppCenter : NSObject

+ (id)sharedManager;


+ (NSString*) getMacAddress;



@end
