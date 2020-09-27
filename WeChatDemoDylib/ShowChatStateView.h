//
//  ShowChatStateView.h
//  WeChatDemoDylib
//
//  Created by apple on 2020/1/17.
//  Copyright © 2020 LogicEDU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ShowChatStateView : NSObject
+(instancetype)shareInstance;
+(void)showLabelWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
