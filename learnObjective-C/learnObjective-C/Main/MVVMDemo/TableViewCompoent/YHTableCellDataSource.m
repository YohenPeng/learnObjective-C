//
//  YHTableCellDataSource.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHTableCellDataSource.h"
#import "YHTableSectionDataSource.h"

static CGFloat const kYHRowDefaultHeight = 44;

@implementation YHTableCellDataSource

-(NSIndexPath*)indexPath{
    NSInteger sectionIndex = [self.sectionDataSource.helper.sectionArray indexOfObject:self.sectionDataSource];
    NSInteger rowIndex = [self.sectionDataSource.cellArray indexOfObject:self];
    return [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
}

-(void)refresh{
    NSInteger sectionIndex = [self.sectionDataSource.helper.sectionArray indexOfObject:self.sectionDataSource];
    NSInteger rowIndex = [self.sectionDataSource.cellArray indexOfObject:self];
    [self.sectionDataSource.helper.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -- YHTableCellDelegate
- (CGFloat)heightForCell{
    return kYHRowDefaultHeight;
}

-(UITableViewCell *)cell:(UITableView *)tableView{
    //subclass imp
    return nil;
}

-(void)willDisplay:(UITableViewCell *)cell{
    //subclass imp
}



@end
