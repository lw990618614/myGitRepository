//
//  YMRecievedCell.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMRecievedCell.h"

@implementation YMRecievedCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        self.iconView.image = [UIImage imageNamed:@"searchSelIcon"];
        [self.contentView addSubview:self.iconView];
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabel.text = @"iphone 6s 就这么吊";
        [self.contentView addSubview:self.productionLabel];
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLable.text = @"我的参与次数： 123次";
        [self.contentView addSubview:self.totalLable];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间：2015-19-09 14：34：34";
        [self.contentView addSubview:self.timeLable];
        
        self.recivedButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 120, 10, 50, 50) target:self action:@selector(recivedButtonclick) title:@"领奖" cornerRadius:2];
        [self.recivedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.recivedButton.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.recivedButton];
        self.recivedButton.centerY  = self.totalLable.centerY;
        
        self.displayButton = [UIButton buttonWithFrame:CGRectMake(self.recivedButton.tmri_right+10, self.totalLable.centerY, 50, 50) target:self action:@selector(displayButtonclick) title:@"晒单" cornerRadius:2];
        [self.displayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.displayButton.backgroundColor = [UIColor blueColor];
        self.displayButton.centerY  = self.totalLable.centerY;
        [self.contentView addSubview:self.displayButton];
        
    }
    return self;
}
-(id)congfigWithModle
{
    return self;
}
-(void)recivedButtonclick
{
    NSLog(@"recivedButtonclick");
}
-(void)displayButtonclick
{
    NSLog(@"displayButtonclick");
}

@end
