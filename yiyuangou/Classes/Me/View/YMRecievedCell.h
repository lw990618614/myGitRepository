//
//  YMRecievedCell.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMRecievedCell;
@protocol YMReciveCellDelegate <NSObject>

-(void) reciviceButtonAction:(YMRecievedCell *) cell;
-(void) displayButtonAction:(YMRecievedCell *) cell;

@end
@interface YMRecievedCell : UITableViewCell
@property (strong, nonatomic) UIImageView * iconView;
@property (strong, nonatomic) UILabel* productionLabel;
@property (strong, nonatomic) UILabel* fortuneNumlbl;
@property (strong, nonatomic) UILabel* fortuneNum;
@property (strong, nonatomic) UILabel* timeLable;
@property (strong, nonatomic) UIButton* recivedButton;
@property (strong, nonatomic) UIButton* displayButton;
@property(nonatomic,assign) id<YMReciveCellDelegate> delegate;
-(id)congfigWithModle:(NSDictionary *)dict;

@end
