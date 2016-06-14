//
//  TTANews.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTANetworkManager.h"
#import "TTANews.h"

@implementation TTANews

+ (instancetype)newsWithDic:(NSDictionary *)dic {
    return [[self alloc] initWithDic:dic];
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

+ (void)loadNewsWithSuccess:(void (^) (NSArray *))success failed:(void (^) (NSError *))failed {
    // 断言成功回调不能为空
    NSAssert (success, @"成功回调不能为空");

    [[TTANetworkManager sharedNetworkManager] GET:@"article/headline/T1348647853363/0-20.html"
    parameters:nil
    progress:nil
    success:^(NSURLSessionDataTask *_Nonnull task, NSDictionary *responseObject) {
        // 从字典中取出键
        NSString *dataKey = responseObject.keyEnumerator.nextObject;
        // 取出数组
        NSArray *newsesArray = responseObject[dataKey];
        NSMutableArray *newsesArrayM = [NSMutableArray arrayWithCapacity:newsesArray.count];
        for (NSDictionary *dic in newsesArray) {
            TTANews *news = [TTANews newsWithDic:dic];
            [newsesArrayM addObject:news];
        }
        
        // 加载完成数据后回调
        success(newsesArrayM.copy);
        
    }
    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
      failed (error);
    }];
}




@end
