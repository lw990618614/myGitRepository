//
//  YMHomeCollectionViewCell.h
//  yiyuangou
//
//  Created by roen on 15/10/8.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMHomeCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView* iconView;
@property (strong, nonatomic) UILabel * detailLable;
@property (strong, nonatomic) UILabel * progressLable;
@property (strong, nonatomic) UIProgressView *progressView;
@property (strong,nonatomic) UIImageView * carView;
@property (strong,nonatomic) UIImageView * buyView;
@property (strong, nonatomic) UIView* middleView;

-(id)configWithMode;
@end
