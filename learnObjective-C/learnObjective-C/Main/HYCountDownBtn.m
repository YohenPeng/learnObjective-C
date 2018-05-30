//
//  HYCountDownBtn.m
//  berry
//
//  Created by peng yihan on 2018/5/7.
//  Copyright © 2018年 com.huya.com. All rights reserved.
//

#import "HYCountDownBtn.h"

static NSString* const kCountDownNotification = @"kCountDownNotification";

@interface HYCountDownManager : NSObject
+(instancetype)shareManager;

-(void)fireBtnId:(NSInteger)btnId timerInterval:(NSTimeInterval)timerInterval;

@property(nonatomic,strong)NSMutableDictionary *idToIntervalDic;

@property(nonatomic,strong)NSTimer *timer;
@end


@implementation HYCountDownManager

+(instancetype)shareManager{
    static HYCountDownManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HYCountDownManager alloc]init];
    });
    return instance;
}

-(NSTimeInterval)intervalBeforeCanTouch:(NSInteger)btnId{
    if (![self.idToIntervalDic objectForKey:@(btnId)]) {
        return 0;
    }else{
        NSTimeInterval interval = [[self.idToIntervalDic objectForKey:@(btnId)] doubleValue];
        return interval;
    }
}

-(void)fireBtnId:(NSInteger)btnId timerInterval:(NSTimeInterval)timerInterval{
    if ([self.idToIntervalDic objectForKey:@(btnId)]) {
        
    }else{
        [self.idToIntervalDic setObject:[NSNumber numberWithDouble:timerInterval] forKey:@(btnId)];
        [self startTimer];
    }
}

-(void)startTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    __weak typeof(self) weakSelf = self;

    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        __strong typeof(self) strongSelf = weakSelf;
        BOOL isNeedStop = YES;
        NSMutableArray *needDelKeyArray = [NSMutableArray new];
        for (NSNumber *btnId in strongSelf.idToIntervalDic.allKeys) {
            NSTimeInterval interval = [[strongSelf.idToIntervalDic objectForKey:btnId] doubleValue];
            if (interval > 0) {
                isNeedStop = NO;
                [[NSNotificationCenter defaultCenter]postNotificationName:kCountDownNotification object:nil userInfo:@{@"btnId":btnId,@"interval":@(interval)}];
                [strongSelf.idToIntervalDic setObject:@(interval -1) forKey:btnId];
            }else{
                [needDelKeyArray addObject:btnId];
                [[NSNotificationCenter defaultCenter]postNotificationName:kCountDownNotification object:nil userInfo:@{@"btnId":btnId,@"interval":@(0)}];
            }
        }
        
        for (NSNumber *key in needDelKeyArray) {
            [strongSelf.idToIntervalDic removeObjectForKey:key];
        }
        
        if (isNeedStop) {
            [strongSelf endTimer];
        }
        
    }];
    
    
}


-(void)endTimer{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


-(NSMutableDictionary *)idToIntervalDic{
    if (!_idToIntervalDic) {
        _idToIntervalDic = [NSMutableDictionary new];
    }
    return _idToIntervalDic;
}

@end


@interface HYCountDownBtn ()
@property(assign,nonatomic)NSUInteger btnId;
@property(copy,nonatomic)NSString *tips;
@property(copy,nonatomic)HYCountDownBtnAction action;
@property(assign,nonatomic)NSTimeInterval interval;
@end



@implementation HYCountDownBtn

-(instancetype)initWithBtnId:(NSUInteger)btnId tips:(NSString *)tips timerInterval:(NSTimeInterval)interval action:(HYCountDownBtnAction)action{
    self = [super init];
    if (self) {
        self.btnId = btnId;
        self.tips = tips;
        self.interval = interval;
        self.action = action;
        [self setupSelf];
        [self addNotification];
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownAction:) name:kCountDownNotification object:nil];
}

-(void)countDownAction:(NSNotification *)notification{
    NSDictionary *dic = notification.userInfo;
    NSNumber *btnId = [dic objectForKey:@"btnId"];
    NSTimeInterval interval = [[dic objectForKey:@"interval"] doubleValue];
    
    if ([btnId integerValue] != self.btnId) {
        return;
    }
    
    if (interval == 0) {
        self.enabled = YES;
        [self setTitle:self.tips forState:UIControlStateNormal];
    }else{
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"%0.0fs",interval] forState:UIControlStateNormal];
    }
}


-(void)didMoveToWindow{
    [super didMoveToWindow];
    
    NSTimeInterval interval = [[HYCountDownManager shareManager] intervalBeforeCanTouch:self.btnId];
    if (interval) {
        self.enabled = NO;
        [self setTitle:[NSString stringWithFormat:@"%0.0fs",interval] forState:UIControlStateNormal];
    }else{
        self.enabled = YES;
        [self setTitle:self.tips forState:UIControlStateNormal];
    }
}

-(void)setupSelf{
    
    [self setBackgroundColor:[UIColor orangeColor]];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)btnAction:(id)sender{
    if (self.action) {
        if(YES == self.action()){
            [[HYCountDownManager shareManager]fireBtnId:self.btnId timerInterval:self.interval];
        }
    }
}


@end
