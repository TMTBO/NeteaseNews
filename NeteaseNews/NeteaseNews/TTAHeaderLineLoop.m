//
//  TTAHeaderLineLoop.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAHeaderLineLoop.h"
#import "TTANetworkManager.h"

@implementation TTAHeaderLineLoop

+ (instancetype)headerLineLoopWithDic:(NSDictionary *)dic {
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

+ (void)headerLinesSuccess:(void (^) (NSArray *headerLineLoops))success
                    failed:(void (^) (NSError *error))failed {
    // 断言success 一定要有值
    NSAssert (success, @"成功回调一定要有一个值");

    // 从网络请求数据
    [[TTANetworkManager manager] GET:@"http://c.m.163.com/nc/ad/headline/0-4.html"
    parameters:nil
    progress:nil
    success:^(NSURLSessionDataTask *_Nonnull task, NSDictionary *responseObject) {

      // 取出数组
      NSString *dataKey        = responseObject.keyEnumerator.nextObject;
      NSArray *headerLineArray = responseObject[dataKey];

      // 转模型
      NSMutableArray *headerLineArrayM = [NSMutableArray arrayWithCapacity:headerLineArray.count];

      [headerLineArray enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *_Nonnull stop) {
        TTAHeaderLineLoop *headerLineLoop = [TTAHeaderLineLoop headerLineLoopWithDic:dic];
        [headerLineArrayM addObject:headerLineLoop];
      }];

      // 拿到数据后回调
      success (headerLineArrayM.copy);
    }
    failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
      // 失败后回调
      if (failed) {
          failed (error);
      }
    }];
}


@end
