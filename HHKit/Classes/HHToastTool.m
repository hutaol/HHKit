//
//  HHToastTool.m
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import "HHToastTool.h"
#import "UIWindow+HHHelper.h"
#import <Toast/Toast.h>

@implementation HHToastTool

+ (void)show:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:2.0];
}

+ (void)showAtTop:(NSString *)message {
    [self show:message position:ToastToolPositionTop showTime:2.0];
}

+ (void)showAtCenter:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:2.0];
}

+ (void)showAtBottom:(NSString *)message {
    [self show:message position:ToastToolPositionBottom showTime:2.0];
}

+ (void)showLong:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:4.0];
}

+ (void)showLongAtTop:(NSString *)message {
    [self show:message position:ToastToolPositionTop showTime:4.0];
}

+ (void)showLongAtCenter:(NSString *)message {
    [self show:message position:ToastToolPositionCenter showTime:4.0];
}

+ (void)showLongAtBottom:(NSString *)message {
    [self show:message position:ToastToolPositionBottom showTime:4.0];
}

+ (void)show:(NSString *)message position:(ToastToolPosition)position showTime:(float)showTime {
    [self show:message position:position showTime:showTime view:nil];
}

+ (void)show:(NSString *)message position:(ToastToolPosition)position showTime:(float)showTime view:(UIView *)view {
    if (!view) {
        view = [UIWindow keyWindow];
    }
    switch (position) {
        case ToastToolPositionBottom:
            [view makeToast:message duration:showTime position:CSToastPositionBottom];
            break;
        case ToastToolPositionTop:
            [view makeToast:message duration:showTime position:CSToastPositionTop];
            break;
        case ToastToolPositionCenter:
            [view makeToast:message duration:showTime position:CSToastPositionCenter];
            break;
            
        default:
            break;
    }
}

+ (void)showActivity:(UIView *)view {
    if (!view) {
        view = [UIWindow keyWindow];
    }
    [view makeToastActivity:CSToastPositionCenter];
}

@end
