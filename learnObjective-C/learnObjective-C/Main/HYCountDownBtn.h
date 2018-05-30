//
//  HYCountDownBtn.h
//  berry
//
//  Created by peng yihan on 2018/5/7.
//  Copyright © 2018年 com.huya.com. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef BOOL(^HYCountDownBtnAction)(void);

@interface HYCountDownBtn : UIButton

-(instancetype)initWithBtnId:(NSUInteger)btnId tips:(NSString *)tips timerInterval:(NSTimeInterval)interval action:(HYCountDownBtnAction)action;

@end
