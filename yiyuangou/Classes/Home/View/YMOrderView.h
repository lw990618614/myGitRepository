//
//  YMOrderView.h
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKYStepper.h"
#import "YMOrderResult.h"

@class YMOrderView;
@protocol YMOrderViewDelegate <NSObject>
@optional
-(void)orderButtonClickWith:(YMOrderResult *)data;
-(void)cancelButtonClick;
@end
@interface YMOrderView : UIView
@property (nonatomic,strong)PKYStepper *steper;
@property (weak, nonatomic) id<YMOrderViewDelegate> delegate;
@property (nonatomic,strong) UILabel *leftLable;
@property (nonatomic,strong) UILabel *allLable;

@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UILabel *productionLable;
@property (strong, nonatomic)UIImageView * deleteView;
@property (nonatomic,strong)UILabel *buyLable;
@property (nonatomic,strong)YMOrderResult *orderResult;
@property (nonatomic ,strong)UIButton *buyButton;
@property (nonatomic,assign)NSInteger number;
-(instancetype)initWithFrame:(CGRect)frame withModel:(NSInteger)data;

@end
