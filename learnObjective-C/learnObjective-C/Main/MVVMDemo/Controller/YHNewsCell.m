//
//  YHNewsCell.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsCell.h"
#import "YHNewsTableCell.h"

@interface YHNewsCell ()
@property(copy,nonatomic)NSString *myString;
@end

@implementation YHNewsCell

-(CGFloat)heightForCell{
    return 40;
}

-(UITableViewCell *)cell:(UITableView* )tableView{
    YHNewsTableCell* cell = [tableView dequeueReusableCellWithIdentifier:[YHNewsTableCell cellIdentifier]];
    if (!cell) {
        cell = [[YHNewsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[YHNewsTableCell cellIdentifier]];
    }
    return cell;
}

-(void)willDisplay:(UITableViewCell *)tableViewCell{
    YHNewsTableCell *cell = (YHNewsTableCell *)tableViewCell;
    cell.textLabel.text = self.myString;
}

-(void)setMyText:(NSString *)string{
    self.myString = string;
}

@end
