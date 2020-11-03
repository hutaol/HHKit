//
//  NSBundle+HHKit.h
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, HHLanguageType) {
    //跟随系统语言，默认
    HHLanguageSystem,
    //中文简体
    HHLanguageChineseSimplified,
    //中文繁体
    HHLanguageChineseTraditional,
    //英文
    HHLanguageEnglish,
    //日文
    HHLanguageJapanese,
};

#define HHLanguageTypeKey @"HHLanguageTypeKey"


@interface NSBundle (HHKit)

+ (instancetype)resourceBundle;

+ (UIImage *)getImage:(NSString *)name;

+ (void)resetLanguage;

+ (NSString *)localizedStringForKey:(NSString *)key;

+ (NSString *)localizedStringForKey:(NSString *)key value:(nullable NSString *)value;

@end

NS_ASSUME_NONNULL_END
