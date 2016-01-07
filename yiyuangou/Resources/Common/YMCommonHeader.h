//
//  YMCommonHeader.h
//  yiyuangou
//
//  Created by roen on 15/10/26.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import <UIKit/UIKit.h>

#define kWIDTH  [UIScreen mainScreen].bounds.size.width
#define  kHEIGHT  [UIScreen mainScreen].bounds.size.height
#define HEIGHT_SERO 0.001
#define  kNav  200
#define photoMagin  10
#define photoWidth  75
#define PhotosMaxCount 9
#define maxColumns(count) (count == 4 ? 2 : 3)

/**
 * 基本参数
 */

#define PACKNAME  @"youmobi"
#define APPKEY    @"123456"
#define CHANNEL   @"1.25"
#define USRID @"userID"
#define Account @"account"


#define SYSTEMVERSION [UIDevice currentDevice].systemVersion //版本号
//#define BaseServerImagesURL @"http://192.168.1.164:8080/images"//图片地址
#define BaseServerImagesURL @""//图片地址


//#define BaseServerURL @"http://192.168.1.57:8081/api/v1"
#define BaseServerURL @"http://123.59.67.181:8081/api/v1"//测试
//#define BaseServerURL @"http://120.132.68.60:9980/api/v1"//正式
//#define BaseServerURL @"http://123.59.72.155:9980/api/v1"//后台

//#define BaseServerURL @"http://120.132.68.60:9980/api/v1"
#define WEAKSELF typeof(self) __weak weakSelf = self

#define ADDALL_MYCAR                    @"ALL_ISCHOOSE"
#define DELETE_MYCAR                    @"ALL_ISNOCHOOSE"
#define CAR_ISCHANGE                    @"CAR_ISCHANGE"
#define TEXT_LENGTH                    @"TEXT_LENGTH"
#define COUNT_CHANGE                    @"COUNT_CHANGE"
#define TIME_RELOAD                    @"TIME_RELOAD"
#define TIME_RECENT                    @"TIME_RECENT"

#define SAFE typeof(self) __weak weakSelf = self
#define TEXT_CHANGE                    @"TEXT_CHANGE"
#define TEXT_CHANGE                    @"TEXT_CHANGE"
#define REFRESH_SELF                    @"REFRESH_SELF"
#define ReceiveList                    @"receiveList"
#define kLoadingText                    @"加载中"
 #define GoodImage                       @"占位图"
#define placeHolder                      [UIImage  imageNamed:GoodImage]
#define bannerPlaceHolder                      [UIImage  imageNamed:@"750X265zwt"]
#define timePlaceHolder                      [UIImage  imageNamed:@"250x165zwt"]
#define hotPlaceHolder                      [UIImage  imageNamed:@"375X175zwt"]
#define goodsPlaceHolder                      [UIImage  imageNamed:@"200x200zwt"]
#define carPlaceHolder                      [UIImage  imageNamed:@"160x160zwt"]
#define headIconHolder                      [UIImage  imageNamed:@"个人中心_03"]

#define  CellSelectImage                 @"selected"

