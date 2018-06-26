//
//  YHTableSectionDataSource.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHTableSectionDataSource.h"
#import "YHTableCellDataSource.h"

static CGFloat const kHYSectionDefaultHeaderHeight = 0;
static CGFloat const kHYSectionDefaultFooterHeight = 0;


@interface YHTableSectionDataSource ()
@property(strong,nonatomic)NSMutableArray<YHTableCellDataSource *> *mutableCellArray;
@property(strong,nonatomic)NSArray<YHTableCellDataSource *> *cellArray;
@end

@implementation YHTableSectionDataSource

#pragma mark -- life cycle
-(instancetype)initWithCells:(NSArray<YHTableCellDataSource *> *)cellArrays{
    self = [super init];
    if (self) {
        self.mutableCellArray = [NSMutableArray arrayWithArray:cellArrays];
        for (YHTableCellDataSource *source in self.mutableCellArray) {
            source.sectionDataSource = self;
        }
    }
    return self;
}

#pragma mark -- pulish method
-(BOOL)addCell:(YHTableCellDataSource *)cell{
    
    cell.sectionDataSource = self;
    if (NSNotFound == [self.mutableCellArray indexOfObject:cell]) {
        [self.mutableCellArray addObject:cell];
        self.cellArray = [NSArray arrayWithArray:self.mutableCellArray];
        return YES;
    }
    return NO;
}

-(BOOL)addCell:(YHTableCellDataSource *)cell immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation{
    
    if([self addCell:cell]){
        if (NO == isImmediate) {
            return YES;
        }
        NSInteger sectionIndex = [self.helper.sectionArray indexOfObject:self];
        NSInteger rowIndex = [self.cellArray indexOfObject:cell];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
        [self.helper.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        return YES;
    }
    return NO;

}

-(BOOL)removeCell:(YHTableCellDataSource *)cell{
    if (NSNotFound != [self.cellArray indexOfObject:cell]) {
        [self.mutableCellArray removeObject:cell];
        self.cellArray = [NSArray arrayWithArray:self.mutableCellArray];
        return YES;
    }
    return NO;
}

-(BOOL)removeCell:(YHTableCellDataSource *)cell immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation{
    NSInteger rowIndex = [self.cellArray indexOfObject:cell];
    if([self removeCell:cell]){
        if (NO == isImmediate) {
            return YES;
        }
        NSInteger sectionIndex = [self.helper.sectionArray indexOfObject:self];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
        [self.helper.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        return YES;
    }
    return NO;
}

-(BOOL)refresh{
    NSInteger sectionIndex = [self.helper.sectionArray indexOfObject:self];
    [self.helper.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
    return YES;
}

#pragma mark -- YHTableViewSectionDelegate
- (CGFloat)heightForHeaderInSection{
    //subclass imp
    return kHYSectionDefaultHeaderHeight;
}

- (CGFloat)heightForFooterInSection{
    //subclass imp
    return kHYSectionDefaultFooterHeight;
}

- (nullable UIView *)viewForHeaderInSection{
    //subclass imp
    return nil;
}

- (nullable UIView *)viewForFooterInSection{
    //subclass imp
    return nil;
}

@end
