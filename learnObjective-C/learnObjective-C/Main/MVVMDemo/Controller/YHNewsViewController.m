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

static NSString* const kNewsTableCellId = @"kNewsTableCellId";

@interface YHNewsViewController () <UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *newsTableView;
@property(strong,nonatomic)YHNewsViewModel *newsViewModel;
@end

@implementation YHNewsViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupSelf];
    [self setupContentView];
    
    [self.newsViewModel requestNews:^(NSError *error) {
        if (nil == error) {
            [self.newsTableView reloadData];
        }
    }];
}

-(void)setupSelf{
    self.title = NSStringFromClass([self class]);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupContentView{
    [self setupNewsTableView];
    
}

-(void)setupNewsTableView{
    self.newsTableView = ({
        UITableView *tableView = [UITableView new];
        tableView.dataSource = self;
        tableView.delegate = self;
        [tableView registerClass:[YHNewsTableCell class] forCellReuseIdentifier:kNewsTableCellId];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        tableView;
    });

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazy object
-(YHNewsViewModel *)newsViewModel{
    if (!_newsViewModel) {
        _newsViewModel = [YHNewsViewModel new];
    }
    return _newsViewModel;
}

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



@end
