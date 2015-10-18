//
//  YMListCell.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMListCell : UITableViewCell
@property (strong, nonatomic) UIImageView * iconView;
@property (strong, nonatomic) UILabel* productionLabel;
@property (strong, nonatomic) UILabel* totalLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UILabel* phoneLable;
-(id)congfigWithModle;
@end
