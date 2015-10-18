//
//  YMHomeCollectionViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/8.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeCollectionViewCell.h"
#import "UILabel+tmri.h"
#import "UIView+tmri.h"
@implementation YMHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-kWIDTH/4.0)/2.0, 10, kWIDTH/4.0, 60)];
        self.iconView.image = [UIImage imageNamed:@"img_04"];
        [self.contentView addSubview:self.iconView];

        self.detailLable = [UILabel labelWithFrame:CGRectMake(15, self.iconView.tmri_bottom+10, frame.size.width - 30, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.detailLable.text = @"iPhone 6S 玫瑰金 16GB";
        [self.contentView addSubview:self.detailLable];
        
        self.progressLable = [UILabel labelWithFrame:CGRectMake(15, self.detailLable.tmri_bottom+10, frame.size.width - 30, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.progressLable.text = @"开奖进度：76%";
        [self.contentView addSubview:self.progressLable];

        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(15,self.progressLable.tmri_bottom+10 , frame.size.width *0.5, 10)];
        self.progressView.progress = 0.75;
        self.progressView.progressTintColor = [UIColor redColor];
        [self.contentView addSubview:self.progressView];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f,4.0f);
        self.progressView.layer.cornerRadius=5;
        self.progressView.layer.masksToBounds = YES;

        self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(self.progressView.tmri_right+5, self.detailLable.tmri_bottom, 30, 30)];
        self.carView.image = [UIImage imageNamed:@"share_02"];
        [self.contentView addSubview:self.carView];
        
        self.buyView = [[UIImageView alloc] initWithFrame:CGRectMake(self.carView.tmri_right+5, self.detailLable.tmri_bottom, 30, 30)];
        self.buyView.image = [UIImage imageNamed:@"share_01"];
        [self.contentView addSubview:self.buyView];
        self.carView.centerY = self.buyView.centerY = self.progressLable.tmri_bottom;
        
        self.middleView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width -1, 0, 1, frame.size.height)];
        self.middleView.backgroundColor= [UIColor grayColor];
        [self.contentView addSubview:self.middleView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height -1, frame.size.width, 1)];
        bottomView.backgroundColor= [UIColor grayColor];
        [self.contentView addSubview:bottomView];

    }
    return self;
}
-(id)configWithMode
{
    return self;
}
@end
