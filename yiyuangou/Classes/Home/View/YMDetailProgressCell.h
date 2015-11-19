//
//  YMDetailProgressCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMDetailResult.h"
@interface YMDetailProgressCell : UITableViewCell
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UILabel* progressLable;
@property (strong, nonatomic) UIProgressView* progressView;
@property (strong, nonatomic) UILabel* totalLabel;
@property (strong, nonatomic) UILabel* leftLable;
@property (strong, nonatomic) UILabel* progressNumber;
-(id)congifgWithMode:(YMDetailResult *)model;
@end
