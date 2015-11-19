//
//  YMPastViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMPastRewardResult.h"
@interface YMPastViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* productionLabe;
@property (strong, nonatomic) UILabel* priceLable;
@property (strong, nonatomic) UILabel* getterLable;
@property (strong, nonatomic) UILabel* totalLable;
@property (strong, nonatomic) UILabel* timeLable;
-(id)configWithModel:(YMLottery *)model;
@end
