//
//  TTANewsTableViewCell.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTANews.h"
#import "TTANewsTableViewCell.h"
#import "UIImageView+Webcache.h"


@interface TTANewsTableViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *iconImage;

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) IBOutlet UILabel *detailLabel;

@property (nonatomic, weak) IBOutlet UILabel *replyLabel;


@end

@implementation TTANewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - 重写 news 的setter方法
- (void)setNews:(TTANews *)news {
    _news = news;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    self.titleLabel.text  = news.title;
    self.detailLabel.text = news.digest;
    self.replyLabel.text  = [NSString
    stringWithFormat:@"%@跟帖", news.replyCount.intValue > 10000 ?
                                [NSString stringWithFormat:@"%.2f万", news.replyCount.floatValue / 10000] :
                                @(news.replyCount.intValue)];
}

@end
