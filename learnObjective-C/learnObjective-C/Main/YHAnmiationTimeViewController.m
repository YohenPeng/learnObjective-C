//
//  YHAnmiationTimeViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/4/5.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHAnmiationTimeViewController.h"
#import "Masonry.h"

@interface YHAnmiationTimeViewController ()
@property(nonatomic,strong)CALayer *animationView;
@end

@implementation YHAnmiationTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"YHAnmiationTimeViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Do any additional setup after loading the view.
    [self.view.layer addSublayer:self.animationView];
    
    CABasicAnimation *baseAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    baseAnimation.fillMode = kCAFillModeBoth;
    baseAnimation.removedOnCompletion = NO;
    baseAnimation.duration = 10;
    baseAnimation.fromValue = @(0);
    baseAnimation.toValue = @(CGRectGetMaxX(self.view.bounds));
    [self.animationView addAnimation:baseAnimation forKey:@"baseAnimation"];
    self.animationView.speed = 0;
    
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"继续" forState:UIControlStateNormal];
    [startBtn setBackgroundColor:[UIColor greenColor]];
    [startBtn addTarget:self action:@selector(startAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:startBtn];
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(20);
    }];
    
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"暂停" forState:UIControlStateNormal];
    [stopBtn setBackgroundColor:[UIColor redColor]];
    [stopBtn addTarget:self action:@selector(stopAnimation:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:stopBtn];
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(startBtn.mas_bottom).with.offset(20);
    }];
    
    UISlider *sliler = [UISlider new];
    [sliler setMinimumValue:0];
    [sliler setMaximumValue:1];
    [self.view addSubview:sliler];
    [sliler mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    [sliler addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)sliderAction:(UISlider *)slider{
    CFTimeInterval time = 10 * slider.value;
    self.animationView.timeOffset = time;
}


-(void)startAnimation:(id)sender{
    //将动画的时间偏移量作为暂停的时间点
//    t = (tp - begin) * speed + offset
    CFTimeInterval pauseTime = self.animationView.timeOffset;
    //将
    CFTimeInterval begin = CACurrentMediaTime() - pauseTime;
    [self.animationView setTimeOffset:0];
    NSLog(@"start:%0.2f",begin);
    [self.animationView setBeginTime:begin];
    self.animationView.speed = 1;
}

-(void)stopAnimation:(id)sender{
    //这里转换成本地时间，将本地时间赋值给timeOffset，将速度设置为0，则回归到没有动画的情况是一致的，假如连续进来会发现pause是为0的
//    t = (tp - begin) * speed + offset
    
    
    
    CFTimeInterval nowTime = CACurrentMediaTime();
    CFTimeInterval pauseTime = [self.animationView convertTime:CACurrentMediaTime() fromLayer:nil];
//    CACurrentMediaTime() - 动画已经执行的时间
    NSLog(@"stop: %0.2f",pauseTime);
    self.animationView.timeOffset = pauseTime;
    self.animationView.speed = 0;
    
    //如果某个layer上面没有动画，则layer的本地时间和CACurrentMediaTime()是一致的
    //    CFTimeInterval pauseTime = [self.view.layer convertTime:CACurrentMediaTime() toLayer:nil];
    //    CFTimeInterval nowTime = CACurrentMediaTime();
    //    NSLog(@"");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CALayer*)animationView{
    if (!_animationView) {
        _animationView = [CALayer layer];
        _animationView.backgroundColor = [UIColor yellowColor].CGColor;
        _animationView.frame = CGRectMake(0, 300, 50, 50);
    }
    return _animationView;
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
