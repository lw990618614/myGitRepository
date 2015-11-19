//
//  RewardViewControllerCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "RewardViewControllerCell.h"
@interface RewardViewControllerCell()<TTCounterLabelDelegate>
@end

@implementation RewardViewControllerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        self.iconView.layer.borderWidth = 1;
        self.iconView.contentMode =  UIViewContentModeScaleAspectFill;
        [self.iconView setClipsToBounds:YES];

//        self.iconView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#777777"]];
        self.productionLabel.font = [UIFont systemFontOfSize:14];
        self.productionLabel.text = @"IPhone 6S 玫瑰金 16GB";
        
        self.getterLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom +5, 10, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#777777"]];
        self.getterLable.font  =[UIFont systemFontOfSize:14];
        self.getterLable.text = @"获奖者:";

        self.phoneLable = [UILabel labelWithFrame:CGRectMake(self.getterLable.tmri_right, self.productionLabel.tmri_bottom +5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#DD2727"]];
        self.phoneLable.text = @"23";
        self.phoneLable.font  = [UIFont  systemFontOfSize:14];
        [self.contentView addSubview:self.phoneLable];
        
        /********************/
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.phoneLable.tmri_bottom +5, 80, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.totalLable.text = @"参与人数： 159*****323";

        self.priceLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom+5, 200, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.priceLable.text = @"价格：¥6666";
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.priceLable.tmri_bottom +5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.timeLable.text = @"开奖时间：2015-2-4 19:04:8:43";

       /********************/
        self.timeClock = [[TTCounterLabel alloc] initWithFrame:CGRectMake(self.iconView.tmri_right +5,  self.priceLable.tmri_bottom + 20, 100, 50)];
        self.timeClock.textAlignment = NSTextAlignmentLeft;
        self.timeClock.startValue = 10000;
        self.timeClock.countdownDelegate = self;
        self.timeClock.textColor = [UIColor  colorWithHex:@"#DD2727"];
        self.timeClock.countdownDelegate = self;
        
        
        [self.contentView addSubview:self.timeClock];
        [self.contentView addSubview:self.productionLabel];
        [self.contentView addSubview:self.totalLable];
        [self.contentView addSubview:self.priceLable];
        [self.contentView addSubview:self.getterLable];
        [self.contentView addSubview:self.phoneLable];
        [self.contentView addSubview:self.timeLable];
        [self.contentView addSubview:self.iconView];
        
        [self.contentView addSubview:self.timeClock];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timereload) name:TIME_RECENT object:nil];

    }
    return self;
}
-(id)configWithMode:(id)model
{
    
    if ([model isKindOfClass:[RewardFlowList  class]]) {
        RewardFlowList *flowModel = model;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:flowModel.goodsImage] placeholderImage:placeHolder];
        self.productionLabel.text = flowModel.name;
        
        self.priceLable.text = [NSString stringWithFormat:@"商品价格: %@ [第%@期]",flowModel.price,flowModel.period];
        if (flowModel.showPhone) {
            //商品名称
            self.productionLabel.frame =CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15);
            
            //获奖者
            self.getterLable.frame = CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom +5, 50, 15);
            
            //手机
            self.phoneLable.frame =CGRectMake(self.getterLable.tmri_right, self.productionLabel.tmri_bottom +5, kWIDTH, 15);
            self.phoneLable.text = flowModel.phone.length>5?flowModel.phone:flowModel.sname;
            
            //参与人次
            self.totalLable.text = [NSString stringWithFormat:@"参与人数: %ld人",(long)flowModel.menber];
            self.totalLable.frame= CGRectMake(self.iconView.tmri_right + 10, self.phoneLable.tmri_bottom +5, 150, 15);
            
            //商品价格
            self.priceLable.frame  =CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom+5, 200, 15);
            //开奖时间
            self.timeLable.text = [NSString stringWithFormat:@"开奖时间: %@",flowModel.createTime];
            self.timeLable.frame = CGRectMake(self.iconView.tmri_right + 10, self.priceLable.tmri_bottom +5, kWIDTH, 15);
            self.priceLable.font = [UIFont systemFontOfSize:14];

            
            self.timeClock.hidden = YES;
            self.totalLable.hidden= NO;
            self.timeLable.hidden  = NO;
            self.phoneLable.hidden = NO;
            self.getterLable.hidden = NO;
            self.priceLable.hidden = NO;
        }else
        {
            self.timeClock.startValue = flowModel.left + 6000;
            self.timeClock.font = [UIFont systemFontOfSize:15];
            self.timeClock.boldFont = [UIFont boldSystemFontOfSize:15];
            self.timeClock.regularFont = [UIFont systemFontOfSize:15];
            [self.timeClock start];
            self.productionLabel.numberOfLines = 0;
            self.productionLabel.textColor = [UIColor heightBlacKColor];
            self.priceLable.centerY = self.iconView.centerY;
            self.timeClock.centerY = self.iconView.centerY + 30;
            self.productionLabel.centerY = self.iconView.centerY - 30;
            self.priceLable.font = [UIFont systemFontOfSize:12];
            
            self.runTime.startTime = flowModel.left +6000;
            [self.runTime start];

            self.timeClock.hidden = NO;
            self.getterLable.hidden = YES;
            self.totalLable.hidden= YES;
            self.timeLable.hidden  = YES;
            self.phoneLable.hidden = YES;
            self.priceLable.hidden = NO;

        }
        
    }else{
        RewardLotteryList *lotteryList = model;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:lotteryList.goodsImage] placeholderImage:placeHolder];
        
        //商品名称
        self.productionLabel.text = lotteryList.name;
        self.productionLabel.frame =CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15);
        
        //获奖者
        self.getterLable.frame = CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom +5, 50, 15);
        
        //手机
        self.phoneLable.frame =CGRectMake(self.getterLable.tmri_right, self.productionLabel.tmri_bottom +5, kWIDTH, 15);
        
        self.phoneLable.text = lotteryList.phone.length>5?lotteryList.phone:lotteryList.sname;
        NSLog(@"%@,",lotteryList.menber);
        //参与人次
        self.totalLable.text = [NSString stringWithFormat:@"参与人数: %@人",lotteryList.menber];
        self.totalLable.frame= CGRectMake(self.iconView.tmri_right + 10, self.phoneLable.tmri_bottom +5, 150, 15);
        
        //商品价格
        self.priceLable.frame  =CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom+5, 200, 15);
        self.priceLable.text = [NSString stringWithFormat:@"商品价格: %@ [第%@期]",lotteryList.price,lotteryList.period];
        //开奖时间
        self.timeLable.text = [NSString stringWithFormat:@"开奖时间: %@",lotteryList.createTime];
        self.timeLable.frame = CGRectMake(self.iconView.tmri_right + 10, self.priceLable.tmri_bottom +5, kWIDTH, 15);
        self.priceLable.font = [UIFont systemFontOfSize:12];
        
        self.timeClock.hidden = YES;
        self.totalLable.hidden= NO;
        self.timeLable.hidden  = NO;
        self.phoneLable.hidden = NO;
        self.getterLable.hidden = NO;
        self.priceLable.hidden = NO;
    }
    self.productionLabel.numberOfLines = 0;
    return self;
    
}
- (void)countdownDidEnd
{
    if ([self.delegate respondsToSelector:@selector(timedownDidEnd:)]) {
        [self.delegate timedownDidEnd:self];
    }
}
-(void)timereload
{
    [self.timeClock stop];
}
@end
