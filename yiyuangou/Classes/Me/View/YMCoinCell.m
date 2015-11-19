//
//  YMCoinCell.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/2.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCoinCell.h"
@interface YMCoinCell()
@property(nonatomic,strong) UIImageView *lineImage;
@property(nonatomic,strong) UILabel     *taskDes;
@property(nonatomic,strong) UIImageView *rewardImg;
@property(nonatomic,strong) UIButton    *taskBtn;
@property(nonatomic,strong) UIButton    *taskFinishBtn;
@property(nonatomic,strong) UILabel *lbl;
@property(nonatomic,strong) UILabel *rewardCoin;//奖励的金币数量
@end
@implementation YMCoinCell
- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lineImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 10, 55)];
//        rewardFinsh unFinished
        CGRect rect = _lineImage.frame;
        _lbl = [[UILabel alloc] initWithFrame:rect];
        _lineImage.image = [UIImage imageNamed:@"unFinished"];
        _taskDes = [[UILabel alloc] initWithFrame:CGRectMake(_lineImage.tmri_right + 5, 15, 100, 25)];
        
        _rewardImg = [[UIImageView alloc] initWithFrame:CGRectMake(_taskDes.tmri_right + 2, _taskDes.orignY - 3, 70, 20)];
        _rewardImg.image = [UIImage imageNamed:@"reward"];
        _rewardCoin = [[UILabel alloc]initWithFrame:CGRectMake(4,1 , _rewardImg.width - 8, _rewardImg.height -  2)];
        _rewardCoin.textColor = [UIColor  colorWithHex:@"#DD2727"];
        _rewardCoin.font = [UIFont systemFontOfSize:10.0];
        [_rewardImg addSubview:_rewardCoin];
        _taskDes.font = [UIFont systemFontOfSize:15.0];
        _taskBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWIDTH - 120, _taskDes.orignY, 110,25 )];
        _taskBtn.layer.borderColor = [UIColor  colorWithHex:@"#DD2727"].CGColor;
        _taskBtn.layer.borderWidth = 1.0;
        _taskBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        _taskFinishBtn = [[UIButton alloc]init];
        _taskFinishBtn.frame = CGRectMake(kWIDTH - 100, _taskDes.orignY, 90, 20);
        [_taskFinishBtn setImage:[UIImage imageNamed:@"finish"] forState:UIControlStateNormal];
        [_taskFinishBtn setTitleColor:[UIColor heightBlacKColor] forState:UIControlStateNormal];
        _taskFinishBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_taskFinishBtn setTitle:@"已完成" forState:UIControlStateNormal];
        _taskFinishBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_taskFinishBtn addTarget:self action:@selector(doTask:) forControlEvents:UIControlEventTouchUpInside];

        [_taskBtn addTarget:self action:@selector(doTask:) forControlEvents:UIControlEventTouchUpInside];
        [_taskBtn setTitle:@"做任务" forState:UIControlStateNormal];
        [_taskBtn setTitleColor:[UIColor  colorWithHex:@"#DD2727"] forState:UIControlStateNormal];
        [self.contentView addSubview:_taskDes];
//        [self.contentView addSubview:_rewardImg];
//        [self.contentView addSubview:_taskBtn];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void) doTask:(id) sender
{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(doTaskAction:)]) {
        [self.delegate doTaskAction:self];
    }
}
-(void)configWithDictionary:(NSDictionary *)dict
{
    _taskDes.text = dict[@"taskTitle"];
    _rewardCoin.text = [NSString stringWithFormat:@"奖励%@个金币",dict[@"coin"]];
    if ((dict[@"createTime"] == nil || [dict[@"createTime"] isEqualToString:@""])) {
        //任务并没有完成
        [self addSubview:_taskBtn];
        [_taskFinishBtn removeFromSuperview];
    }
    else
    {
      [self addSubview:_taskFinishBtn];
     [_taskBtn removeFromSuperview];
    }
}

@end
