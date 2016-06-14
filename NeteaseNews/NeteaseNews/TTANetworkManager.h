//
//  TTANetworkManager.h
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface TTANetworkManager : AFHTTPSessionManager

+(instancetype)sharedNetworkManager;

@end
