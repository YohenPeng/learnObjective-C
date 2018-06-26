//
//  YHTableViewHelper.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YHTableViewHelperDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(UIView*)tableHeaderView;
-(UIView*)tableFooterView;

@end


@class YHTableSectionDataSource;

@interface YHTableViewHelper : NSObject

@property(strong,nonatomic,readonly)NSArray<YHTableSectionDataSource *> *sectionArray;

@property(weak,nonatomic,readonly)UITableView *tableView;

-(instancetype)initWithTableView:(UITableView *)tableView sections:(NSArray<YHTableSectionDataSource *> *)sectionsArray;

-(BOOL)addSection:(YHTableSectionDataSource *)section;

-(BOOL)addSection:(YHTableSectionDataSource *)section immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation;

-(BOOL)removeSection:(YHTableSectionDataSource *)section;

-(BOOL)removeSection:(YHTableSectionDataSource *)section immediate:(BOOL)isImmediate animation:(UITableViewRowAnimation)animation;

-(BOOL)refresh;

@property(assign,nonatomic)id<YHTableViewHelperDelegate> delegate;

@end
