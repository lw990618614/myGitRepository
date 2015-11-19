//
//  YMDetailViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDetailResult.h"
@interface YMDetailViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel*  personLable;
@property (strong, nonatomic) UILabel*  detailLable;
-(id)configWithModel:(YMTotalList *)list;
@end
