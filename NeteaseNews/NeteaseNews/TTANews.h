//
//  TTANews.h
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTANews : NSObject

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;

/**
 *  摘要
 */
@property (nonatomic, copy) NSString *digest;

/**
 *  跟帖数
 */
@property (nonatomic, assign) NSNumber *replyCount;

/**
 *  多图标记
 */
@property (nonatomic, strong) NSArray *imgextra;

/**
 *  大图标记
 */
@property (nonatomic, assign) BOOL imgType;

+(instancetype)newsWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(void)loadNewsWithSuccess:(void (^)(NSArray *newses))success failed:(void (^)(NSError *error))failed;

@end
