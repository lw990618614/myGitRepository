//
//  YMTreasureFrame.h
//  yiyuangou
//
//  Created by roen on 15/10/29.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TreasureResult.h"
@interface YMTreasureFrame : NSObject
@property (strong, nonatomic) ShareProduction* treasure;
@property (assign,nonatomic)NSInteger  unPredictHeight;
-(CGFloat)cellHeight;
@end
