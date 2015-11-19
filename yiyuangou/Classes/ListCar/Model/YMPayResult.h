//
//  YMPayResult.h
//  yiyuangou
//
//  Created by roen on 15/10/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMPayResult : BaseResult

@property (copy, nonatomic) NSString* result;

@property (assign, nonatomic) NSInteger oid;

@property (assign, nonatomic) NSInteger coin;

@property (assign, nonatomic) NSInteger toatlPrice;

@property (copy, nonatomic) NSString* transid;

@property (copy, nonatomic) NSString* url;

@property (strong,nonatomic)NSArray *goodsNoteList;

@end

@interface YMGoodInfo : NSObject

@property (copy, nonatomic) NSString* name;

@property (copy, nonatomic) NSString* number;

@property (copy, nonatomic) NSString* left;

@end