//
//  YMCalculateCell.h
//  yiyuangou
//
//  Created by roen on 15/11/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMCaculateResult.h"
@interface YMCalculateCell : UITableViewCell
@property (nonatomic,strong)UILabel *timeLable;
@property (nonatomic,strong)UILabel *contentLalbe;
-(id)congfigWithModel:(detailInfo *)model;

@end
