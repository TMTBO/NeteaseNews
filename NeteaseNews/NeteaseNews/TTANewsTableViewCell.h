//
//  TTANewsTableViewCell.h
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTANews;

@interface TTANewsTableViewCell : UITableViewCell

@property (nonatomic, strong) TTANews *news;

/**
 *  用来获取cell 的 reuseIdentifier
 */
+(NSString *)reuseIdentifierWithNews:(TTANews *)news;

@end
