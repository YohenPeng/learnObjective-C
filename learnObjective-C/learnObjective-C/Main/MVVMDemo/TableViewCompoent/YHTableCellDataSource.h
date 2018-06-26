//
//  YHTableCellDataSource.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHTableViewHelper.h"

@protocol YHTableCellDelegate <NSObject>

@required
-(CGFloat)heightForCell;
-(UITableViewCell *)cell:(UITableView*)tableView;

@optional
-(void)willDisplay:(UITableViewCell *)cell;

@end

@interface YHTableCellDataSource : NSObject<YHTableCellDelegate>

@property(weak,nonatomic)YHTableSectionDataSource *sectionDataSource;

@property(strong,nonatomic)NSIndexPath *indexPath;

-(void)refresh;

@end
