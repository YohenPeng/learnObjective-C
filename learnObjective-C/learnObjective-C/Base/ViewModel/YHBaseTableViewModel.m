//
//  YHBaseTableViewModel.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/9.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHBaseTableViewModel.h"
@interface YHBaseTableViewModel () <UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)UITableView *tableView;

@property(copy,nonatomic)YHNumberOfRowsInSection numOfRowsInSectionBlock;
@property(copy,nonatomic)YHCellForRowAtIndexPath cellForRowAtIndexPathBlock;
@property(copy,nonatomic)YHDidSelectRowAtIndexPath didSelectRowAtIndexPathBlock;
@property(copy,nonatomic)YHHeightForRowAtIndexPath heightForRowAtIndexPathBlcok;
@end

@implementation YHBaseTableViewModel

-(instancetype)initWithTable:(UITableView *)tableView{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
    }
    return self;
}

-(void)setupNumberOfRowsInSection:(YHNumberOfRowsInSection)block{
    self.numOfRowsInSectionBlock = block;
}

-(void)setupCellForRowAtIndexPath:(YHCellForRowAtIndexPath)block{
    self.cellForRowAtIndexPathBlock = block;
}

-(void)setupDidSelectRowAtIndexPath:(YHDidSelectRowAtIndexPath)block{
    self.didSelectRowAtIndexPathBlock = block;
}

-(void)setupHeightForRowAtIndexPath:(YHHeightForRowAtIndexPath)block{
    self.heightForRowAtIndexPathBlcok = block;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.numOfRowsInSectionBlock) {
        return self.numOfRowsInSectionBlock(tableView,section);
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellForRowAtIndexPathBlock) {
        return self.cellForRowAtIndexPathBlock(tableView,indexPath);
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectRowAtIndexPathBlock) {
        self.didSelectRowAtIndexPathBlock(tableView, indexPath);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightForRowAtIndexPathBlcok) {
        self.heightForRowAtIndexPathBlcok(tableView,indexPath);
    }
    return 44;
}

-(void)reload{
    [self.tableView reloadData];
}

@end
