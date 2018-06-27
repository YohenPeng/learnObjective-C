//
//  YHNewsViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsViewController.h"
#import "Masonry.h"
#import "YHNewsTableCell.h"
#import "YHNewsViewModel.h"
#import "YHNewsModel.h"
#import "YHTableViewHelper.h"
#import "YHNewsSection.h"
#import "YHNewsCell.h"

@interface YHNewsViewController ()<YHTableViewHelperDelegate>
@property(strong,nonatomic)UITableView *newsTableView;
@property(strong,nonatomic)YHNewsViewModel *newsViewModel;
@property(strong,nonatomic)YHTableViewHelper *tableViewHelper;
@end

@implementation YHNewsViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSelf];
    [self setupContentView];
    
    [self.newsViewModel requestNewsModelList:^(NSError *error) {
        if (nil == error) {
            
            YHNewsSection* section = [[YHNewsSection alloc]initWithCells:nil];
            
            for (YHNewsModel* model in self.newsViewModel.newsModelList) {
                YHNewsCell *cell = [YHNewsCell new];
                [cell setMyText:model.title];
                [section addCell:cell];
            }
            
            [self.tableViewHelper addSection:section];
            [self.tableViewHelper refresh];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                YHNewsSection* section = [[YHNewsSection alloc]initWithCells:nil];
                YHNewsCell *cell = [YHNewsCell new];
                [cell setMyText:@"测试测试"];
                [section addCell:cell];
                [self.tableViewHelper addSection:section immediate:YES animation:UITableViewRowAnimationLeft];
            });
        }
    }];
}

-(void)setupSelf{
    self.title = NSStringFromClass([self class]);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupContentView{
    [self newsTableView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazy object

-(UITableView *)newsTableView{
    if (!_newsTableView) {
        _newsTableView = ({
            UITableView *tableView = [UITableView new];
            [self.view addSubview:tableView];
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view);
            }];
            [YHNewsTableCell registerToTableView:_newsTableView];
            tableView;
        });
    }
    return _newsTableView;
}

-(YHTableViewHelper *)tableViewHelper{
    if (!_tableViewHelper) {
        _tableViewHelper = [[YHTableViewHelper alloc]initWithTableView:self.newsTableView sections:nil];
        _tableViewHelper.delegate = self;
    }
    return _tableViewHelper;
}

#pragma mark -- lazy object
-(YHNewsViewModel *)newsViewModel{
    if (!_newsViewModel) {
        _newsViewModel = [YHNewsViewModel new];
    }
    return _newsViewModel;
}

#pragma mark -- YHTableViewHelperDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(UIView *)tableHeaderView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

-(UIView *)tableFooterView{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 100)];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}


/*
#pragma mark -- UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsViewModel.newsModelList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YHNewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:kNewsTableCellId];
    if (!cell) {
        cell = [[YHNewsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNewsTableCellId];
    }
    YHNewsModel *model = [self.newsViewModel.newsModelList objectAtIndex:indexPath.row];
    [cell configure:model];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YHNewsModel *model = [self.newsViewModel.newsModelList objectAtIndex:indexPath.row];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:model.title message:model.content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    YHNewsModel *model = [self.newsViewModel.newsModelList objectAtIndex:indexPath.row];
    [self.newsViewModel deleteNewsModel:model complete:^(NSError *error) {
        if (nil == error) {
            [self.newsTableView reloadData];
        }
    }];
}
*/


@end
