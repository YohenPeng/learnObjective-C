//
//  YHRunLoopTestViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/30.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHRunLoopTestViewController.h"
#import "YHMainRLTaskManager.h"
#import "YHTimer.h"

@interface YHRunLoopTestViewController ()
@property(nonatomic,strong)NSMutableArray *array;
@property(strong,nonatomic)NSMutableArray *timerArray;
@property(strong,nonatomic)UIImageView *imageView;
@end

@implementation YHRunLoopTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    UIImage *resizeImage = [[UIImage imageNamed:@"test"] ]
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"test"]];
    self.imageView.contentMode = UIViewContentModeTop;
    self.imageView.layer.anchorPoint = CGPointMake(0.5, 0);
    self.imageView.frame = CGRectMake(100, 100, 100,0);
    [self.view addSubview:self.imageView];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds.size.height"];
    animation.toValue = @(200);
    animation.duration = 10;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.imageView.layer addAnimation:animation forKey:@"kLyrcisAnimation"];
    
    
    
//
//    self.timerArray = [NSMutableArray new];
//
//    YHTimer *timer;
//
//    timer = [YHTimer startTimer:1 runloopMode:YHTimerDefaultMode timeOutFireAction:^{
//        NSLog(@"1");
//    }];
//
//    [self.timerArray addObject:timer];
//
//    timer = [YHTimer startTimer:1 runloopMode:YHTimerCommonMode timeOutFireAction:^{
//        NSLog(@"1");
//    }];
//
//    [self.timerArray addObject:timer];
//
//    timer = [YHTimer startTimer:2 runloopMode:YHTimerCommonMode timeOutFireAction:^{
//        NSLog(@"2");
//    }];
//    [self.timerArray addObject:timer];
    
}

-(void)dealloc{
    
    for (YHTimer *timer in self.timerArray) {
        [timer stop];
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
