//
//  TTAWeakTimerTargetObj.m
//  NeteaseNews
//
//  Created by TobyoTenma on 16/6/14.
//  Copyright © 2016年 TobyoTenma. All rights reserved.
//

#import "TTAWeakTimerTargetObj.h"

@interface TTAWeakTimerTargetObj ()


@property (nonatomic, weak) id aTarget;
@property (nonatomic, assign) SEL aSelector;
@end

@implementation TTAWeakTimerTargetObj
/**
 *  该类的作用是用来接管定时器的强引用
 */

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    
    // 创建当前类对象
    TTAWeakTimerTargetObj *obj = [[TTAWeakTimerTargetObj alloc] init];
    obj.aTarget = aTarget; // 控制器
    obj.aSelector = aSelector; // 控制器的update方法
    
    return [NSTimer scheduledTimerWithTimeInterval:ti target:obj selector:@selector(update:) userInfo:userInfo repeats:yesOrNo];
}

- (void)update:(NSTimer *)timer {
    //    NSLog(@"%s", __FUNCTION__);
    [self.aTarget performSelector:self.aSelector withObject:timer];
}

@end
