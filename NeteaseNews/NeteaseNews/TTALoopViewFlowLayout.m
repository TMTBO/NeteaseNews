//
//  TTALoopViewFlowLayout.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTALoopViewFlowLayout.h"

@implementation TTALoopViewFlowLayout
/**
 *  准备布局文件
 */
-(void)prepareLayout{
    [super prepareLayout];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    // 设置
    self.itemSize = CGSizeMake(width, height);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

@end
