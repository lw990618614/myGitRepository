//
//  YMWebViewController.h
//  mobi
//
//  Created by Aaron on 15/9/25.
//  Copyright © 2015年 mobi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMWebViewController : YMBaseViewController
@property(nonatomic,strong) NSString *urlStr;

-(id)initWithAddress:(NSString*)title address:(NSString*)url;
@end
