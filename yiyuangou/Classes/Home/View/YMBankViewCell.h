//
//  YMBankViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/3.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,YMBankViewCellType)
{
    YMBankViewCellPhoneNumber = 0,
    YMBankViewCellTimeNumber
};
@protocol YMBankViewCellDelegate<NSObject>
-(void)YMBankViewCelClicked;
@end

@interface YMBankViewCell : UIView

@property(nonatomic,weak) id<YMBankViewCellDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view andTitle:(NSString *)tilte andType:(YMBankViewCellType)type;
@end
