//
//  YMAlerInfoView.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/5.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YMAlertViewDelegate <NSObject>
-(void) clickBtnAction:(id) sender;
@end
@interface YMAlerInfoView : UIView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title buttonTitle:(NSString *)buttonTitle;

@property(nonatomic,assign) id<YMAlertViewDelegate>deleagte;
@end