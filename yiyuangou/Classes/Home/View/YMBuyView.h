//
//  YMBuyView.h
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YMBuyView;

@protocol YMBuyViewDelegate <NSObject>

-(void)buyViewDidSelectAtIndex:(NSInteger) index;

@end
@interface YMBuyView : UIView
@property(nonatomic, weak) id<YMBuyViewDelegate> delegate;

@property(nonatomic,strong)UIView*contentView;
@property(nonatomic,strong)UIView*shareView;

@end
