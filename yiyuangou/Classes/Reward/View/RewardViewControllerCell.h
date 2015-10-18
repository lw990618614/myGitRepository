//
//  RewardViewControllerCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardViewControllerCell : UITableViewCell
@property (nonatomic,strong)UIImageView * iconView;
@property (strong, nonatomic) UILabel* productionLabel;
@property (strong, nonatomic) UILabel* priceLable;
@property (strong ,nonatomic) UIButton* timeClock;
@property (copy , nonatomic) NSString *isClock;
@property (nonatomic,strong) UIView *messageView;
@property (strong, nonatomic) UILabel* getterLable;
@property (nonatomic,strong) UILabel *totalLable;
@property (strong, nonatomic) UILabel* timeLable;

-(id)configWithMode;
@end
