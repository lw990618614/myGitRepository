//
//  YMShaiDanViewController.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/5.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
//晒单页面
@interface YMShaiDanViewController : YMBaseViewController
-(instancetype)initWithImageArray:(NSArray *) imgArray;
@property(nonatomic,strong) NSNumber *gsid;//商品ID
@property(nonatomic,strong) NSNumber *grid;//中奖ID
@end
