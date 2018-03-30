//
//  HYRunLoopTaskManager.m
//  testRunLoop
//
//  Created by peng yihan on 2018/3/27.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "HYMainRLTaskManager.h"
@interface HYMainRLTaskManager ()
@property(nonatomic,strong)NSMutableArray *mutableTaskArray;
@property(nonatomic,assign)BOOL isNowObserver;
@end


@implementation HYMainRLTaskManager

+(instancetype)shareManager{
    static HYMainRLTaskManager* instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYMainRLTaskManager alloc] init];
    });
    return instance;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.isNowObserver = NO;
        self.mutableTaskArray = [NSMutableArray new];
    }
    return self;
}


-(void)excuteTaskIfFree:(HYTask)task{
    [self.mutableTaskArray addObject:task];
    [self runTaskIfNeed];
}

-(void)runTaskIfNeed{
    if (!self.isNowObserver) {
        
        CFRunLoopRef runLoop = CFRunLoopGetCurrent();
        CFStringRef runLoopMode = kCFRunLoopDefaultMode;
        
        __weak typeof(self) weakSelf = self;
        CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0,^(CFRunLoopObserverRef observer, CFRunLoopActivity _) {
            
            __strong typeof(self) strongSelf = weakSelf;
            if (strongSelf.mutableTaskArray.count == 0){
                CFRunLoopRemoveObserver(runLoop, observer, runLoopMode);
                CFRelease(observer); // 注意释放，否则会造成内存泄露
                strongSelf.isNowObserver = NO;
                return;
            }
            
            HYTask task = strongSelf.mutableTaskArray.firstObject;
            [strongSelf.mutableTaskArray removeObject:task];
            [strongSelf performSelector:@selector(excuteBlock:)
                         onThread:[NSThread mainThread]
                       withObject:task waitUntilDone:NO modes:@[NSDefaultRunLoopMode]];
        });
        
        CFRunLoopAddObserver(runLoop, observer, runLoopMode);
        self.isNowObserver = YES;
    }
}


-(void)excuteBlock:(HYTask)task{
    if (task) {
        task();
    }
}








@end
