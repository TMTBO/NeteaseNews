//
//  TTAHeaderLineView.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAHeaderLineLoopView.h"
#import "TTALoopViewFlowLayout.h"
#import "TTAHeaderLineCollectionViewCell.h"
#import "TTAHeaderLineLoop.h"

@interface TTAHeaderLineLoopView () <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *loopView;


@property (nonatomic, strong) NSArray *URLs;

@end


@implementation TTAHeaderLineLoopView
- (instancetype)initWithURLs:(NSArray<NSString *> *)URLs titles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {
        // 保存 URLs
        self.URLs = URLs;
        
        // 创建完成后,将 collection 向左滚动
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.loopView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:URLs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
        });
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark - setup
- (void)setup {
    // 创建 loopView
    UICollectionView *loopView =
    [[UICollectionView alloc] initWithFrame:CGRectZero
                       collectionViewLayout:[[TTALoopViewFlowLayout alloc] init]];

    // 注册 cell
    [loopView registerClass:[TTAHeaderLineCollectionViewCell class] forCellWithReuseIdentifier:@"HeaderLineCell"];
    
    // 设置数据源方法
    loopView.dataSource = self;
    
    // 设置代理
    loopView.delegate = self;

    // 将 loopView 加入到 self 中
    [self addSubview:loopView];
    self.loopView = loopView;

    // 创建 label

    // 创建 pageControl
}

#pragma mark - data souces
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.URLs.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTAHeaderLineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderLineCell" forIndexPath:indexPath];
    
    cell.URL = self.URLs[indexPath.item % self.URLs.count];
    
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 计算当前的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算当前页码
    NSInteger page = offsetX / self.bounds.size.width;

    // 判断
    if (page == 0) {
        scrollView.contentOffset = CGPointMake(self.URLs.count * self.bounds.size.width, 0);
    }else if (page == [self.loopView numberOfItemsInSection:0] - 1) {
        scrollView.contentOffset = CGPointMake((self.URLs.count - 1) * self.bounds.size.width, 0);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.loopView.frame = self.bounds;
}

@end
