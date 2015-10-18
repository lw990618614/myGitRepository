//
//  UIView+tmri.m
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import "UIView+tmri.h"
//#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

/*
 * CONFIGURE THESE VALUES TO ADJUST LOOK & FEEL,
 * DISPLAY DURATION, ETC.
 */
// general appearance
#import "NSString+tmri.h"
static const CGFloat CSToastMaxWidth = 0.8; // 80% of parent view width
static const CGFloat CSToastMaxHeight = 0.8; // 80% of parent view height
static const CGFloat CSToastHorizontalPadding = 10.0;
static const CGFloat CSToastVerticalPadding = 10.0;
static const CGFloat CSToastCornerRadius = 6.0;
static const CGFloat CSToastOpacity = 0.8;
static const CGFloat CSToastFontSize = 16.0;
static const CGFloat CSToastMaxTitleLines = 0;
static const CGFloat CSToastMaxMessageLines = 0;
static const NSTimeInterval CSToastFadeDuration = 0.2;
// shadow appearance
static const CGFloat CSToastShadowOpacity = 0.8;
static const CGFloat CSToastShadowRadius = 6.0;
static const CGSize CSToastShadowOffset = { 4.0, 4.0 };
static const BOOL CSToastDisplayShadow = NO;
// display duration
static const NSTimeInterval CSToastDefaultDuration = 1.5;
// image view size
static const CGFloat CSToastImageViewWidth = 80.0;
static const CGFloat CSToastImageViewHeight = 80.0;
// activity
//static const CGFloat CSToastActivityWidth = 100.0;
//static const CGFloat CSToastActivityHeight = 40.0;
static const NSString * CSToastActivityDefaultPosition = @"center";
// interaction
static const BOOL CSToastHidesOnTap = YES; // excludes activity views
// associative reference keys
static const NSString * CSToastTimerKey = @"CSToastTimerKey";
static const NSString * CSToastActivityViewKey = @"CSToastActivityViewKey";
static const NSString * CSToastTapCallbackKey = @"CSToastTapCallbackKey";
// positions
NSString * const CSToastPositionTop = @"top";
NSString * const CSToastPositionCenter = @"center";
NSString * const CSToastPositionBottom = @"bottom";


@interface UIView (ToastPrivate)
- (void)hideToast:(UIView *)toast;
- (void)toastTimerDidFinish:(NSTimer *)timer;
//- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer;
//- (CGPoint)centerPointForPosition:(id)position withToast:(UIView *)toast;
//- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image;
//- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode;
@end

@implementation UIView (tmri)

