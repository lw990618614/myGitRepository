//
//  YMUser.m
//  mobi
//
//  Created by Simon on 9/11/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import "YMUser.h"

@implementation YMUser


-(id)init{
    self=[super init];
    if (self) {
        self.userScore=[[YMUserScore alloc]init];
    }
    return self;
}
@end
