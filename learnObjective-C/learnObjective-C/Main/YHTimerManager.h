//
//  YHTimerManager.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/30.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YHTimerRunLoopMode){
    YHTimerDefaultMode,
    YHTimerCommonMode
};

typedef void(^YHTimeOutFireAction)(void);

@interface YHTimerManager : NSObject

+(instancetype)shareManager;

/**
 开启定时器

 @param interval 间隔
 @param mode runloop模式
 @param action 动作
 @return 返回TimerId
 */
-(NSString *)startTimer:(NSTimeInterval)interval runloopMode:(YHTimerRunLoopMode)mode timeOutFireAction:(YHTimeOutFireAction)action;


/**
 停止定时器

 @param timerId 定时器Id
 */
-(void)stopTimer:(NSString *)timerId;



@end