- (void)setSize:(CGSize)size;
{
    CGPoint origin = [self frame].origin;
    
    [self setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
}

- (CGSize)size;
{
    return [self frame].size;
}

- (CGFloat)MinX;
{
    return CGRectGetMinX([self frame]);
}

- (void)setMinX:(CGFloat)x;
{
    CGRect frame = [self frame];
    frame.origin.x = x;
    [self setFrame:frame];
}

- (CGFloat)tmri_top;
{
    return CGRectGetMinY([self frame]);
}

- (void)setTmri_top:(CGFloat)y;
{
    CGRect frame = [self frame];
    frame.origin.y = y;
    [self setFrame:frame];
}

- (CGFloat)tmri_right;
{
    return CGRectGetMaxX([self frame]);
}

- (void)setTmri_right:(CGFloat)right;
{
    CGRect frame = [self frame];
    frame.origin.x = right - frame.size.width;
    
    [self setFrame:frame];
}

- (CGFloat)tmri_bottom;
{
    return CGRectGetMaxY([self frame]);
}

- (void)setTmri_bottom:(CGFloat)bottom;
{
    CGRect frame = [self frame];
    frame.origin.y = bottom - frame.size.height;
    
    [self setFrame:frame];
}

- (CGFloat)centerX;
{
    return [self center].x;
}

- (void)setCenterX:(CGFloat)centerX;
{
    [self setCenter:CGPointMake(centerX, self.center.y)];
}

- (CGFloat)centerY;
{
    return [self center].y;
}

- (void)setCenterY:(CGFloat)centerY;
{
    [self setCenter:CGPointMake(self.center.x, centerY)];
}

- (CGFloat)tmri_width;
{
    return CGRectGetWidth([self frame]);
}

- (void)setTmri_width:(CGFloat)width;
{
    CGRect frame = [self frame];
    frame.size.width = width;
    
    [self setFrame:CGRectStandardize(frame)];
}

- (CGFloat)tmri_height;
{
    return CGRectGetHeight([self frame]);
}

- (void)setTmri_height:(CGFloat)height;
{
    CGRect frame = [self frame];
    frame.size.height = height;
    [self setFrame:CGRectStandardize(frame)];
}

#pragma mark - Toast Methods

- (void)makeToast:(NSString *)message {
    
    if (![message isValid]) {
        message=@"";
        return;
    }
    [self makeToast:message duration:CSToastDefaultDuration position:nil];
}
- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position {
    UIView *toast = [self viewForMessage:message title:nil image:nil];
    [self showToast:toast duration:duration position:position];
}
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title {
//    UIView *toast = [self viewForMessage:message title:title image:nil];
//    [self showToast:toast duration:duration position:position];
//}
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position image:(UIImage *)image {
//    UIView *toast = [self viewForMessage:message title:nil image:image];
//    [self showToast:toast duration:duration position:position];
//}
//- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(id)position title:(NSString *)title image:(UIImage *)image {
//    UIView *toast = [self viewForMessage:message title:title image:image];
//    [self showToast:toast duration:duration position:position];
//}
//- (void)showToast:(UIView *)toast {
//    [self showToast:toast duration:CSToastDefaultDuration position:nil];
//}
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position {
    [self showToast:toast duration:duration position:position tapCallback:nil];
}
- (void)showToast:(UIView *)toast duration:(NSTimeInterval)duration position:(id)position
      tapCallback:(void(^)(void))tapCallback
{
//    self.userInteractionEnabled=NO;
    toast.center = [self centerPointForPosition:position withToast:toast];
    toast.alpha = 0.0;
    if (CSToastHidesOnTap) {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:toast action:@selector(handleToastTapped:)];
        [toast addGestureRecognizer:recognizer];
        toast.userInteractionEnabled = YES;
        toast.exclusiveTouch = YES;
    }
    [self addSubview:toast];
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         toast.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(toastTimerDidFinish:) userInfo:toast repeats:NO];
                         // associate the timer with the toast view
                         objc_setAssociatedObject (toast, &CSToastTimerKey, timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         objc_setAssociatedObject (toast, &CSToastTapCallbackKey, tapCallback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                     }];
}
- (void)hideToast:(UIView *)toast {
    [UIView animateWithDuration:CSToastFadeDuration
                          delay:0.0
                        options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                     animations:^{
                         toast.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         [toast removeFromSuperview];
                     }];
}
#pragma mark - Events
- (void)toastTimerDidFinish:(NSTimer *)timer {
    self.userInteractionEnabled=YES;
    [self hideToast:(UIView *)timer.userInfo];
}
- (void)handleToastTapped:(UITapGestureRecognizer *)recognizer {
    NSTimer *timer = (NSTimer *)objc_getAssociatedObject(self, &CSToastTimerKey);
    [timer invalidate];
    void (^callback)(void) = objc_getAssociatedObject(self, &CSToastTapCallbackKey);
    if (callback) {
        callback();
    }
    [self hideToast:recognizer.view];
}
//#pragma mark - Toast Activity Methods
//- (void)makeToastActivity:(NSString *)message {
//    
//    self.userInteractionEnabled=NO;
//    [self makeToastActivity:message position: CSToastActivityDefaultPosition];
//}
//- (void)makeToastActivity:(NSString *)message position:(id)position {
//    // sanity
//    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
//    if (existingActivityView != nil) return;
//    CGSize lableSize = [self calculateSizeWithText:message];
//
//    UIView *activityView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lableSize.width+45, lableSize.height+20)];
//    activityView.center = [self centerPointForPosition:position withToast:activityView];
//    activityView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:CSToastOpacity];
//    activityView.alpha = 0.0;
//    activityView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
//    activityView.layer.cornerRadius = CSToastCornerRadius;
//    if (CSToastDisplayShadow) {
//        activityView.layer.shadowColor = [UIColor blackColor].CGColor;
//        activityView.layer.shadowOpacity = CSToastShadowOpacity;
//        activityView.layer.shadowRadius = CSToastShadowRadius;
//        activityView.layer.shadowOffset = CSToastShadowOffset;
//    }
//    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//    activityIndicatorView.center = CGPointMake(20, activityView.bounds.size.height / 2);
//    [activityView addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
//    
//    
//    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(35, 10, lableSize.width,lableSize.height)];
//    label.textColor=[UIColor whiteColor];
//    label.backgroundColor=[UIColor clearColor];
//    label.textAlignment=NSTextAlignmentLeft;
//    label.numberOfLines = 0;
//    label.font=[UIFont systemFontOfSize:14];
//    label.adjustsFontSizeToFitWidth=YES;
//    label.text=message;
//    [activityView addSubview:label];
//    
//    // associate the activity view with self
//    objc_setAssociatedObject (self, &CSToastActivityViewKey, activityView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self addSubview:activityView];
//    [UIView animateWithDuration:CSToastFadeDuration
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         activityView.alpha = 1.0;
//                     } completion:nil];
//}
- (void)hideToastActivity {
    
    self.userInteractionEnabled=YES;
    
    UIView *existingActivityView = (UIView *)objc_getAssociatedObject(self, &CSToastActivityViewKey);
    if (existingActivityView != nil) {
        [UIView animateWithDuration:CSToastFadeDuration
                              delay:0.0
                            options:(UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState)
                         animations:^{
                             existingActivityView.alpha = 0.0;
                         } completion:^(BOOL finished) {
                             [existingActivityView removeFromSuperview];
                             objc_setAssociatedObject (self, &CSToastActivityViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                         }];
    }
}
#pragma mark - Helpers
- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast {
    if([point isKindOfClass:[NSString class]]) {
        if([point caseInsensitiveCompare:CSToastPositionTop] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + CSToastVerticalPadding);
        } else if([point caseInsensitiveCompare:CSToastPositionCenter] == NSOrderedSame) {
            return CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        }
    } else if ([point isKindOfClass:[NSValue class]]) {
        return [point CGPointValue];
    }
    // default to bottom
    return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - CSToastVerticalPadding);
}
- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font constrainedToSize:(CGSize)constrainedSize lineBreakMode:(NSLineBreakMode)lineBreakMode {
    if ([string respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = lineBreakMode;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle};
        CGRect boundingRect = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return CGSizeMake(ceilf(boundingRect.size.width), ceilf(boundingRect.size.height));
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    return [string sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
}
- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    // sanity
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    // dynamically build a toast view with any combination of message, title, & image.
    UILabel *messageLabel = nil;
    UILabel *titleLabel = nil;
    UIImageView *imageView = nil;
    // create the parent view
    UIView *wrapperView = [[UIView alloc] init];
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    wrapperView.layer.cornerRadius = CSToastCornerRadius;
    if (CSToastDisplayShadow) {
        wrapperView.layer.shadowColor = [UIColor blackColor].CGColor;
        wrapperView.layer.shadowOpacity = CSToastShadowOpacity;
        wrapperView.layer.shadowRadius = CSToastShadowRadius;
        wrapperView.layer.shadowOffset = CSToastShadowOffset;
    }
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:CSToastOpacity];
    if(image != nil) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(CSToastHorizontalPadding, CSToastVerticalPadding, CSToastImageViewWidth, CSToastImageViewHeight);
    }
    CGFloat imageWidth, imageHeight, imageLeft;
    // the imageView frame values will be used to size & position the other views
    if(imageView != nil) {
        imageWidth = imageView.bounds.size.width;
        imageHeight = imageView.bounds.size.height;
        imageLeft = CSToastHorizontalPadding;
    } else {
        imageWidth = imageHeight = imageLeft = 0.0;
    }
    if (title != nil) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = CSToastMaxTitleLines;
        titleLabel.font = [UIFont boldSystemFontOfSize:CSToastFontSize];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.alpha = 1.0;
        titleLabel.text = title;
        // size the title label according to the length of the text
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        CGSize expectedSizeTitle = [self sizeForString:title font:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
    }
    if (message != nil) {
        messageLabel = [[UILabel alloc] init];
        messageLabel.numberOfLines = CSToastMaxMessageLines;
        messageLabel.font = [UIFont systemFontOfSize:CSToastFontSize];
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.alpha = 1.0;
        messageLabel.text = message;
        // size the message label according to the length of the text
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * CSToastMaxWidth) - imageWidth, self.bounds.size.height * CSToastMaxHeight);
        CGSize expectedSizeMessage = [self sizeForString:message font:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
    }
    // titleLabel frame values
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    if(titleLabel != nil) {
        titleWidth = titleLabel.bounds.size.width;
        titleHeight = titleLabel.bounds.size.height;
        titleTop = CSToastVerticalPadding;
        titleLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
    } else {
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
    }
    // messageLabel frame values
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    if(messageLabel != nil) {
        messageWidth = messageLabel.bounds.size.width;
        messageHeight = messageLabel.bounds.size.height;
        messageLeft = imageLeft + imageWidth + CSToastHorizontalPadding;
        messageTop = titleTop + titleHeight + CSToastVerticalPadding;
    } else {
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
    }
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    CGFloat wrapperWidth = MAX((imageWidth + (CSToastHorizontalPadding * 2)), (longerLeft + longerWidth + CSToastHorizontalPadding));
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + CSToastVerticalPadding), (imageHeight + (CSToastVerticalPadding * 2)));
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    if(titleLabel != nil) {
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        [wrapperView addSubview:titleLabel];
    }
    if(messageLabel != nil) {
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        [wrapperView addSubview:messageLabel];
    }
    if(imageView != nil) {
        [wrapperView addSubview:imageView];
    }
    return wrapperView;
}

-(void)startRotateAnimation
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = NSIntegerMax;
    [self.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
-(CGSize)calculateSizeWithText:(NSString *)text
{
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    CGSize textSize =  [text boundingRectWithSize:CGSizeMake(200, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
    return textSize;
}

-(void)stopRotateAnimation
{
    [self.layer removeAnimationForKey:@"rotationAnimation"];
}

@end
