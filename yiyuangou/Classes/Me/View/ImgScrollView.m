//
//  ImgScrollView.m
//  TestLayerImage
//
//  Created by lcc on 14-8-1.
//  Copyright (c) 2014年 lcc. All rights reserved.
//

#import "ImgScrollView.h"
//#import "FileHelper.h"
#import "TapImageView.h"

@interface ImgScrollView()<UIScrollViewDelegate>
{
    UIImageView *imgView;
    
    //记录自己的位置
    CGRect scaleOriginRect;
    
    //图片的大小
    CGSize imgSize;
    
    //缩放前大小
    CGRect initRect;
}

@end

@implementation ImgScrollView

- (void)dealloc
{
    _i_delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator   = NO;
        self.bouncesZoom        = YES;
        self.backgroundColor    = [UIColor clearColor];
        self.delegate           = self;
        self.minimumZoomScale   = 1.0;
        
        imgView = [[UIImageView alloc] init];
        imgView.clipsToBounds   = YES;
        imgView.contentMode     = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGes:)];
        [self addGestureRecognizer:tapGesture];

    }
    return self;
}

- (void)setContentWithFrame:(CGRect)rect
{
    imgView.frame   = rect;
    initRect        = rect;
}

- (void) setAnimationRect
{
    imgView.frame = scaleOriginRect;
}

- (void) rechangeInitRdct
{
    self.zoomScale = 1.0;
    imgView.frame = initRect;
}

//Nemo add
- (void) setImageOrUrl:(id)_object
{
    if (_object)
    {
        if([_object isKindOfClass:[NSString class]])
        {
            NSString *strUrl = _object;
            [imgView sd_setImageWithURL:[NSURL URLWithString:strUrl] placeholderImage:[UIImage imageNamed:@"ico_blank_loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            }];
        }
        else
        {
            if ([_object isKindOfClass:[TapImageView class]]) {
                TapImageView *tapImageView  = _object;
                imgView.image   = tapImageView.image;
            }
            else if ([_object isKindOfClass:[UIImageView class]])
            {
                UIImageView *tapImageView  = _object;
                imgView.image   = tapImageView.image;
            }
//            UIImage *image  = _object;
//            imgView.image   = image;
//            imgView.image =  [UIImage imageNamed:@"head.jpg"];
        }
        
//        imgSize = imgView.image ? imgView.image.size : CGSizeMake(mainWidth, mainWidth * [FileHelper getPageProportion]);
        imgSize = imgView.image.size;
        //判断首先缩放的值
        float scaleX = self.frame.size.width/imgSize.width;
        float scaleY = self.frame.size.height/imgSize.height;
        
        //倍数小的，先到边缘
        if (scaleX > scaleY)
        {
            //Y方向先到边缘
            float imgViewWidth      = imgSize.width*scaleY;
            self.maximumZoomScale   = self.frame.size.width/imgViewWidth;
            
            scaleOriginRect = (CGRect){self.frame.size.width/2-imgViewWidth/2,0,imgViewWidth,self.frame.size.height};
        }
        else
        {
            //X先到边缘
            float imgViewHeight = imgSize.height*scaleX;
            self.maximumZoomScale = self.frame.size.height/imgViewHeight;
            
            scaleOriginRect = (CGRect){0,self.frame.size.height/2-imgViewHeight/2,self.frame.size.width,imgViewHeight};
        }
    }
}

//
- (void)setImage:(UIImage *) image
{
    if (image)
    {
        imgView.image = image;
        imgSize = image.size;
        
        //判断首先缩放的值
        float scaleX = self.frame.size.width/imgSize.width;
        float scaleY = self.frame.size.height/imgSize.height;
        
        //倍数小的，先到边缘
        
        if (scaleX > scaleY)
        {
            //Y方向先到边缘
            float imgViewWidth = imgSize.width*scaleY;
            self.maximumZoomScale = self.frame.size.width/imgViewWidth;
            
            scaleOriginRect = (CGRect){self.frame.size.width/2-imgViewWidth/2,0,imgViewWidth,self.frame.size.height};
        }
        else
        {
            //X先到边缘
            float imgViewHeight = imgSize.height*scaleX;
            self.maximumZoomScale = self.frame.size.height/imgViewHeight;
            
            scaleOriginRect = (CGRect){0,self.frame.size.height/2-imgViewHeight/2,self.frame.size.width,imgViewHeight};
        }
    }
}

#pragma mark -
#pragma mark - scroll delegate
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return imgView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = imgView.frame;
    CGSize contentSize = scrollView.contentSize;
    
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);
    
    // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
    {
        centerPoint.x = boundsSize.width/2;
    }
    
    // center vertically
    if (imgFrame.size.height <= boundsSize.height)
    {
        centerPoint.y = boundsSize.height/2;
    }
    
    imgView.center = centerPoint;
}



#pragma mark - gesture
- (void)actionTapGes:(UITapGestureRecognizer *)_gesture
{
    if(_gesture.state == UIGestureRecognizerStateEnded)
    {
        if ([self.i_delegate respondsToSelector:@selector(tapImageViewTappedWithObject:)])
        {
            [self.i_delegate tapImageViewTappedWithObject:self];
        }
    }
}

@end
