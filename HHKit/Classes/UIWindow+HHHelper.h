//
//  UIWindow+HHHelper.h
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIWindow (HHHelper)

- (UIViewController *)currentTopViewController;

+ (UIWindow *)keyWindow;

+ (UIViewController *)topViewController;


@end

NS_ASSUME_NONNULL_END
