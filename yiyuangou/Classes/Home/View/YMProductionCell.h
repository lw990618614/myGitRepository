//
//  YMProductionCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMProductionCell : UITableViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* nameLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UILabel* messgeLable;
@property (strong, nonatomic) UILabel* stateLable;
@property (strong, nonatomic) UIImageView * pictureView;
@property (strong, nonatomic) UILabel* describeLable;

-(id)configWithMode;
@end
