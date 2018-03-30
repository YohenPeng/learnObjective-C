//
//  HYRunLoopTaskManager.h
//  testRunLoop
//
//  Created by peng yihan on 2018/3/27.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HYTask)(void);

@interface YHMainRLTaskManager : NSObject

+(instancetype)shareManager;

-(void)excuteTaskIfFree:(HYTask)task;

@end
