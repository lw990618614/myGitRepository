//
//  YMProgress.m
//  yiyuangou
//
//  Created by Aaron on 15/11/26.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMProgress.h"
@interface YMProgress()
@property(nonatomic,strong)NSMutableArray *imgViewArray;//图片数组
@property(nonatomic,strong)NSMutableArray *titleArray;//title数组
@property(nonatomic,strong)NSMutableArray *lineArray;//线条数组
@property(nonatomic,strong)NSArray        *titleStrArray;
@property(nonatomic,strong)UIColor        *selectedColor;
@property(nonatomic,strong)UIColor        *unSelectedColor;
@end
@implementation YMProgress
-(instancetype)initWithFrame:(CGRect)frame selectedColor:(UIColor *) selectedColor unSelectedColor:(UIColor *)unSelectedColor
{
   self =  [super initWithFrame:frame];
    if (self) {
        _imgViewArray = [[NSMutableArray alloc] init];
        _titleArray = [[NSMutableArray alloc] init];
        _lineArray = [[NSMutableArray alloc] init];
        _selectedColor = selectedColor;
        _unSelectedColor  = unSelectedColor;
        self.backgroundColor = [UIColor whiteColor];
        [self subViews];
    }
    return self;
}
//
-(void) subViews
{
    _titleStrArray = @[@"领奖",@"信息确认",@"发货",@"完成"];
    
    for (int i = 0; i< _titleStrArray.count; i++) {
        //图片
        float originX =  i*(50+15);
        UIImageView *rewardGet = [[UIImageView alloc] initWithFrame:CGRectMake(originX, 5, 15, 15)];
        rewardGet.layer.cornerRadius = rewardGet.width/2.0;
        rewardGet.clipsToBounds = YES;
        [rewardGet.layer setMasksToBounds:YES];
        rewardGet.image = [UIImage imageNamed:@"unReceive"];
        [self.imgViewArray addObject:rewardGet];
        [self addSubview:rewardGet];
        if (i < _titleStrArray.count -1) {
            //线条
            UILabel *rewardline = [[UILabel alloc] initWithFrame:CGRectMake(rewardGet.tmri_right, 0, 50, 3)];
            rewardline.centerY = rewardGet.centerY;
            rewardline.backgroundColor = _unSelectedColor;
            [self.lineArray addObject:rewardline];
            [self addSubview:rewardline];
        }
        //字体
        UILabel *rewardtitle  = [[UILabel alloc] initWithFrame:CGRectMake(0, rewardGet.tmri_bottom, 50, 15)];
        rewardtitle.textColor = _unSelectedColor;
        rewardtitle.centerX = rewardGet.centerX;
        rewardtitle.text = _titleStrArray[i];
        rewardtitle.font = [UIFont systemFontOfSize:10.0];
        rewardtitle.textAlignment = NSTextAlignmentCenter;
        [self.titleArray addObject:rewardtitle];
        [self addSubview:rewardtitle];
        //先选中领奖 
        [self setProgress:0];
    }
    
}
-(void)setProgress:(int)index
{
    [self setUnselect:index];

    for (int i = 0; i<= index; i++) {
        UIImageView *imgView   = self.imgViewArray[i];
        imgView.image =  [UIImage imageNamed:@"receive"];
        UILabel *titlelbl = self.titleArray[i];
        titlelbl.textColor = _selectedColor;
        if (i>0) {
            UILabel     *line = self.lineArray[i-1];
            line.backgroundColor = _selectedColor;
        }
    }

}
-(void) setUnselect:(int) index
{
    int nextIndex =  index +1;
    if (nextIndex >= self.imgViewArray.count) {
        return;
    }
    for (int  i =nextIndex;i<self.imgViewArray.count;i++) {
        UIImageView *imgView   = self.imgViewArray[i];
        imgView.image =  [UIImage imageNamed:@"unReceive"];
        UILabel *titlelbl = self.titleArray[i];
        titlelbl.textColor = _unSelectedColor;
        UILabel     *line = self.lineArray[i-1];
        line.backgroundColor = _unSelectedColor;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//-(void)drawRect:(CGRect)rect
//{
//    
//}
@end
