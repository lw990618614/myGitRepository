//
//  YMLuckNumCollectionCell.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/19.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMLuckNumCollectionCell.h"

@interface YMLuckNumCollectionCell ()
@property(nonatomic,strong)UILabel *luckNumlbl;
@end
@implementation YMLuckNumCollectionCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.luckNumlbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 20)];
        self.luckNumlbl.font = [UIFont systemFontOfSize:12.0];
        self.luckNumlbl.textAlignment = NSTextAlignmentCenter;
        self.luckNumlbl.textColor = [UIColor heightBlacKColor];
        [self addSubview:self.luckNumlbl];
    }
    return self;
}
-(void)cellConfig:(NSString *)str
{
    self.luckNumlbl.text = str;
}
@end
