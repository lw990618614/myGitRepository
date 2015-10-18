//
//  UIButton+Block.m
//  iCity
//
//  Created by dodohua on 13-8-14.
//
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static char UIButtonBlockKey;
@implementation UIButton (Block)
- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    objc_setAssociatedObject(self, &UIButtonBlockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}
- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, &UIButtonBlockKey);
    if (block) {
        block();
    }
}
@end
