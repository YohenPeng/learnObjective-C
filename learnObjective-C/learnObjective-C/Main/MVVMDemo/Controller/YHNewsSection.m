//
//  YHNewsSection.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/26.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsSection.h"

@implementation YHNewsSection

- (CGFloat)heightForHeaderInSection{
    return 40;
}

- (CGFloat)heightForFooterInSection{
    return 40;
}

- (nullable UIView *)viewForHeaderInSection{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), [self heightForHeaderInSection])];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (nullable UIView *)viewForFooterInSection{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), [self heightForFooterInSection])];
    view.backgroundColor = [UIColor blueColor];
    return view;
}

@end
