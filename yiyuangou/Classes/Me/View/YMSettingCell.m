//
//  YMSettingCell.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSettingCell.h"

@implementation YMSettingCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
        self.iconView.image =[UIImage imageNamed:@"head"];
        self.iconView.layer.cornerRadius = self.iconView.width/2.0;
        self.iconView.clipsToBounds = YES;
        self.iconView.userInteractionEnabled = YES;
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(modifyAccount:)];
        [self.iconView addGestureRecognizer:tap];
        [self.contentView addSubview:self.iconView];
        
        self.accountLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, 15, 200, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor heightBlacKColor]];
        self.accountLable.text = @"用户ID：123*****3244";
        self.accountLable.font = [UIFont systemFontOfSize:16.0];
        self.userNameLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.accountLable.tmri_bottom + 25, kWIDTH - self.iconView.tmri_right - 10, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor lightColor]];
        self.userNameLable.text = @"昵称：";
        self.userNameLable.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.userNameLable];
        
        //UID
        self.uidlbl = [UILabel labelWithFrame:CGRectMake(self.userNameLable.orignX, self.userNameLable.tmri_bottom- 5 , self.userNameLable.width, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor lightColor]];
        
        self.uidlbl.text = @":";
        
        //        self.uidlbl.backgroundColor = [UIColor redColor];
        
        //        [self.contentView addSubview:self.uidlbl];
        
        self.leftLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.userNameLable.tmri_bottom +10, 150, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor lightColor]];
        self.leftLable.text = @"抢币余额：";
        self.leftLable.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.leftLable];
        self.userNameLable.frame =  CGRectMake(_userNameLable.orignX, _userNameLable.orignY - 10, _userNameLable.width, _userNameLable.height);
        
    }
    return self;
}
-(id)congifgWithMode:(YMSettingResult *)model
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerImagesURL,model.picture_ulr];
//<<<<<<< HEAD
//    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"head"]];
//    
//=======
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:headIconHolder];
    YMInfoCenter *infoCenter =[YMInfoCenter sharedManager];
    YMUser *mainUser = infoCenter.mainUser;
    if (mainUser.YMAccount) {
        self.accountLable.text = [NSString stringWithFormat:@"用户ID：%ld",[YMInfoCenter userID]];
        [self addSubview:self.accountLable];
    }
    else
    {
        [self.accountLable removeFromSuperview];
        
    }
    //    NSString *uid  = [YMInfoCenter userID];
    self.uidlbl.text  = [NSString stringWithFormat:@"用户ID:%ld",[YMInfoCenter userID]];
    NSDictionary *attLight = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                               NSForegroundColorAttributeName:[UIColor lightColor]
                               };
    NSDictionary *attHeightBlack = @{
                                     NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                     NSForegroundColorAttributeName:[UIColor heightBlacKColor]
                                     };
    
    model.LeftMoney = [model.LeftMoney isValid]?model.LeftMoney:@"0";
    NSDictionary *attRed = @{
                             NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                             NSForegroundColorAttributeName:[UIColor  colorWithHex:@"#DD2727"],
                             };
    if (model != nil) {
        self.accountLable.text = [NSString stringWithFormat:@"用户ID：%ld",[YMInfoCenter userID]];
        
        self.userNameLable.text = [NSString stringWithFormat:@"昵称：%@",model.name];
        NSString *leftMoney = [NSString stringWithFormat:@"抢币余额：%@抢币",model.LeftMoney];
        self.leftLable.attributedText  = [self genAttibuteStr:leftMoney newhandleStr:model.LeftMoney commonAttDic:attLight handleDic:attRed otherDic:attHeightBlack];
    }
    
    
    return self;
}
//修改账户信息
-(void)modifyAccount:(UITapGestureRecognizer *)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(accoutChange)]) {
        [self.delegate accoutChange];
    }
}

-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr   commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic otherDic:(NSDictionary *) others
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSRange range = [str rangeOfString:subStr];
    NSString *str1 = [str substringToIndex:range.location];
    NSString *str2 = subStr;
    NSString *str3 = [str substringFromIndex:range.location + range.length];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str1 attributes: commonDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2] attributes: handleDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str3 attributes: others]];
    return attStr;
}
@end
