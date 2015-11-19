//
//  TreasureResult.h
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface TreasureResult : BaseResult
@property (strong, nonatomic) NSArray* shareList;

@end

@interface ShareProduction : NSObject
@property (copy, nonatomic) NSString* face;
@property (assign, nonatomic)NSInteger status;
@property (strong, nonatomic) NSArray* imageList;
@property (copy, nonatomic) NSString* name;
@property (copy, nonatomic) NSString* createTime;
@property (copy, nonatomic) NSString* descrip;
@property (copy, nonatomic) NSString* sname;//用户名
@property (copy, nonatomic) NSString* period;
@property (assign,nonatomic)NSInteger height;
@property (assign,nonatomic)NSInteger imageHeight;

@end
@interface SharePicture : NSObject

@property (copy, nonatomic) NSString* imageUrl;

@end