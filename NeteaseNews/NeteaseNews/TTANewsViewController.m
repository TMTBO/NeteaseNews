//
//  TTANewsViewController.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTANews.h"
#include "TTANewsTableViewCell.h"
#import "TTANewsViewController.h"

@interface TTANewsViewController ()

@property (nonatomic, strong) NSArray *newses;

@end

@implementation TTANewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 加载数据
    [self loadData];
}

- (void)loadData {
    [TTANews loadNewsWithSuccess:^(NSArray *newses) {
      self.newses = newses;

      // 刷新数据
      [self.tableView reloadData];
    }
    failed:^(NSError *error) {
      NSLog (@"数据加载失败,%@", error);
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    // 获取模型
    TTANews *news = self.newses[indexPath.row];

    TTANewsTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:[TTANewsTableViewCell reuseIdentifierWithNews:news]];

    // 设置 Cell...
    cell.news = news;

    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 获取模型
    TTANews *news = self.newses[indexPath.row];
    
    if (news.imgextra) {
        return 150;
    }else if (news.imgType){
        return 150;
    }else{
        return 90;
    }
}


@end
