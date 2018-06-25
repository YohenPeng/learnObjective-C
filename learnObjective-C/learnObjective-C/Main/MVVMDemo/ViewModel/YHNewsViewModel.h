//
//  YHNewsViewModel.h
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestNewsComplete)(NSError *error);

@class YHNewsModel;
@interface YHNewsViewModel : NSObject

@property(strong,nonatomic)NSArray<YHNewsModel *> *newsModelList;

-(void)requestNews:(RequestNewsComplete)complete;

@end
