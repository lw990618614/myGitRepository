//
//  YMOrderView.h
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKYStepper.h"
@class YMOrderView;
@protocol YMOrderViewDelegate <NSObject>

-(void)orderButtonClick;

@end
@interface YMOrderView : UIView
@property (nonatomic,strong)PKYStepper *steper;
@property (weak, nonatomic) id<YMOrderViewDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withModel:(NSData *)data;

@end
