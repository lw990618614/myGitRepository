//
//  YMSetPassWordController.h
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMVerfyResult.h"
#import "YMRegisterViewController.h"
@interface YMSetPassWordController : YMBaseViewController
@property (strong, nonatomic) YMVerfyResult* model;
@property(nonatomic,assign)inputMethod ways;
@end
