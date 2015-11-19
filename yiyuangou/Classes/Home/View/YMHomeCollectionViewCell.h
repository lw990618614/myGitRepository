//
//  YMHomeCollectionViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/8.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMHomeResult.h"
#import "YMProgressView.h"

@class YMHomeCollectionViewCell;
@protocol homeCollectionViewCellDelegate<NSObject>
@optional
-(void)buyViewclick:(YMHomeCollectionViewCell *)cell;
-(void)carViewclick:(YMHomeCollectionViewCell *)cell;

@end
@interface YMHomeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel * detailLable;
@property (strong, nonatomic) UILabel * progressLable;
@property (strong, nonatomic) YMProgressView *pro;
@property (strong,nonatomic) UIImageView * carView;
@property (strong,nonatomic) UIButton * buyView;
@property (assign, nonatomic)NSInteger row;
@property (strong, nonatomic) UIView* middleView;
@property (weak,nonatomic)id<homeCollectionViewCellDelegate> delegate;
@property (strong ,nonatomic)HomeHotList *model;
-(id)configWithMode:(HomeHotList*)list;
@end
