//
//  HHDefine.h
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#ifndef HHDefine_h
#define HHDefine_h

#import "NSBundle+HHKit.h"

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


static inline NSString *GetLocalLanguageTextValue (NSString *key) {
    return [NSBundle hhLocalizedStringForKey:key];
}

static inline UIImage *GetImageWithName(NSString *name) {
    return [NSBundle getImageForHHKit:name];
}

#endif /* HHDefine_h */
