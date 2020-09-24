//
//  DYTaskModel.h
//  MYDYHelper
//
//  Created by apple on 2020/7/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYTaskModel : NSObject
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *group_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *task_id;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *TaskResult;
@property (nonatomic, strong) NSString *task_type;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *foreign_id;
@property (nonatomic, strong) NSString *content;

@property (nonatomic, copy) NSString *commentArrayString;
@property (nonatomic, copy) NSString *is_comment;
@property (nonatomic, copy) NSString *is_like;
@property (nonatomic, copy) NSString *task_modular;
@property (nonatomic, copy) NSString *task_time;


@end

NS_ASSUME_NONNULL_END
