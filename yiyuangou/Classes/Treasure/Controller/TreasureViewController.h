//
//  TreasureViewController.h
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TreasureViewController : YMBaseViewController

@property (copy, nonatomic)NSString * titleName;

@property (assign, nonatomic)NSInteger gid;

@property (assign, nonatomic)NSInteger  uid;
//是否隐藏返回按钮
@property (assign,nonatomic)BOOL isHiden;
//主要用于进入晒单,是否隐藏tabar,即是否执行图片发放大
@property (assign,nonatomic)BOOL ishidenTabar;

@end
