//
//  MyCarViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCarViewCell.h"
#import "PKYStepper.h"
#import "YMCarResult.h"
typedef void(^TextFiledBlock)();

@class MyCarViewCell;

@protocol MyCarViewCellDelegate <NSObject>

@optional
-(void)selectedCell:(MyCarViewCell*)cell;

-(void)deselectedCell:(MyCarViewCell*)cell;

-(void)chooseAllCell:(MyCarViewCell*)cell;

@end

@interface MyCarViewCell : UITableViewCell
@property (strong, nonatomic) UIImageView* roundView;
@property (strong,nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel* productionLable;
@property (strong, nonatomic) UILabel* detailLable;
@property (strong, nonatomic) UILabel* leftLable;

@property (strong, nonatomic) PKYStepper*numbersView;
@property (strong, nonatomic) UIImageView* pictureView;
@property (strong,nonatomic) UIButton *lastButton;
@property(strong,nonatomic)NSArray *selectArray;
@property (strong, nonatomic) UILabel* messageLable;
@property (weak,nonatomic)id<MyCarViewCellDelegate>delegate;
@property (nonatomic,copy)TextFiledBlock edtingBlock;
@property (nonatomic,copy)TextFiledBlock endEdtingBlock;
@property (strong ,nonatomic)YMCarInfo *model;
-(id)configWithMode:(YMCarInfo *)result;
@end
