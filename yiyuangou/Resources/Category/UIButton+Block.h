//
//  UIButton+Block.h
//  iCity
//
//  Created by dodohua on 13-8-14.
//
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)();
@interface UIButton (Block)
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block;
@end
