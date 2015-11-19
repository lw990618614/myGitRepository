//
//  YMCoinCell.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/2.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMCoinCell;
@protocol YMCoinCellDeleagte <NSObject>
-(void) doTaskAction:(id)cell;
@end
@interface YMCoinCell : UITableViewCell
-(void) configWithDictionary:(NSDictionary *) dict;
@property(nonatomic,assign)id<YMCoinCellDeleagte>delegate;
@end
