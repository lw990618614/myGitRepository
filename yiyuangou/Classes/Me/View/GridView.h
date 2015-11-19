//
//  GridView.h
//  mobi
//
//  Created by 张莉梅 on 15/10/29.
//  Copyright © 2015年 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GridViewDelegate <NSObject>
-(void) didSelectGridViewAtIndex:(NSUInteger) index;
-(void) addBtnAction:(id) sender;//新增数组
@end

@interface GridView : UIView
@property(nonatomic,assign) id<GridViewDelegate>delgate;
-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)array;
-(float) gridViewHeight;
-(void)addArray:(NSArray *) images;
@property(nonatomic,assign) int max;//图片最多数量
@property(nonatomic,assign) NSUInteger curTotal;//当前的图片数量
@property(nonatomic,strong) NSMutableArray *imageArray;

//将按钮
@end
