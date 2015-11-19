//
//  YMDetailTimeCell.h
//  yiyuangou
//
//  Created by roen on 15/10/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"
#import "YMDetailResult.h"
@class YMDetailTimeCell;
@protocol YMDetailTimeCellDelegate<NSObject>
@optional
- (void)timedownDidEnd:(YMDetailTimeCell *)cell;
@end

@interface YMDetailTimeCell : UITableViewCell
@property (weak, nonatomic) id<YMDetailTimeCellDelegate> delegate;

@property (strong, nonatomic) UILabel* productionLable;
@property (strong,nonatomic) UIButton *notiButton;
@property (nonatomic,strong)UILabel *showingLable;
@property (nonatomic,strong)UILabel *timeString;
@property (nonatomic,strong)UIButton *luckButton;
@property (nonatomic,strong)TTCounterLabel *timelable;
@property (nonatomic, strong)UIButton *ruleButton;
-(id)congfigWithModel:(YMDetailResult *)model;
@end
