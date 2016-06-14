//
//  TTAHeaderLineView.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAHeaderLineCollectionViewCell.h"
#import "TTAHeaderLineLoop.h"
#import "TTAHeaderLineLoopView.h"
#import "TTALoopViewFlowLayout.h"
#import "TTAWeakTimerTargetObj.h"

@interface TTAHeaderLineLoopView () <UICollectionViewDataSource, UICollectionViewDelegate>
/**
 *  滚动 scrollView
 */
@property (nonatomic, strong) UICollectionView *loopView;

/**
 *  标题 label
 */
@property (nonatomic, strong) UILabel *titleLabel;

/**
 *  pageControl
 */
@property (nonatomic, strong) UIPageControl *pageControl;

/**
 *  放 titleLabel 和 pageControl 的 view
 */
@property (nonatomic, strong) UIView *tempView;

/**
 *   图片数组
 */
@property (nonatomic, strong) NSArray *URLs;

/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titles;

/**
 *  定时器
 */
@property (nonatomic, strong) TTAWeakTimerTargetObj *timer;

@end


@implementation TTAHeaderLineLoopView
- (instancetype)initWithURLs:(NSArray<NSString *> *)URLs titles:(NSArray<NSString *> *)titles {
    if (self = [super init]) {
        // 保存 URLs 数组
        self.URLs = URLs;
        // 保存 titles 数组
        self.titles = titles;
        // 创建完成后,将 collection 向左滚动
        dispatch_async (dispatch_get_main_queue (), ^{
          [self.loopView
          scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:URLs.count inSection:0]
                 atScrollPosition:UICollectionViewScrollPositionLeft
                         animated:NO];

          // 在这里拿到数组后进行设置 pageControl 和 titleLabel,初始化其显示
          self.pageControl.numberOfPages = self.URLs.count;
          self.titleLabel.text           = titles[0];
            
            // 加载到数据后,设置完成 pageControl 和 titleLabel 后开始自动滚动
            // 添加定时器
            [self addTimer];
            
            [self setNeedsLayout];
        });
        
        // 刷新数据
        [self.loopView reloadData];
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
    [loopView registerClass:[TTAHeaderLineCollectionViewCell class]
    forCellWithReuseIdentifier:@"HeaderLineCell"];

    // 设置数据源方法
    loopView.dataSource = self;

    // 设置代理
    loopView.delegate = self;

    // 将 loopView 加入到 self 中
    [self addSubview:loopView];
    self.loopView = loopView;


    // 创建一个 UIView,并将 titleLabel 和 pageControl放到这个 View 上
    UIView *tempView = [[UIView alloc] init];

    tempView.backgroundColor = [UIColor blackColor];
    tempView.alpha           = 0.6;

    [self addSubview:tempView];
    self.tempView = tempView;

    // 创建 label
    UILabel *titleLabel  = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel      = titleLabel;

    // 添加到 self 上
    [tempView addSubview:titleLabel];

    // 创建 pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];

    // 设置 pageControl
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.pageIndicatorTintColor        = [UIColor grayColor];

    self.pageControl = pageControl;

    // 添加到 self 上
    [tempView addSubview:pageControl];
}

#pragma mark - data souces
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.URLs.count * 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTAHeaderLineCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderLineCell"
                                              forIndexPath:indexPath];

    cell.URL = self.URLs[indexPath.item % self.URLs.count];

    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 计算当前的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算当前页码
    NSInteger page = offsetX / self.bounds.size.width;

    // 判断
    if (page == 0) {
        scrollView.contentOffset = CGPointMake (self.URLs.count * self.bounds.size.width, 0);
    } else if (page == [self.loopView numberOfItemsInSection:0] - 1) {
        scrollView.contentOffset = CGPointMake ((self.URLs.count - 1) * self.bounds.size.width, 0);
    }
    
    // 设置标题与 pageControl
    self.titleLabel.text = self.titles[page % self.URLs.count];
    self.pageControl.currentPage = page % self.URLs.count;
    
    // 滚动完成后添加定时器
    [self addTimer];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    // 手动拖动时,移除 timer
    [self removeTimer];
    self.timer = nil;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    // 自动滚动完成时,调用这个方法
    [self scrollViewDidEndDecelerating:scrollView];
}


#pragma mark - 定时器设置
-(void)addTimer{
    if (self.timer) {
        return;
    }
    
    self.timer = [TTAWeakTimerTargetObj scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)removeTimer{
    [self.timer invalidate];
}

-(void)nextImage{
    // 计算当前的偏移量
    CGFloat offsetX = self.loopView.contentOffset.x;
    // 计算当前页码
    NSInteger page = offsetX / self.bounds.size.width;
    
    // 修改偏移量
    [self.loopView setContentOffset:CGPointMake((page + 1) * self.bounds.size.width, 0) animated:YES];
}







- (void)layoutSubviews {
    [super layoutSubviews];
    // 布局loopView
    self.loopView.frame = self.bounds;

    CGFloat margin = 10;

    // 布局 tempView
    CGFloat tempX = 0;
    CGFloat tempH = 30;
    CGFloat tempY = self.bounds.size.height - tempH;
    ;
    CGFloat tempW = self.bounds.size.width;

    self.tempView.frame = CGRectMake (tempX, tempY, tempW, tempH);


    // 布局 pageControl
    CGFloat pageH = tempH;
    CGFloat pageY = 0;
    CGFloat pageW = [self.pageControl sizeForNumberOfPages:self.URLs.count].width;
    CGFloat pageX = self.bounds.size.width - margin - pageW;

    self.pageControl.frame = CGRectMake (pageX, pageY, pageW, pageH);

    // 布局 titleLabel
    CGFloat titleX = margin;
    CGFloat titleH = tempH;
    CGFloat titleY = 0;
    CGFloat titleW = self.bounds.size.width - 3 * margin - pageW;

    self.titleLabel.frame = CGRectMake (titleX, titleY, titleW, titleH);
}

@end
