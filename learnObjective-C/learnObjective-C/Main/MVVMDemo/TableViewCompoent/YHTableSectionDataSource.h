//
//  YHTableSectionDataSource.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YHTableViewHelper.h"

@protocol YHTableViewSectionDelegate <NSObject>

- (CGFloat)heightForHeaderInSection;
- (CGFloat)heightForFooterInSection;
- (nullable UIView *)viewForHeaderInSection;
- (nullable UIView *)viewForFooterInSection;

@end

@class YHTableCellDataSource;

@interface YHTableSectionDataSource : NSObject<YHTableViewSectionDelegate>

@property(weak,nonatomic)YHTableViewHelper *helper;

@property(strong,nonatomic,readonly)NSArray<YHTableCellDataSource *> *cellArray;

-(instancetype)initWithCells:(NSArray<YHTableCellDataSource *> *)cellArrays;

-(BOOL)addCell:(YHTableCellDataSource *)cell;

-(BOOL)addCell:(YHTableCellDataSource *)cell immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation;

-(BOOL)removeCell:(YHTableCellDataSource *)cell;

-(BOOL)removeCell:(YHTableCellDataSource *)cell immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation;

-(BOOL)refresh;

@end
