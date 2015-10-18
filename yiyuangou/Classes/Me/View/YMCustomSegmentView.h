//
//  YMCustomSegmentView.h
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YMCustomSegmentView;

@protocol CustomSegmentViewDelegate <NSObject>

@optional
- (void)segmentView:(YMCustomSegmentView *)segmentView selectedAtIndex:(NSInteger)index;

@end

@interface YMCustomSegmentView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, weak) id<CustomSegmentViewDelegate> delegate;

@end
