//
//  YHTestStackViewController.m
//  learnObjective-C
//
//  Created by peng yihan on 2018/5/28.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHTestStackViewController.h"
#import "Masonry.h"

@interface YHTestStackViewController ()
@property(strong,nonatomic)UIStackView *stackView;

@property(strong,nonatomic)UIView *colorBgView;
@end

@implementation YHTestStackViewController

#pragma mark -- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"测试StackView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.colorBgView];
    
    
    //UIStackView
    [self.view addSubview:self.stackView];
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.mas_equalTo(100);
        make.centerX.centerY.equalTo(self.view);
    }];
    
    [self.colorBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.stackView);
    }];
    
    
    UIView* itemView1 = [UIView new];
    itemView1.backgroundColor = [UIColor blueColor];
    [itemView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(80);
    }];
    [self.stackView addArrangedSubview:itemView1];
    
    UIView* itemView2 = [UIView new];
    itemView2.backgroundColor = [UIColor blueColor];
    [itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(50);
    }];
    [self.stackView addArrangedSubview:itemView2];
    
    UIView* itemView3 = [UIView new];
    itemView3.backgroundColor = [UIColor blueColor];
    [itemView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(95);
    }];
    [self.stackView addArrangedSubview:itemView3];
    
    if (@available(iOS 11.0, *)) {
        [self.stackView setCustomSpacing:5 afterView:itemView2];
    } else {
        // Fallback on earlier versions
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [itemView2 removeFromSuperview];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- lazy object
-(UIStackView*)stackView{
    if (!_stackView) {
        _stackView = [UIStackView new];
        _stackView.backgroundColor = [UIColor yellowColor];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentCenter;
        _stackView.distribution = UIStackViewDistributionFill;
        _stackView.spacing = 5;
    }
    return _stackView;
}

-(UIView *)colorBgView{
    if (!_colorBgView) {
        _colorBgView = [UIView new];
        _colorBgView.backgroundColor = [UIColor yellowColor];
    }
    return _colorBgView;
}



/* When items do not fit (overflow) or fill (underflow) the space available
 adjustments occur according to compressionResistance or hugging
 priorities of items, or when that is ambiguous, according to arrangement
 order.
 */
//UIStackViewDistributionFill = 0,

/* Items are all the same size.
 When space allows, this will be the size of the item with the largest
 intrinsicContentSize (along the axis of the stack).
 Overflow or underflow adjustments are distributed equally among the items.
 */
//UIStackViewDistributionFillEqually,

/* Overflow or underflow adjustments are distributed among the items proportional
 to their intrinsicContentSizes.
 */
//UIStackViewDistributionFillProportionally,

/* Additional underflow spacing is divided equally in the spaces between the items.
 Overflow squeezing is controlled by compressionResistance priorities followed by
 arrangement order.
 */
//UIStackViewDistributionEqualSpacing,

/* Equal center-to-center spacing of the items is maintained as much
 as possible while still maintaining a minimum edge-to-edge spacing within the
 allowed area.
 Additional underflow spacing is divided equally in the spacing. Overflow
 squeezing is distributed first according to compressionResistance priorities
 of items, then according to subview order while maintaining the configured
 (edge-to-edge) spacing as a minimum.
 */
//UIStackViewDistributionEqualCentering,




@end
