//
//  UIView+tmri.h
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString * const CSToastPositionTop;
extern NSString * const CSToastPositionCenter;
extern NSString * const CSToastPositionBottom;

@interface UIView (tmri)

@property (nonatomic, assign) CGSize size;          //尺寸

@property (nonatomic, assign) CGFloat MinX;         //左
@property (nonatomic, assign) CGFloat tmri_right;        //右
@property (nonatomic, assign) CGFloat tmri_top;          //上
@property (nonatomic, assign) CGFloat tmri_bottom;       //下

@property (nonatomic, assign) CGFloat centerX;      //中心点x坐标
@property (nonatomic, assign) CGFloat centerY;      //中心点y坐标

@property (nonatomic, assign) CGFloat tmri_width;        //宽
@property (nonatomic, assign) CGFloat tmri_height;       //高
@property(nonatomic,assign) float orignX ;
@property(nonatomic,assign) float orignY;
@property(nonatomic,assign) float width;
@property(nonatomic,assign) float height;

- (void)makeToast:(NSString *)message;
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position;
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position image:(UIImage *)image;
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title;
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)interval position:(id)position title:(NSString *)title image:(UIImage *)image;
//// displays toast with an activity spinner
- (void)makeToastActivity:(NSString *)message;
- (void)makeToastActivity:(NSString *)message position:(id)position;
- (void)hideToastActivity;
//// the showToast methods display any view as toast
- (void)showToast:(UIView *)toast;
//- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point;
//- (void)showToast:(UIView *)toast duration:(NSTimeInterval)interval position:(id)point
//      tapCallback:(void(^)(void))tapCallback;
//
//-(void)startRotateAnimation;
//-(void)stopRotateAnimation;


@end
