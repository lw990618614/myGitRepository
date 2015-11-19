#import <Foundation/Foundation.h>
#import "WPFetchResponseProtocol.h"
#import "AppConnect.h"

typedef enum {
    kWPUserAccountRequestTagGetPoints = 0,
    kWPUserAccountRequestTagSpendPoints = 1,
    kWPUserAccountRequestTagAwardPoints = 2,
    kWPUserAccountRequestTagMAX
} WPUserAccountRequestTag;

@class WPUserPointsRequestHandler;
@class WPUserPoints;

@interface WPPointsManager : NSObject <WPFetchResponseDelegate> {
    WPUserPoints *userPointsObj_;
    WPUserPointsRequestHandler *userPointsGetPointsObj_;
    WPUserPointsRequestHandler *userPointsSpendPointsObj_;
    WPUserPointsRequestHandler *userPointsAwardPointsObj_;
    BOOL waitingForResponse_;
}

- (void)getPoints;

- (void)spendPoints:(int)points;

- (void)awardPoints:(int)points;

- (void)fetchResponseSuccessWithData:(WPCoreFetcher *)dataObj withRequestTag:(int)aTag;

- (void)fetchResponseError:(WPResponseError)errorType errorDescription:(id)errorDescObj requestTag:(int)aTag;

- (void)updateUserAccountObjWithTBXMLElement:(NSDictionary *)userAccElement;

- (void)releaseUserAccount;

@end


@interface AppConnect (WPUserPointsManager)

+ (void)getPoints;

+ (void)spendPoints:(int)points;

+ (void)awardPoints:(int)points;

+ (void)showEarnedPoints;

+ (void)showDefaultEarnedCurrencyAlert:(NSNotification *)notifyObj;

@end