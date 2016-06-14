//
//  TTANewsViewController.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTANewsViewController.h"
#import "TTANews.h"
#include "TTANewsTableViewCell.h"

@interface TTANewsViewController ()

@property (nonatomic, strong) NSArray *newses;

@end

@implementation TTANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self loadData];
}

-(void)loadData{
    [TTANews loadNewsWithSuccess:^(NSArray *newses) {
        self.newses = newses;
        
        // 刷新数据
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        NSLog(@"数据加载失败,%@",error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TTANewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    
    // 设置 Cell...
    cell.news = self.newses[indexPath.row];
    
    return cell;
}



@end
