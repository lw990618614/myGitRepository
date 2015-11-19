//
//  YMHomeCell.h
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TTCounterLabel.h"
#import "YMHomeResult.h"
@class YMHomeCell;
@protocol HomeCellDelegate<NSObject>
@optional
- (void)timedownDidEnd:(YMHomeCell *)cell;
@end
@interface YMHomeCell : UICollectionViewCell
@property (weak, nonatomic) id<HomeCellDelegate> delegate;
@property (nonatomic,assign)NSInteger row;
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UIButton *prizeButton;
@property (strong,nonatomic) TTCounterLabel *Counter;
@property (strong, nonatomic) HomeFlowList* model;

-(id)configWithMode:(id )model;

@end
