//
//  TTAHeaderLineCollectionViewCell.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAHeaderLineCollectionViewCell.h"
#import "UIImageView+Webcache.h"

@interface TTAHeaderLineCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation TTAHeaderLineCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 在 cell 上添加一下 uiimageveiw
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
    }
    return self;
}

#pragma mark - 重写URL 的 setter
-(void)setURL:(NSString *)URL{
    _URL = URL;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URL]];
}

#pragma mark - 重写 layoutSubviews 方法
-(void)layoutSubviews{
    self.iconView.frame = self.bounds;
}



@end
