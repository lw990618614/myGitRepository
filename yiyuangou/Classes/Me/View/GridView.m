//
//  GridView.m
//  mobi
//
//  Created by 张莉梅 on 15/10/29.
//  Copyright © 2015年 mobi. All rights reserved.
//

#import "GridView.h"
#define kymleft 10 //左边距
#define kymright 10 //右边距
#define kymBtnNum 4 //每一行按钮的数量
#define kymBtnWidthPer 15 //按钮之间的左右间距
#define kymBtnHeightPer 15 //按钮之间的上限间距
#define kymBtnHeight 80 //按钮的高
#define kymBtnTop  10 //上边距
#define kymBtnBottom 10 //下边距
@interface GridView()<UITextFieldDelegate>{
}
@property(nonatomic,assign) int  selectIndex;
@property(nonatomic,strong) NSArray *tileArray;
@property(nonatomic,assign) NSUInteger   lastTap;//上次点击按
@property(nonatomic,assign) float height;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,assign) NSUInteger col;
@property(nonatomic,assign) NSUInteger line;
@end
@implementation GridView


-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self) {
        _tileArray =  array;
        if (_tileArray.count == 0 || _tileArray == nil) {
            return self;
        }
        [self  inititalView];
    }
    return self;
}
-(void) inititalView
{
    float width =( kWIDTH - kymleft - kymright - (kymBtnNum - 1)*kymBtnWidthPer) / kymBtnNum;
    _col = 0;
    _line = 0;
    _imageArray = [[NSMutableArray alloc]init];
    self.curTotal  = _tileArray.count - 1;
    for (int i = 0; i < _tileArray.count; i++) {
        _col = i%kymBtnNum; //列
        _line = i / kymBtnNum; //行
        if (i < _tileArray.count - 1) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kymleft + _col*(width + kymBtnWidthPer),kymBtnTop + _line*(kymBtnHeight + kymBtnHeightPer) , width, kymBtnHeight)];
            imgView.image = _tileArray[i];
            [_imageArray addObject:imgView];
            imgView.userInteractionEnabled = YES;
            //添加点击事件
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
            [imgView addGestureRecognizer:tap];
            
            [self addSubview:imgView];
        }
        else if (i == _tileArray.count -1)
        {
            UIButton *addImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(kymleft + _col*(width + kymBtnWidthPer),kymBtnTop + _line*(kymBtnHeight + kymBtnHeightPer) , width, kymBtnHeight)];
            [addImgBtn setBackgroundImage:_tileArray[i] forState:UIControlStateNormal];
            [addImgBtn addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:addImgBtn];
        }

    }
    _height = kymBtnTop + kymBtnBottom + (_line + 1)*kymBtnHeight + _line*kymBtnHeightPer;
    self.frame = CGRectMake(self.orignX, self.orignY, self.width, _height) ;
    
    

}
-(void)addImage:(id)sender
{
    
    if (self.curTotal >= self.max) {
        [self makeToast:@"您选择的图片已经达到9张"];
        return;
    }
    if (self.delgate && [self.delgate respondsToSelector:@selector(addBtnAction:)]) {
        [self.delgate addBtnAction:sender];
    }
}
-(float)gridViewHeight
{
    return _height;
}
-(void)addArray:(NSArray *) images
{
    float width =( kWIDTH - kymleft - kymright - (kymBtnNum - 1)*kymBtnWidthPer) / kymBtnNum;
    UIButton *btn = (UIButton *)[self subviews][_tileArray.count -1];
    NSUInteger i;
    //如果多于了最多张
    NSUInteger max = images.count + _imageArray.count;
    self.curTotal = images.count  + _imageArray.count;
    if (max > _max) {
        max = _max;
//        btn.enabled = NO;
    }
    NSUInteger curTotal =  _imageArray.count;
    for ( i = _imageArray.count; i < max; i++) {
     _col = i%kymBtnNum; //列
     _line = i / kymBtnNum; //行
     UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kymleft + _col*(width + kymBtnWidthPer),kymBtnTop + _line*(kymBtnHeight + kymBtnHeightPer) , width, kymBtnHeight)];
        NSUInteger index = i - curTotal;
        imgView.image = images[index];
        //添加点击事件
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [_imageArray addObject:imgView];
        [imgView addGestureRecognizer:tap];
        
       [self addSubview:imgView];
    }

    i --;
    _col = (i + 1)%kymBtnNum; //列
    _line = (i + 1) / kymBtnNum; //行
    CGRect rect  = CGRectMake(kymleft + _col*(width + kymBtnWidthPer),kymBtnTop + _line*(kymBtnHeight + kymBtnHeightPer) , width, kymBtnHeight);
    btn.frame =  rect;

    _height = kymBtnTop + kymBtnBottom + (_line + 1)*kymBtnHeight + _line*kymBtnHeightPer;
    self.frame = CGRectMake(self.orignX, self.orignY, self.width, _height) ;
}
-(void) tapAction:(id) sender
{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer *)sender;
    UIImageView   *imgView  = (UIImageView *)tap.view;
    NSUInteger  index  = [_imageArray indexOfObject:imgView];
    if (self.delgate && [self.delgate respondsToSelector:@selector(didSelectGridViewAtIndex:)]) {
        [self.delgate didSelectGridViewAtIndex:index];
    }
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
