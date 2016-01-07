//
//  YMPayResultCell.h
//  yiyuangou
//
//  Created by roen on 15/11/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCheckRusult.h"
@interface YMPayResultCell : UITableViewCell
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong) UILabel *productionLable;
@property (nonatomic ,strong)UILabel *timeLabel ;
@property (nonatomic,strong)UILabel *allNumber;
-(id)configWithMode:(GoodInfos*)result;
@end
