//
//  NSBundle+HHKit.m
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import "NSBundle+HHKit.h"
#import "HHDefine.h"

@implementation NSBundle (HHKit)

+ (instancetype)hhResourceBundle {
    static NSBundle *hhBundle = nil;
    if (hhBundle == nil) {
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"HHAlertTool")];
        NSURL *bundleURL = [bundle URLForResource:@"HHKit" withExtension:@"bundle"];
        NSBundle *resourceBundle = [NSBundle bundleWithURL:bundleURL];
        if (!resourceBundle) {
            NSString * bundlePath = [bundle.resourcePath stringByAppendingPathComponent:@"HHKit.bundle"];
            resourceBundle = [NSBundle bundleWithPath:bundlePath];
        }
        hhBundle = resourceBundle ?: bundle;
    }
    return hhBundle;
}

+ (UIImage *)getImageForHHKit:(NSString *)name {
    NSString *path = [[[NSBundle hhResourceBundle] resourcePath] stringByAppendingPathComponent:name];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    if (!image) {
        image = [UIImage imageNamed:path];
    }
    return image;
}


static NSBundle *bundle = nil;
+ (void)hhResetLanguage {
    bundle = nil;
}

+ (NSString *)hhLocalizedStringForKey:(NSString *)key {
    return [self hhLocalizedStringForKey:key value:nil];
}

+ (NSString *)hhLocalizedStringForKey:(NSString *)key value:(NSString *)value {
    if (bundle == nil) {
        // 从bundle中查找资源
        bundle = [NSBundle bundleWithPath:[[NSBundle hhResourceBundle] pathForResource:[self getLanguage] ofType:@"lproj"]];
    }
    value = [bundle localizedStringForKey:key value:value table:nil];
    return [[NSBundle mainBundle] localizedStringForKey:key value:value table:nil];
}

+ (NSString *)getLanguage {
    HHLanguageType type = [[[NSUserDefaults standardUserDefaults] valueForKey:HHLanguageTypeKey] integerValue];
    
    NSString *language = nil;
    switch (type) {
        case HHLanguageSystem: {
            language = [NSLocale preferredLanguages].firstObject;
            if ([language hasPrefix:@"en"]) {
                language = @"en";
            } else if ([language hasPrefix:@"zh"]) {
                if ([language rangeOfString:@"Hans"].location != NSNotFound) {
                    language = @"zh-Hans"; // 简体中文
                } else { // zh-Hant\zh-HK\zh-TW
                    language = @"zh-Hant"; // 繁體中文
                }
            } else if ([language hasPrefix:@"ja"]) {
                language = @"ja-US";
            } else {
                language = @"en";
            }
        }
            break;
        case HHLanguageChineseSimplified:
            language = @"zh-Hans";
            break;
        case HHLanguageChineseTraditional:
            language = @"zh-Hant";
            break;
        case HHLanguageEnglish:
            language = @"en";
            break;
        case HHLanguageJapanese:
            language = @"ja-US";
            break;
    }
    return language;
}

@end
