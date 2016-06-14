//
//  TTAHeaderLineViewController.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAHeaderLineLoop.h"
#import "TTAHeaderLineLoopView.h"
#import "TTAHeaderLineViewController.h"

@interface TTAHeaderLineViewController ()
/**
 *  请求的数据
 */
@property (nonatomic, strong) NSArray *headerLines;

/**
 *  滚动的 view
 */
@property (nonatomic, strong) TTAHeaderLineLoopView *headerLineLoopView;


@end

@implementation TTAHeaderLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // 获取滚动数据
    [TTAHeaderLineLoop headerLinesSuccess:^(NSArray *headerLineLoops) {
      // 获取数据
      self.headerLines = headerLineLoops;

      // 添加 loopView
      [self.view addSubview:self.headerLineLoopView];
    }
    failed:^(NSError *error) {
      NSLog (@"获取滚动数据失败,%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazy loading data
- (TTAHeaderLineLoopView *)headerLineLoopView {
    if (!_headerLineLoopView) {
        // 取出图片 URL 数组
        NSArray *URLs = [self.headerLines valueForKeyPath:@"imgsrc"];

        // 取出标题 数组
        NSArray *titles = [self.headerLines valueForKeyPath:@"title"];

        _headerLineLoopView = [[TTAHeaderLineLoopView alloc] initWithURLs:URLs titles:titles];

        // 设置 frame
        _headerLineLoopView.frame = self.view.bounds;

    }
    return _headerLineLoopView;
}

@end
