//
//  YMRecievedCell.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMRecievedCell.h"
#import "UIImageView+WebCache.h"
#import "YMProgress.h"
@implementation YMRecievedCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
        self.iconView.layer.borderWidth = 0.5;
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        [self.contentView addSubview:self.iconView];
        
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.iconView.orignY + 10, kWIDTH - 100, 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabel.text = @"iphone 6s 就这么吊";
        self.productionLabel.numberOfLines =  2.0;
        self.productionLabel.font = [UIFont systemFontOfSize:14];
        self.productionLabel.textColor = [UIColor heightBlacKColor];
        [self.contentView addSubview:self.productionLabel];
        
        self.fortuneNumlbl = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom + 0, 70, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.fortuneNumlbl.text = @"幸运号码：";
        self.fortuneNumlbl.font = [UIFont systemFontOfSize:12];
        self.fortuneNumlbl.textColor = [UIColor lightColor];
        [self.contentView addSubview:self.fortuneNumlbl];
        self.fortuneNum = [[UILabel alloc] initWithFrame:CGRectMake(self.fortuneNumlbl.tmri_right + 10, self.fortuneNumlbl.orignY, 120, 20)];
        self.fortuneNum.textColor = [UIColor heightBlacKColor];
        self.fortuneNum.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:self.fortuneNum];
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.fortuneNumlbl.orignX, self.fortuneNumlbl.tmri_bottom  + 5,180, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间：2015-19-09 14：34：34";
        self.timeLable.font = [UIFont systemFontOfSize:12.0];
        self.timeLable.textColor = [UIColor lightColor];
        [self.contentView addSubview:self.timeLable];
            self.progess = [[YMProgress alloc] initWithFrame:CGRectMake(self.iconView.orignX, self.iconView.tmri_bottom+ 10, 250, 45) selectedColor:[UIColor colorWithHex:@"4AD107"] unSelectedColor:[UIColor lightColor]];
            [self.contentView addSubview:self.progess];
            
            self.displayButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 80, self.iconView.tmri_bottom +10, 70, 25) target:self action:@selector(btnAction:) title:@"领奖" cornerRadius:2];
            [self.displayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.displayButton.backgroundColor = [UIColor colorWithHex:@"4AD107"];
            //        4D107 DD2727
            self.displayButton.centerY  = self.progess.centerY - 10;
            [self.contentView addSubview:self.displayButton];
        //进度条

        
    }
    return self;
}
-(id)congfigWithModle:(NSDictionary *)dict
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:dict[@"goodsImage"] ] placeholderImage:carPlaceHolder];
    self.productionLabel.text = [NSString stringWithFormat:@"第%@期 %@",dict[@"period"],dict[@"name"]];
    NSString *fortunNum =  [NSString stringWithFormat:@"%@",dict[@"luckyNumber"]];
    self.fortuneNum.text = fortunNum;
    BOOL isReward = [dict[@"flag"] boolValue];  //是否领奖
    BOOL isShare =  [dict[@"shareStatus"] boolValue];//是否晒单
    NSUInteger isDelivery = [dict[@"isDelivery"] integerValue];//是否发货
    int index = 0;
    NSString *title;
    if (isReward) {
        index =1;
        title = @"待发货";
        switch (isDelivery) {
            //没发货
            case 0:
                
                break;
            //已经发货
            case 1:
                title = @"待收货";
                index = 2;
                break;
            //已经完成
            case 2:
                title = @"晒单";
                index = 3;
                break;
            default:
                break;
        }
    }
    else
    {
        title = @"领奖";
        index =  0;

    }
    
    [self.displayButton setTitle:title forState:UIControlStateNormal];
    if ([title isEqualToString:@"领奖"]) {
        self.displayButton.backgroundColor = [UIColor colorWithHex:@"4AD107"];
        self.displayButton.enabled = YES;
    }
    else if ([title isEqualToString:@"晒单"])
    {
        if (!isShare) {
            self.displayButton.backgroundColor = [UIColor redColor];
            self.displayButton.enabled = YES;
        }
        else
        {
            self.displayButton.backgroundColor = [UIColor lightColor];
            self.displayButton.enabled = NO;
        }

    }
    else
    {
        self.displayButton.enabled =  NO;
        self.displayButton.backgroundColor = [UIColor lightColor];
    }
    WEAKSELF;
//    dispatch_async(dispatch_get_main_queue(), ^{
        [self.progess setProgress:index];
 
//    });
    NSString *date = [NSString stringWithFormat:@"%@%@",@"开奖日期:",dict[@"createTime"]];
    self.timeLable.text = date;
    
    return self;
}
//领奖
-(void)recivedButtonclick
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(reciviceButtonAction:)]) {
        [self.delegate reciviceButtonAction:self];
    }
    NSLog(@"recivedButtonclick");
}
//晒单
-(void)displayButtonclick
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(displayButtonAction:)]) {
        [self.delegate displayButtonAction:self];
    }
    NSLog(@"displayButtonclick");
}
-(void)btnAction:(id) sender
{
    UIButton *btn  = (UIButton *) sender;
    if ([btn.titleLabel.text isEqualToString:@"领奖"]) {
        [self recivedButtonclick];
    }
    else if([btn.titleLabel.text isEqualToString:@"晒单"])
    {
        [self displayButtonclick];
    }
}
@end
