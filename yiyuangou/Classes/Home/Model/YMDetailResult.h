//
//  YMDetailResult.h
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMDetailResult : BaseResult
@property (nonatomic,assign)NSInteger gid;
/**
 *每期商品id
 */
@property (nonatomic,assign)NSInteger gsid;
//第··期
@property (nonatomic,assign)NSInteger period;

//第..期抢购中
@property (nonatomic,assign)NSInteger newGsid;


//开奖进度
@property (nonatomic,copy) NSString * progress;


//总需求
@property (nonatomic,copy) NSString * expected;
//开奖标识
@property (assign, nonatomic)  NSInteger flag;

//是否已经公布幸运用户
@property (assign, nonatomic)  NSInteger status;


@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * actually ;

@property (nonatomic,copy) NSString * LeftAmount ;

@property (nonatomic,copy) NSString * price ;

@property (nonatomic,copy) NSString * face;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * time;

@property (nonatomic,copy) NSString * luckyNumber;

@property (nonatomic,strong) NSMutableArray * totalList;

@property (nonatomic,strong) NSArray * bannerList;

@property (nonatomic,assign)NSInteger  newPeriod;

@property (nonatomic,copy)NSString *sname;

@property (nonatomic,copy)NSString *lastPhone;
@property (nonatomic,copy)NSString *lastSname;



@end

@interface YMTotalList : NSObject
@property (nonatomic,copy)NSString *str;
@property (nonatomic,copy) NSString * face;
@property (nonatomic,copy) NSString * progress;
@property (nonatomic,copy) NSString * mobile;
@property (nonatomic,copy) NSString * place;
@property (nonatomic,copy) NSString * times;
@property (nonatomic,copy) NSString * createTime;
@property (nonatomic,copy) NSString *sname;
@end

@interface BannerPicture : NSObject
@property (assign, nonatomic) NSInteger  gid;
@property (nonatomic,copy) NSString * url;


@end