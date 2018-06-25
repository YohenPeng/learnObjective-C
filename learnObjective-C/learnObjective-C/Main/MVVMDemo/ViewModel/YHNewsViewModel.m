//
//  YHNewsViewModel.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/6/25.
//  Copyright © 2018 peng yihan. All rights reserved.
//

#import "YHNewsViewModel.h"
#import "YHNewsModel.h"

@implementation YHNewsViewModel

-(void)requestNews:(RequestNewsComplete)complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(10);
        
        YHNewsModel* model1 = [YHNewsModel initWithTitle:@"测试标题1" content:@"测试内容1"];
        YHNewsModel* model2 = [YHNewsModel initWithTitle:@"测试标题2" content:@"测试内容2"];
        self.newsModelList = @[model1,model2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(nil);
            }
        });
        
    });
}


@end
