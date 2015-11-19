//
//  YMPassWordCell.m
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPassWordCell.h"

@implementation YMPassWordCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.loginView = [[UIView alloc] initWithFrame:CGRectMake(10, 20, kWIDTH - 20- 125, 40)];
        self.loginView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.loginView.layer.borderWidth = 1;
        [self.contentView addSubview:self.loginView];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 30)];
        [self.loginView addSubview:self.iconView];
    }
    return self;
}
@end
