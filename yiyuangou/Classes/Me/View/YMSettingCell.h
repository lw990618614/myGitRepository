//
//  YMSettingCell.h
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMSettingResult.h"
@protocol YMSettingProtol <NSObject>
-(void) accoutChange;
@end

@interface YMSettingCell : UITableViewCell
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *accountLable;
@property (nonatomic,strong)UILabel *userNameLable;
@property (nonatomic,strong)UILabel *leftLable;
@property (strong, nonatomic) UIButton* fillButton;
@property(nonatomic,assign) float originY;
@property(nonatomic,assign) id<YMSettingProtol>delegate;
-(id)congifgWithMode:(YMSettingResult *)model;
@end
