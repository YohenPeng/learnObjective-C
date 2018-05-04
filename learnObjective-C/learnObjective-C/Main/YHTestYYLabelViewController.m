//
//  YHTestYYLabelViewController.m
//  learnObjective-C
//
//  Created by pengehan on 2018/5/1.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHTestYYLabelViewController.h"
#import <YYKit.h>
#import "YHTableView.h"
#import "YHBaseTableViewModel.h"
#import <NSAttributedString+YYText.h>


static NSString* kCellId = @"kHYTestYYLabelCellId";

@interface HYCellModel : NSObject

@property(assign,nonatomic)CGFloat cellHeight;

@property(nonatomic,strong)YYTextLayout *layout;

@property(nonatomic,strong)NSAttributedString *attributedString;

@end



@implementation HYCellModel

-(CGFloat)cellHeight{
    if (self.layout) {
        return self.layout.textBoundingSize.height;
    }
    
    [self layoutIfNeed];
    return self.layout.textBoundingSize.height;
}

-(void)layoutIfNeed{
    if (self.layout) {
        return;
    }
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) text:self.attributedString];
    self.layout = layout;
}


@end


@interface HYTestYYLabelCell : UITableViewCell

@property(nonatomic,strong)YYLabel *yyLabel;

-(void)setupTextLayout:(YYTextLayout *)layout;

@end


@implementation HYTestYYLabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}

-(void)setupContentView{
    self.yyLabel = [YYLabel new];
    self.yyLabel.displaysAsynchronously = YES;
    [self.contentView addSubview:self.yyLabel];
}

-(void)setupTextLayout:(YYTextLayout *)layout{
    self.yyLabel.textLayout = layout;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.yyLabel.frame = self.contentView.bounds;
}

@end


@interface YHTestYYLabelViewController ()
@property(nonatomic,strong)YHTableView *tableView;
@property(nonatomic,strong)YHBaseTableViewModel *tableViewModel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation YHTestYYLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 1000; i++) {
        HYCellModel *model = [HYCellModel new];
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"性能测试性能测试性能测试性能测试性能测试性能测试性能性能测试性能测试性能测试性能测试性能测试性能测试性能 index:%d",i]];
        [mutableString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[mutableString.string rangeOfString:mutableString.string]];
        [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[mutableString.string rangeOfString:mutableString.string]];
        
        
//        NSTextAttachment *attach = [NSTextAttachment new];
//        attach.image = [UIImage imageNamed:@"qq"];
//        attach.bounds = CGRectMake(0, 0, 20, 20);
//
//        for (int j = 0; j < i % 10; j++) {
//            NSMutableAttributedString *attachImage = [NSMutableAttributedString attachmentStringWithContent:[UIImage imageNamed:@"qq"] contentMode:UIViewContentModeScaleToFill attachmentSize:CGSizeMake(20, 20) alignToFont:[UIFont systemFontOfSize:16] alignment:YYTextVerticalAlignmentCenter];
//            [mutableString appendAttributedString:attachImage];
//        }
        
        [mutableString appendAttributedString:[[NSAttributedString alloc] initWithString:@"test"]];
        
        model.attributedString = mutableString;
        [self.dataArray addObject:model];
    }
    
    self.title = @"测试YYLabel";
    [self.view addSubview:self.tableView];
    [self.tableViewModel reload];
    
    
}


-(YHTableView *)tableView{
    if (!_tableView) {
        _tableView = [[YHTableView alloc]initWithFrame:self.view.frame];
        [_tableView registerClass:[HYTestYYLabelCell class] forCellReuseIdentifier:kCellId];
    }
    return _tableView;
}

-(YHBaseTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel = [[YHBaseTableViewModel alloc]initWithTable:self.tableView];
        typeof(self) __weak weakSelf = self;
        
        
        [_tableViewModel setupCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            typeof(self) __strong strongSelf = weakSelf;
            HYTestYYLabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
            if (!cell) {
                cell = [[HYTestYYLabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
            }
            
            HYCellModel *model = [strongSelf.dataArray objectAtIndex:indexPath.row];
            [model layoutIfNeed];
            [cell setupTextLayout:model.layout];
            return cell;
            
        }];
        
        [_tableViewModel setupHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            typeof(self) __strong strongSelf = weakSelf;
            HYCellModel *model = [strongSelf.dataArray objectAtIndex:indexPath.row];
            return model.cellHeight;
        }];
        
        [_tableViewModel setupNumberOfRowsInSection:^NSInteger(UITableView *tableView, NSInteger section) {
            typeof(self) __strong strongSelf = weakSelf;
            return strongSelf.dataArray.count;
        }];
        
        [_tableViewModel setupDidSelectRowAtIndexPath:^(UITableView *tableView, NSIndexPath *indexPath) {
           
        }];
        
    }
    
    return _tableViewModel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
