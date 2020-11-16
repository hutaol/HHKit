//
//  NSBundle+HHKit.h
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (HHKit)

+ (instancetype)hhResourceBundle;

+ (UIImage *)getImageForHHKit:(NSString *)name;

+ (void)hhResetLanguage;

+ (NSString *)hhLocalizedStringForKey:(NSString *)key;

+ (NSString *)hhLocalizedStringForKey:(NSString *)key value:(nullable NSString *)value;

@end

NS_ASSUME_NONNULL_END
