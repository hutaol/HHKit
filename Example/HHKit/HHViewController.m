//
//  HHViewController.m
//  HHKit
//
//  Created by 1325049637@qq.com on 10/29/2020.
//  Copyright (c) 2020 1325049637@qq.com. All rights reserved.
//

#import "HHViewController.h"
#import <HHKit/HHKit.h>


@interface HHViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(onClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:UIBarButtonItemStylePlain target:self action:@selector(onClick)];
}

- (void)onClick {

    [HHPhotoTool imagePickerMultipleWithController:self count:3 seletedVideo:NO completion:^(NSArray<HHPhotoModel *> * _Nonnull images) {
        for (HHPhotoModel *image in images) {
            NSLog(@"%@", image.image);
            [self.dataSource addObject:image.image];
        }
        
        [self.tableView reloadData];

    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.imageView.image = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
    [HHPhotoTool showImageWithController:self source:self.dataSource previews:[self cellsForTableView:tableView] index:indexPath.row];
}

- (NSArray *)cellsForTableView:(UITableView *)tableView {
    
    NSInteger sections = tableView.numberOfSections;

    NSMutableArray *cells = [[NSMutableArray alloc]  init];

    for (int section = 0; section < sections; section++) {

        NSInteger rows =  [tableView numberOfRowsInSection:section];

        for (int row = 0; row < rows; row++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];

            [cells addObject:[tableView cellForRowAtIndexPath:indexPath].imageView];

        }

    }

    return cells;

}

@end
