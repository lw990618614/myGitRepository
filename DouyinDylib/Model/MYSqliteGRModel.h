//
//  MYSqliteGRModel.h
//  MWDemoDylib
//
//  Created by apple on 2020/8/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYSqliteGRModel : NSObject
@property (nonatomic, copy) NSString * rowID;
@property (nonatomic, copy) NSString * addTime;
@property(nonatomic) NSString * user_ID; // @synthesize friendID;

//@property (nonatomic, assign) NSString * user_ID;//用户的id
@property (nonatomic, copy) NSString * nickName;//用户名字
@property (nonatomic, copy) NSString * imageUrl;//用户名字
@property (nonatomic, copy) NSString * playerID;//用户在插件系统的名字
@property (nonatomic, copy) NSString * playerName;//系统插件用户名字
@property (nonatomic, copy) NSString * playGameID;//系统游戏名称ID
@property (nonatomic, copy) NSString * everyGameID;//系统游戏每次ID

@property (nonatomic, copy) NSString * shijian;//玩的时间
@property (nonatomic, copy) NSString * jushu;//局数
@property (nonatomic, copy) NSString * leixin;//下注类型
@property (nonatomic, copy) NSString * xiazhuguanli;//下注管理
@property (nonatomic, copy) NSString * beishu;//倍数
@property (nonatomic, copy) NSString * jifenbiandong;//变动分数

@property (nonatomic, copy) NSString * totalScore;//总分 （这个用户一共有多少分）
@property (nonatomic, copy) NSString * userIntegral;//用户积分 （是这个用户有多少分）
@property (nonatomic, copy) NSString * upIntegral;//上庄积分（上庄积分指的是这个用户当庄的时候 他庄上有多少分）
@property (nonatomic, copy) NSString * upTotalIntegral;//总上庄积分
@property (nonatomic, copy) NSString * downTotalIntegral;//总下积分
@property (nonatomic, copy) NSString * totalGetScore;//总抽水
@property (nonatomic, copy) NSString * xianyinGetScore;//闲赢抽水
@property (nonatomic, copy) NSString * xianchouRed;//闲抽红包费用
@property (nonatomic, copy) NSString * xianchouglf;//闲抽管理费
@property (nonatomic, copy) NSString * shangzhuangchoushui;//上庄抽水
@property (nonatomic, copy) NSString * zhuangyingchoushui;//庄赢抽水
@property (nonatomic, copy) NSString * zhuangchouglf;//庄抽管理费
@property (nonatomic, copy) NSString * zhuangchouhbf;//庄抽管理费

@property (nonatomic, copy) NSString * totalPlayerScore;//总输赢多少
@property (nonatomic, copy) NSString * niuniuPlayerScore;//牛牛输赢多少
@property (nonatomic, copy) NSString * suohaPlayerScore;//梭哈输赢多少
@property (nonatomic, copy) NSString * mianyongPlayerScore;//免佣输赢多少
@property (nonatomic, copy) NSString * fengniuPlayerScore;//疯牛输赢多少
@property (nonatomic, copy) NSString * daxiaoPlayerScore;//大小输赢多少
@property (nonatomic, copy) NSString * baijiaPlayerScore;//百家输赢多少
@property (nonatomic, copy) NSString * paijiuPlayerScore;//牌九输赢多少
@property (nonatomic, copy) NSString * hongbaoPlayerScore;//红包输赢多少


@property (nonatomic, copy) NSString * bufen;//这一局补分多少
@property (nonatomic, copy) NSString * koufenScore;//扣分多少

@property (nonatomic, copy) NSString * totalxiazhuScore;//总下注
@property (nonatomic, copy) NSString * niuniuxiazhuScore;//牛牛下注
@property (nonatomic, copy) NSString * suohaxiazhuScore;//梭哈下注
@property (nonatomic, copy) NSString * mianyongxiazhuScore;//免佣下注
@property (nonatomic, copy) NSString * fengniuxiazhuScore;//疯牛下注
@property (nonatomic, copy) NSString * daxiaoxiazhuScore;//大小下注
@property (nonatomic, copy) NSString * baijiaxiazhuScore;//百家下注
@property (nonatomic, copy) NSString * paijiuxiazhuScore;//牌九下注


@property (nonatomic, copy) NSString * TotalplayerTimes;//总局数
@property (nonatomic, copy) NSString * xiazhuTimes;//下注局数
@property (nonatomic, copy) NSString * zuozhuangTimes;//坐庄局数
@property (nonatomic, copy) NSString * lianyingTimes;//连赢次数
@property (nonatomic, copy) NSString * averageTimes;//平均下注次数

@property (nonatomic, copy) NSString * totalQiangbao;//总抢包  就是所有点数相加
@property (nonatomic, copy) NSString * qiangbaoTimes;//抢包次数
@property (nonatomic, copy) NSString * chaoshiTimes;//超时次数


@property (nonatomic, copy) NSString * guishulashouID;//归属拉手ID
@property (nonatomic, copy) NSString * guishulashouName;//归属拉手名单
@property (nonatomic, copy) NSString * guishuTuanzhangID;//归属团长编号
@property (nonatomic, copy) NSString * guishuTuanzhangName;//归属团长名单
@property (nonatomic, copy) NSString * isPlayer;//是否是玩家
@property (nonatomic, copy) NSString * isTuo;//是否是托号
@property (nonatomic, copy) NSString * isManager;//是否是管理
@property (nonatomic, copy) NSString * isLashuo;//是否是拉手
@property (nonatomic, copy) NSString * lashuoNumber;//是否是拉手
@property (nonatomic, copy) NSString * isTuangzhang;//是否是团长

@property (nonatomic, copy) NSString * highestScoreTimes;//最高下注15局

@end

NS_ASSUME_NONNULL_END
