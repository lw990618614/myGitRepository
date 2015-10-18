//
//  YMUserScore.h
//  mobi
//
//  Created by Simon on 9/15/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMUserScore : NSObject

/**
 *  用户级别
 */
@property (nonatomic, strong) NSString* Level;

/**
 *  总收入
 */
@property (nonatomic) long TotalIncome;
/**
 *  使用的天数
 */
@property (nonatomic) long int Usedtime;
/**
 *  收入
 */
@property (nonatomic) long Income;
/**
 *  总的奖励
 */
@property (nonatomic) long TotalBonus;
/**
 *  徒弟数量
 */
@property (nonatomic) long CountOfPrentice;
/**
 *  徒弟的奖励
 */
@property (nonatomic) long BonusOfPretice;
/**
 *  徒孙的奖励
 */
@property (nonatomic) long BonusOfSubPretice;
@end
