//
//  YMGetCoinController.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MySettingViewController.h"
typedef NS_ENUM(NSUInteger,platformType)
{
    YMWeiXin,
    YMWeiBo,
    YMQQ
};
@interface YMGetCoinController : YMBaseTableViewController
@property(nonatomic,strong)MySettingViewController *mySetting;
@end
