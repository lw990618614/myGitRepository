//
//  YMBuyView.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBuyView.h"
#import "UIVerticalButton.h"
@implementation YMBuyView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray*nameArray=@[@"加入购物车",@"立即抢购"];
        NSArray*imageArray;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        self.shareView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 50)];
        self.shareView.backgroundColor=[UIColor whiteColor];
        [self addSubview:self.shareView];
        
        for (int i=0; i<nameArray.count; i++) {
            
            UIVerticalButton*button=[UIVerticalButton buttonWithFrame:CGRectMake(i%2*(kWIDTH/2.0), i/2*self.shareView.tmri_height/1.0f , self.shareView.tmri_width/2.0, self.shareView.tmri_height/1.0f) target:self action:@selector(keyButtonClicked:) title:nameArray[i] cornerRadius:0];
            button.titleLabel.font=[UIFont systemFontOfSize:16];
            button.tag=i+10000;
            [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [self.shareView addSubview:button];
            if (i == 0) {
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor orangeColor];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                button.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
            }
        }

    }
    return self;
}
-(void)keyButtonClicked:(UIButton*)button
{
    if ([self.delegate respondsToSelector:@selector(buyViewDidSelectAtIndex:)]) {
            [self.delegate buyViewDidSelectAtIndex:button.tag];
    }
}
@end
