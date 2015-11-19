//
//  YMRewardPersonCell.h
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDetailResult.h"
@interface YMRewardPersonCell : UITableViewCell
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UILabel* stateView;
@property (strong, nonatomic) UIView* lineView;
@property (strong, nonatomic) UILabel* pastGetterLable;
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* phoneLable;
@property (strong, nonatomic) UILabel* totalLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UILabel* luckLable;
@property (strong, nonatomic) UIButton *checkluckButton;
-(id)congifgWithMode:(YMDetailResult *)model;

@end
