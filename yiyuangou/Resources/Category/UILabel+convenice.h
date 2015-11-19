//
//  UILabel+convenice.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/11.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (convenice)
//富文本
-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic;
//判断是不是全是数字
- (BOOL)isAllNum;
@end
