//
//  YMHomeCell.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeCell.h"

#define cellWidth frame.size.width
#define cellHeight frame.size.height
@interface YMHomeCell()<TTCounterLabelDelegate>
@end

@implementation YMHomeCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        //图
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, 82.5)];
        self.iconView.image  = [UIImage imageNamed:GoodImage];
        self.iconView.contentMode =  UIViewContentModeScaleAspectFill;
        [self.iconView setClipsToBounds:YES];
        [self.contentView addSubview:self.iconView];
        
        //商品名称
        self.productionLable = [UILabel labelWithFrame:CGRectMake(0, self.iconView.tmri_bottom +10, cellWidth, 15) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        self.productionLable.text = @"iPhone 6 S";
        [self.contentView addSubview:self.productionLable];
        
        //获奖者
        self.prizeButton = [UIButton buttonWithFrame:CGRectMake(0, self.productionLable.tmri_bottom + 10, cellWidth, 15) target:nil action:nil title:@"150***3434" cornerRadius:1];
        [self.prizeButton setTitleColor:[UIColor  colorWithHex:@"#999999"] forState:UIControlStateNormal];
        [self.prizeButton setImage:[UIImage imageNamed:@"一元购homepage_03"] forState:UIControlStateNormal];
        self.prizeButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:self.prizeButton];
        
        //时间跑秒
        self.Counter = [[TTCounterLabel alloc] initWithFrame:CGRectMake(0, self.productionLable.tmri_bottom + 10, 70, 15)];
        self.Counter.textAlignment = NSTextAlignmentLeft;
        self.Counter.startValue = 10000;
        self.Counter.countdownDelegate = self;
        self.Counter.centerX = self.prizeButton.centerX;
        self.Counter.textColor = [UIColor  colorWithHex:@"#DD2727"];
        [self.contentView addSubview:self.Counter];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timereload) name:TIME_RELOAD object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(timeChange:) name:COUNT_CHANGE object:nil];

    }
    return self;
}
-(id)configWithMode:(id)model
{
    if ([model isKindOfClass:[HomeFlowList class]]) {
        HomeFlowList *list = model;
        
        self.model = list;
        
        UIImage *placeholder = [UIImage imageNamed:GoodImage];
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.goodsImage] placeholderImage:placeholder];
        
        self.productionLable.text = list.name;
        
        self.Counter.startValue = list.left+6000;
        NSString *title =list.phone.length?list.phone:list.sname;
        [self.prizeButton setTitle:title forState:UIControlStateNormal];
        
        self.prizeButton.hidden = !list.showPhone;
        
        self.Counter.hidden = list.showPhone;
        if (list.showPhone) {
            [self.Counter stop];
        }else{
            [self.Counter start];
        }
    }else{
    
        YMHomelotteryList *list = model;
        
//        self.model = list;
        
        UIImage *placeholder = [UIImage imageNamed:GoodImage];
        
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.goodsImage] placeholderImage:placeholder];
        
        self.productionLable.text = list.name;
        
//        self.Counter.startValue = list.left+6000;
        NSString *title =list.phone.length?list.phone:list.sname;
        [self.prizeButton setTitle:title forState:UIControlStateNormal];
        
        self.prizeButton.hidden = NO;
        self.Counter.hidden = YES;
//        self.Counter.hidden = list.showPhone;
//        if (list.showPhone) {
//            [self.Counter stop];
//        }else{
//            [self.Counter start];
//        }

    }
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
    [self.Counter stop];
}
-(void)timeChange:(NSNotification *)notification
{
   NSString *str =  [[notification object] lastObject];
    NSLog(@"str %@",str);
}
@end
