//
//  YHNewsCell.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsCellElement.h"
#import "YHNewsTableCell.h"

@interface YHNewsCellElement ()
@end

@implementation YHNewsCellElement

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
    cell.textLabel.text = self.myText;
}


@end
