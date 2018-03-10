//
//  YHBaseTableViewModel.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/3/9.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NSInteger(^YHNumberOfRowsInSection)(UITableView *tableView,NSInteger section);
typedef UITableViewCell *(^YHCellForRowAtIndexPath)(UITableView *tableView,NSIndexPath* indexPath);
typedef void(^YHDidSelectRowAtIndexPath)(UITableView *tableView,NSIndexPath* indexPath);

@interface YHBaseTableViewModel : NSObject

-(instancetype)initWithTable:(UITableView *)tableView;

-(void)setupNumberOfRowsInSection:(YHNumberOfRowsInSection)block;

-(void)setupCellForRowAtIndexPath:(YHCellForRowAtIndexPath)block;

-(void)setupDidSelectRowAtIndexPath:(YHDidSelectRowAtIndexPath)block;

-(void)reload;


@end
