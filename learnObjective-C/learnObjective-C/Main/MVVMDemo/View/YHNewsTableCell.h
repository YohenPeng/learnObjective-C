//
//  YHNewsTableCell.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHNewsModel;

@interface YHNewsTableCell : UITableViewCell

+(NSString *)cellIdentifier;

+(void)registerToTableView:(UITableView *)tableView;

-(void)configure:(YHNewsModel *)model;

@end
