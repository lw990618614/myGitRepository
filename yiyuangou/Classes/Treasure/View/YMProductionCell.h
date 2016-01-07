//
//  YMProductionCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreasureResult.h"
#import "TapImageView.h"

@class YMProductionCell;
@protocol YMProductionCellDelegate<NSObject>
@optional
-(void)showBigView:(YMProductionCell *)cell;
@end
@interface YMProductionCell : UITableViewCell
@property (weak,nonatomic)id<YMProductionCellDelegate> delegate;

@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UIView *seperateView;
@property (strong, nonatomic) UILabel* nameLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UILabel* messgeLable;
@property (strong, nonatomic) UILabel* stateLable;
@property (strong, nonatomic) TapImageView *backView;
@property (strong, nonatomic) UIImageView * pictureView;
@property (strong, nonatomic) UILabel* describeLable;
@property (assign,nonatomic)BOOL *hideState;
//@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) NSMutableArray *imageArray;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(ShareProduction *)model;
-(id)configWithMode:(ShareProduction *)model;
@end
