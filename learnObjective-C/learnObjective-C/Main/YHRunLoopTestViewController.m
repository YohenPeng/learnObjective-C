//
//  YHRunLoopTestViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/30.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHRunLoopTestViewController.h"
#import "YHTimerManager.h"
#import "YHMainRLTaskManager.h"

@interface YHRunLoopTestViewController ()
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation YHRunLoopTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.array = [NSMutableArray new];
    
    NSString *timerId;
    timerId = [[YHTimerManager shareManager] startTimer:1 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"1");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:1 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"1-1");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:2 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"2");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:3 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"3");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:3 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"3-1");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:4 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
        NSLog(@"4");
    }];
    [self.array addObject:timerId];
    
    timerId = [[YHTimerManager shareManager] startTimer:4 runloopMode:YHTimerCommonMode timeOutFireAction:^{
        NSLog(@"4-1");
    }];
    [self.array addObject:timerId];
}

-(void)dealloc{
    for (NSString* timerId in self.array) {
        [[YHTimerManager shareManager]stopTimer:timerId];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
