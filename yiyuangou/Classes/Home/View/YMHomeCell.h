//
//  YMHomeCell.h
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"
@interface YMHomeCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UIButton *prizeButton;
@property (strong,nonatomic) TTCounterLabel *Counter;
-(id)configWithMode;
@end
