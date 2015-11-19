#import <Foundation/Foundation.h>

@interface WPUserPoints : NSObject {
@private
    int points_;
    NSString *pointsID_;
    NSString *currencyName_;
}

@property(getter=getPointsValue, nonatomic) int points;
@property(nonatomic, retain) NSString *pointsID;
@property(getter=getPointsName, nonatomic, retain) NSString *currencyName;

- (id)initWithTBXML:(NSDictionary *)aXMLElement;

- (void)updateWithTBXML:(NSDictionary *)aXMLElement shouldCheckEarnedPoints:(BOOL)checkEarnedPoints;

@end
