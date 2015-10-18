//
//  MyCarViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCarViewCell.h"
#import "PKYStepper.h"
@interface MyCarViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView* roundView;
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UILabel* detailLable;
@property (strong, nonatomic) PKYStepper*numbersView;
@property (strong, nonatomic) UIImageView* pictureView;
@property (strong, nonatomic) UILabel* messageLable;
-(id)configWithMode;
@end
