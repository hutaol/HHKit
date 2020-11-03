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
	// Do any additional setup after loading the view, typically from a nib.
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////        [HHAlertTool alertWithMessage:@"2222"];
//        [HHToastTool show:@"333333"];
//    });
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClick {
//    [MBProgressHUD showError:@"222222"];
//    [MBProgressHUD show:@"3333"];
//    [HHAlertCustomTool alertWithMessage:@"111"];
//    [HHAlertTool sheetWithMessage:@"22" buttonTitles:@[@"33"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
//
//    }];
    [HHAlertTool alertWithMessage:@"22"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
