//
//  YMAcceptViewController.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,InputType)
{
    YMRewardList, //中奖记录
    YMMySetting,  //我的页面
    YMOther       //其他页面
};
@interface YMAcceptViewController : YMBaseViewController
-(void) refreshData:(NSDictionary *)dict;
@property(nonatomic,assign)InputType type;
@property(nonatomic,assign) BOOL isFromBindPhone;
@property(nonatomic,strong)NSDictionary *rewardDic;

@end
