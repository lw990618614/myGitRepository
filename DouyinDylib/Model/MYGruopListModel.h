//
//  MYGruopListModel.h
//  MWDemoDylib
//
//  Created by apple on 2020/8/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MYGruopListModel : NSObject
@property(copy, nonatomic) NSString *gId; // @synthesize gId=_gId;
@property(copy, nonatomic) NSString *masterID; // @synthesize masterID=_masterID;
@property(copy, nonatomic) NSString *master; // @synthesize master=_master;
@property(copy, nonatomic) NSString *gType; // @synthesize gType=_gType;
@property(copy, nonatomic) NSString *gIcon; // @synthesize gIcon=_gIcon;
@property(copy, nonatomic) NSString *gRemakeName; // @synthesize gRemakeName=_gRemakeName;
@property(copy, nonatomic) NSString *gName; // @synthesize gName=_gName;
@end

NS_ASSUME_NONNULL_END
