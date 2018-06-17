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
    self.title = @"主页面";
    [self.view addSubview:self.tableView];
    [self.tableViewModel reload];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(YHTableView *)tableView{
    if (!_tableView) {
        _tableView = [[YHTableView alloc]initWithFrame:self.view.frame];
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

-(YHBaseTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel = [[YHBaseTableViewModel alloc]initWithTable:self.tableView];
        typeof(self) __weak weakSelf = self;
        [_tableViewModel setupCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
            }
            typeof(self) __strong strongSelf = weakSelf;
            NSArray *array = [strongSelf.dataArray objectAtIndex:indexPath.row];
            cell.textLabel.text = [array objectAtIndex:0];
            return cell;
            
        }];
        
        [_tableViewModel setupNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
            typeof(self) __strong strongSelf = weakSelf;
            return strongSelf.dataArray.count;
        }];
        
        [_tableViewModel setupDidSelectRowAtIndexPath:^(UITableView *tableView, NSIndexPath *indexPath) {
            typeof(self) __strong strongSelf = weakSelf;
            NSString *controllerString = [[strongSelf.dataArray objectAtIndex:indexPath.row] objectAtIndex:1];
            UIViewController *vc = [NSClassFromString(controllerString) new];
            [strongSelf.navigationController pushViewController:vc animated:YES];
        }];
        
    }
    
    return _tableViewModel;
}


-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"屏幕外截图",@"YHOutScreenShotController"],@[@"测试RunLoop",@"YHRunLoopTestViewController"],@[@"动画暂停与结束",@"YHAnmiationTimeViewController"],@[@"测试YYLabel",@"YHTestYYLabelViewController"],@[@"测试UILabel",@"YHTestUILabelViewController"],@[@"测试stackView",@"YHTestStackViewController"],@[@"CountDown测试",@"HYCountDownViewController"],@[@"降采样",@"YHDownSamplingController"]];
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
