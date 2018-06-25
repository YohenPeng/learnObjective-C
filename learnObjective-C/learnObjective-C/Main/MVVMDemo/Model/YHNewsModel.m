//
//  YHNewsModel.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsModel.h"

@interface YHNewsModel ()

@property(copy,nonatomic,readwrite)NSString *title;
@property(copy,nonatomic,readwrite)NSString *content;

@end

@implementation YHNewsModel

+(instancetype)initWithTitle:(NSString *)title content:(NSString *)content{
    YHNewsModel *model = [[YHNewsModel alloc]init];
    model.title = title;
    model.content = content;
    return model;
}

@end
