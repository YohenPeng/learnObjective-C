//
//  YHOutScreenShotController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/9.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHOutScreenShotController.h"

@interface YHOutScreenShotController ()
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation YHOutScreenShotController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    typeof(self) __weak weakSelf = self;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
       typeof(self) __strong strongSelf = weakSelf;
        UIImage *image = [strongSelf snapshot:strongSelf.view];
        NSLog(@"%@",image);
    }];
    
    self.title = @"屏幕外截图";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
}

-(void)nextPage{
    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)snapshot:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()]; //1  内外都有效果
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO]; //2 屏幕外没有效果
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES]; //3  内外都有效果
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
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
