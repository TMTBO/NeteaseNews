//
//  TTANetworkManager.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTANetworkManager.h"


@implementation TTANetworkManager
+ (instancetype)sharedNetworkManager {
    static TTANetworkManager *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[self alloc] initWithBaseURL:baseURL];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    
    return instance;
}
@end
