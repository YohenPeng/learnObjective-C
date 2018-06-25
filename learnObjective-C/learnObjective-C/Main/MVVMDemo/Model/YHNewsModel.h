//
//  YHNewsModel.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHNewsModel : NSObject

+(instancetype)initWithTitle:(NSString *)title content:(NSString *)content;

@property(copy,nonatomic,readonly)NSString *title;
@property(copy,nonatomic,readonly)NSString *content;

@end
