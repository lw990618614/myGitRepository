//
//  RewardViewControllerCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"
#import "YMRewardResult.h"
#import "YMTimerClock.h"
@class RewardViewControllerCell;
@protocol RewardCellDelegate<NSObject>
@optional
- (void)timedownDidEnd:(RewardViewControllerCell *)cell;
@end

@interface RewardViewControllerCell : UITableViewCell
@property (nonatomic,strong)UIImageView * iconView;
@property (strong, nonatomic) UILabel* productionLabel;
@property (strong, nonatomic) UILabel* priceLable;
@property (strong, nonatomic)UIImageView *pictureView;
@property (strong,nonatomic)YMTimerClock *runTime;
@property (strong ,nonatomic) TTCounterLabel* timeClock;
@property (copy , nonatomic) NSString *isClock;
@property (nonatomic,strong) UIView *messageView;
@property (strong, nonatomic) UILabel* getterLable;
@property (nonatomic,strong) UILabel *totalLable;
@property (nonatomic,strong) UILabel *phoneLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,weak)id<RewardCellDelegate>delegate;
-(id)configWithMode:(id)model;
@end
