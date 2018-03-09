//
//  YHMainViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/9.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHMainViewController.h"
#import "YHBaseTableViewModel.h"
#import "YHTableView.h"

@interface YHMainViewController ()
@property(nonatomic,strong)YHTableView *tableView;
@property(nonatomic,strong)YHBaseTableViewModel *tableViewModel;

@property(nonatomic,strong)NSArray *dataArray;
@end

@implementation YHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(YHTableView *)tableView{
    if (!_tableView) {
        _tableView = [[YHTableView alloc]init];
    }
    return _tableView;
}

-(YHBaseTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel = [[YHBaseTableViewModel alloc]initWithTable:self.tableView];
    }
    
    return _tableViewModel;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"屏幕外截图",@"YHOutScreenShotController"]];
    }
    return _dataArray;
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
