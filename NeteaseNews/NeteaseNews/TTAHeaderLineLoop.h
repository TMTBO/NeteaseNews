//
//  TTAHeaderLineLoop.h
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAHeaderLineLoop : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *imgsrc;

+(instancetype)headerLineLoopWithDic:(NSDictionary *)dic;

-(instancetype)initWithDic:(NSDictionary *)dic;

+(void)headerLinesSuccess:(void (^)(NSArray *headerLineLoops))success failed:(void (^)(NSError *error))failed;


@end
