//
//  UIView+Extension.h
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/**
 *  UIView的尺寸
 */
@property(nonatomic,assign)CGSize size;

/**
 *  获取或者更改控件的宽度
 */
@property(nonatomic,assign)CGFloat w;

/**
 *  获取或者更改控件的高度
 */
@property(nonatomic,assign)CGFloat h;

/**
 *  获取或者更改控件的x坐标
 */
@property(nonatomic,assign)CGFloat x;

/**
 *  获取或者更改控件的y坐标
 */
@property(nonatomic,assign)CGFloat y;

-(CGFloat)frameX;
-(CGFloat)frameY;
//添加点击事件
-(void) addTap;
//关闭键盘
-(void) closeKeyBoard;
//显示无数据
-(void) showEmptyView;
-(void) showEmptyView:(float) height;

//隐藏无数据
-(void) hideEmptyView;
@end
