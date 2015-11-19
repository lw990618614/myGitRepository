//
//  YMListCell.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMListCell;
@protocol YMListCellProtol <NSObject>
-(void) luckNum:(YMListCell *)cell;
@end
@interface YMListCell : UITableViewCell
@property (strong, nonatomic) UIImageView * iconView;
@property (strong, nonatomic) UILabel* productionLabel;
@property (strong, nonatomic) UILabel* totalLable;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UILabel* phoneLable;
@property(nonatomic,strong)   UILabel*  reawardLbl;//获奖者
@property(nonatomic,strong)   UILabel*  rewardPhone ;//获奖电话
@property(nonatomic,strong)   UIButton* luckNumBtn;;//查看幸运码
-(id)congfigWithModle:(NSDictionary *)dict;
@property(nonatomic,assign)id<YMListCellProtol>delegate;
@end
