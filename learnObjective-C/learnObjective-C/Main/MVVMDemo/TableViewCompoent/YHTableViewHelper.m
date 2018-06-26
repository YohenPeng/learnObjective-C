//
//  YHTableViewDataSource.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHTableViewHelper.h"
#import "YHTableSectionDataSource.h"
#import "YHTableCellDataSource.h"

static CGFloat const kYHTableViewDefaultRowHeight = 44;

@interface YHTableViewHelper ()<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic,readwrite)UITableView *tableView;
@property(strong,nonatomic)NSArray<YHTableSectionDataSource *> *sectionArray;
@property(strong,nonatomic)NSMutableArray<YHTableSectionDataSource *> *sectionsArray;

@end

@implementation YHTableViewHelper

#pragma mark -- life cycle
-(instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<YHTableSectionDataSource *> *)sectionsArray{
    self = [super init];
    if (self) {
        self.tableView = tableView;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.sectionsArray = [NSMutableArray arrayWithArray:sectionsArray];
        for (YHTableSectionDataSource *source in self.sectionsArray) {
            source.helper = self;
        }
    }
    return self;
}

#pragma mark -- pulish Method
-(BOOL)addSection:(YHTableSectionDataSource *)section{
    
    section.helper = self;
    if (NSNotFound == [self.sectionsArray indexOfObject:section]) {
        [self.sectionsArray addObject:section];
        self.sectionArray = [NSArray arrayWithArray:self.sectionsArray];
        return YES;
    }
    return NO;
}

-(BOOL)addSection:(YHTableSectionDataSource *)section immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation{
    if([self addSection:section]){
        if (NO == isImmediate) {
            return YES;
        }
        NSInteger index = [self.sectionsArray indexOfObject:section];
        [self.tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
        return YES;
    }
    return NO;
}

-(BOOL)removeSection:(YHTableSectionDataSource *)section{
    if (NSNotFound != [self.sectionsArray indexOfObject:section]) {
        [self.sectionsArray removeObject:section];
        self.sectionArray = [NSArray arrayWithArray:self.sectionsArray];
        return YES;
    }
    return NO;
}

-(BOOL)removeSection:(YHTableSectionDataSource *)section immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation{
    NSInteger index = [self.sectionsArray indexOfObject:section];
    if ([self removeSection:section]) {
        if (NO == isImmediate) {
            return YES;
        }
        [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:animation];
        return YES;
    }
    return NO;
}

-(BOOL)refresh{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableHeaderView)]) {
        self.tableView.tableHeaderView = [self.delegate tableHeaderView];
    }else{
        self.tableView.tableHeaderView = nil;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableFooterView)]) {
        self.tableView.tableFooterView = [self.delegate tableFooterView];
    }else{
        self.tableView.tableFooterView = nil;
    }
    
    [self.tableView reloadData];
    return YES;
}

#pragma mark -- UITableViewDataSource && UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.sectionsArray) {
        return self.sectionsArray.count;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.sectionsArray && section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:section];
        return sectionSource.cellArray.count;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sectionsArray && indexPath.section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:indexPath.section];
        if(sectionSource.cellArray && indexPath.row < sectionSource.cellArray.count){
            YHTableCellDataSource *cellSource = [sectionSource.cellArray objectAtIndex:indexPath.row];
            return [cellSource cell:tableView];
        }
        return nil;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sectionsArray && indexPath.section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:indexPath.section];
        if(sectionSource.cellArray && indexPath.row < sectionSource.cellArray.count){
            YHTableCellDataSource *cellSource = [sectionSource.cellArray objectAtIndex:indexPath.row];
            [cellSource willDisplay:cell];
        }
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.sectionsArray && section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:section];
        return [sectionSource heightForHeaderInSection];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.sectionsArray && section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:section];
        return [sectionSource heightForFooterInSection];
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.sectionsArray && section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:section];
        return [sectionSource viewForHeaderInSection];
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.sectionsArray && section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:section];
        return [sectionSource viewForFooterInSection];
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sectionsArray && indexPath.section < self.sectionsArray.count) {
        YHTableSectionDataSource *sectionSource = [self.sectionsArray objectAtIndex:indexPath.section];
        if(sectionSource.cellArray && indexPath.row < sectionSource.cellArray.count){
            YHTableCellDataSource *cellSource = [sectionSource.cellArray objectAtIndex:indexPath.row];
            return [cellSource heightForCell];
        }
    }
    
    return kYHTableViewDefaultRowHeight;
}

@end
