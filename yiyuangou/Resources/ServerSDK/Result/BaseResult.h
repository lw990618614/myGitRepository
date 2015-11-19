//
//  BaseResult.h
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseResult : NSObject
@property (copy, nonatomic) NSString* data;

@property (assign, nonatomic) NSInteger code;

@property (copy, nonatomic) NSString* msg;

-(BOOL)isSuceess;

-(BOOL)isaLackParam;

-(BOOL)isOther;

@end
