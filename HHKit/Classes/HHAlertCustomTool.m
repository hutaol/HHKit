//
//  HHAlertCustomTool.m
//  HHKit
//
//  Created by Henry on 2020/11/3.
//

#import "HHAlertCustomTool.h"
#import <SPAlertController/SPAlertController.h>
#import "UIWindow+HHHelper.h"
#import "HHDefine.h"

@implementation HHAlertCustomTool

+ (UIViewController *)topViewController {
    return [UIWindow topViewController];
}

// 确定 警示框
+ (void)alertWithMessage:(NSString *)message {
    [self alertWithTitle:GetLocalLanguageTextValue(@"Tips") message:message cancelTitle:nil buttonTitles:@[GetLocalLanguageTextValue(@"Done")] actionsBlock:nil];
}

// 取消，确定 警示框
+ (void)alert2WithMessage:(NSString *)message confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {
    [self alertWithTitle:GetLocalLanguageTextValue(@"Tips") message:message cancelTitle:GetLocalLanguageTextValue(@"Cancel") buttonTitles:@[GetLocalLanguageTextValue(@"Done")] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

#pragma mark - Alert
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleAlert];
    alertController.tapBackgroundViewDismiss = NO;
    
    if (cancelTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    [[self topViewController] presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Sheet
+ (void)sheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleActionSheet];

    if (cancelTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (destructiveTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-2, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    UIViewController *curVC = [self topViewController];

    if (curVC) {
        
        UIDevice *currentDevice = [UIDevice currentDevice];
        // ipad
        if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad && [alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = curVC.view; // 必须加
        }
        [curVC presentViewController:alertController animated:YES completion:nil];
        
    }
}

+ (void)sheetWithMessage:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    [self sheetWithTitle:nil message:message cancelTitle:GetLocalLanguageTextValue(@"Cancel") destructiveTitle:nil buttonTitles:buttonTitles actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex >= 0) {
            if (actionsBlock) {
                actionsBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

@end
