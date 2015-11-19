//
//  YMHelpViewController.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMWebViewController.h"
/**
 *  一元购帮助文档
 */
@interface YMHelpViewController : YMWebViewController
@property(nonatomic,assign) BOOL isFinishTask;//是否完成任务
@property(nonatomic,strong) NSNumber *taskID;//任务ID
@end
