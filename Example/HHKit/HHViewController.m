//
//  HHViewController.m
//  HHKit
//
//  Created by 1325049637@qq.com on 10/29/2020.
//  Copyright (c) 2020 1325049637@qq.com. All rights reserved.
//

#import "HHViewController.h"
#import <HHKit/HHKit.h>


@interface HHViewController ()

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)onClick {

//    [HHConfiguration languageType:HHLanguageChineseSimplified];
//
//    [HHPhotoTool sheetPortraitWithController:self title:@"更换头像" completion:^(HHPhotoModel * _Nonnull model) {
//
//    }];
    
//    [HHAlertCustomTool inputWithTitle:@"dd" message:@"11" placeholder:@"11" cancel:@"取消" confirm:@"dd" confirmBlock:^(NSString * _Nonnull inputText) {
//        NSLog(@"%@", inputText);
//    }];
    [HHAlertCustomTool inputWithTitle:@"1" message:@"2" placeholders:@[@"1", @"2"] cancelTitle:@"ddd" buttonTitles:@[@"222"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
        
    }];
    
//    [HHAlertCustomTool ]
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