#define QQ_Key    @"1104942024"
#define QQ_sercert @"JpXfoxhwuSOxAyPE"
#define  CellUnSelectImage               @"0"
#define WX_ID     @"wxff15374ee58d3c57"
#define WX_SERCER @"d4624c36b6795d1d99dcf0547af5443d"
static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthOpenID = @"396104459@qq.com";
static NSString *kAuthState = @"xxx";
#define WeiBoKey @"2918660671"
#define WeiBoSecert @"cd5e58004567d42d62d424b16d8ce368"
#define WeiBoUrl @"http://sns.whalecloud.com/sina2/callback"
#define HelpUrl  @"http://www.baidu.com"
#define UMKey    @"563cc57c67e58e6d6a00385a"
#define BaiDuKey  @"I7jBCgptq8KGu0eeuCXM8Vd6"
#define ymNotificationRefreshUserInfo @"ymNotificationRefreshUserInfo"
#define ymNotificationChongzhi        @"ymNotificationChongzhi"  //充值
#define ymNotificationBug             @"ymNotificationBug"       //抢购
#define ymNotificationTaskCompete      @"ymTaskFinish"
//#define  CellUnSelectImage                @"0"
//CG_INLINE CGFloat GTFixHeightFlaot(CGFloat height) {
//    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
//    if (mainFrme.size.height/1096*2 < 1) {
//        return height;
//        
//    }
//    height = height*mainFrme.size.height/1096*2;
//    return height;
//}
//
//CG_INLINE CGFloat GTReHeightFlaot(CGFloat height) {
//    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
//    if (mainFrme.size.height/1096*2 < 1) {
//        return height;
//    }
//    height = height*1096/(mainFrme.size.height*2);
//    return height;
//}
//
//CG_INLINE CGFloat GTFixWidthFlaot(CGFloat width) {
//    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
//    if (mainFrme.size.height/1096*2 < 1) {
//        return width;
//    }
//    width = width*mainFrme.size.width/640*2;
//    return width;
//}
//
//CG_INLINE CGFloat GTReWidthFlaot(CGFloat width) {
//    CGRect mainFrme = [[UIScreen mainScreen] applicationFrame];
//    if (mainFrme.size.height/1096*2 < 1) {
//        return width;
//    }
//    width = width*640/mainFrme.size.width/2;
//    return width;
//}
//
//// 经过测试了, 以iphone5屏幕为适配基础
//CG_INLINE CGRect
//GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    CGRect rect;
//    rect.origin.x = GTFixWidthFlaot(x);
//    rect.origin.y = GTFixHeightFlaot(y);
//    rect.size.width = GTFixWidthFlaot(width);
//    rect.size.height = GTFixHeightFlaot(height);
//    return rect;
//}
CG_INLINE CGFloat GTFixHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
        
    }
    height = height*mainFrme.size.height/1096*2;
    return height;
}

CG_INLINE CGFloat GTReHeightFlaot(CGFloat height) {
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    if (mainFrme.size.height/1096*2 < 1) {
        return height;
    }
    height = height*1096/(mainFrme.size.height*2);
    return height;
}

CG_INLINE CGFloat GTFixWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*mainFrme.size.width/640*2;
    return width;
}

CG_INLINE CGFloat GTReWidthFlaot(CGFloat width) {
    CGRect mainFrme = [[UIScreen mainScreen] bounds];
    if (mainFrme.size.height/1096*2 < 1) {
        return width;
    }
    width = width*640/mainFrme.size.width/2;
    return width;
}

// 经过测试了, 以iphone5屏幕为适配基础
//CG_INLINE CGRect
//GTRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
//{
//    CGRect rect;
//    rect.origin.x = GTFixWidthFlaot(x);
//    rect.origin.y = GTReHeightFlaot(y);
//    rect.size.width = GTFixWidthFlaot(width);
//    rect.size.height = GTFixHeightFlaot(height);
//    return rect;
//}

typedef NS_ENUM(NSUInteger, BaseServerResponseCode) {
    /**
     *  接口操作返回成功
     */
    C100000 = 0,
    
    /**
     *
     */
    C100001,
    
    /**
     *
     */
    C100002,
    
    /**
     *
     */
    C100003,
    
    /**
     *  
     */
    C100004,
    
    /**
     *  缺少参数
     */
    C100005,
    
    /**
     *  访问失败
     */
    C100006,
    
    /**
     *  请求失败/网络异常
     */
    C100007,
};
//友盟统计相关
#define ymLogin @"login"  //用户登录计数事件
#define ymShare @"share"  //用户分享计数事件
#define ymGoodsClick @"goodsClick" //商品点击计算事件
#define ymGoodsClickNum  @1
#define ymGoodsBuy   @"goodBuy"   //商品抢购计算事件
#define ymGoodsBuyNum @2          //商品抢购
