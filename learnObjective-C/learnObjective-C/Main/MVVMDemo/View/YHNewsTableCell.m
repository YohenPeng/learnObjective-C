//
//  YHNewsTableCell.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsTableCell.h"
#import "YHNewsModel.h"


@implementation YHNewsTableCell


-(void)configure:(YHNewsModel *)model{
    self.textLabel.text = [NSString stringWithFormat:@"%@:%@",model.title,model.content];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
