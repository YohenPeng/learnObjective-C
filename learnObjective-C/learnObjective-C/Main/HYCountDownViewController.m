//
//  HYCountDownViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/5/30.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "HYCountDownViewController.h"
#import "HYCountDownBtn.h"
#import "Masonry.h"

@interface HYCountDownViewController ()
@property(strong,nonatomic)HYCountDownBtn *countBtn1;
@property(strong,nonatomic)HYCountDownBtn *countBtn2;
@end

@implementation HYCountDownViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.countBtn1];
    self.countBtn1.frame = CGRectMake(10, 100, 80, 40);
    
    [self.view addSubview:self.countBtn2];
    self.countBtn2.frame = CGRectMake(10, 200, 80, 40);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazy object
-(HYCountDownBtn *)countBtn1{
    if (!_countBtn1) {
        _countBtn1 = [[HYCountDownBtn alloc]initWithBtnId:1 tips:@"发送验证码" timerInterval:60 action:^BOOL{
            return YES;
        }];
    }
    return _countBtn1;
}

-(HYCountDownBtn *)countBtn2{
    if (!_countBtn2) {
        _countBtn2 = [[HYCountDownBtn alloc]initWithBtnId:2 tips:@"发送验证码" timerInterval:60 action:^BOOL{
            return YES;
        }];
    }
    return _countBtn2;
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
