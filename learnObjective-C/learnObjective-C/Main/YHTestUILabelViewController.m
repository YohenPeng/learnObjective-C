//
//  YHTestUILabelViewController.m
//  learnObjective-C
//
//  Created by pengehan on 2018/5/1.
//  Copyright © 2018年 peng yihan. All rights reserved.
//

#import "YHTestUILabelViewController.h"

#import "YHTableView.h"
#import "YHBaseTableViewModel.h"

static NSString* kCellId = @"kHYTestUILabelCellId";

@interface HYUILabelCellModel : NSObject

@property(assign,nonatomic)CGFloat cellHeight;

@property(nonatomic,strong)NSNumber* height;

@property(nonatomic,strong)NSAttributedString *attributedString;

@end



@implementation HYUILabelCellModel

-(CGFloat)cellHeight{
    if (self.height) {
        return [self.height floatValue];
    }
    
    [self layoutIfNeed];
    return [self.height floatValue];
}

-(void)layoutIfNeed{
    if (self.height) {
        return;
    }
    
    CGRect rect = [self.attributedString boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    self.height = @(rect.size.height);
}


@end


@interface HYTestUILabelCell : UITableViewCell

@property(nonatomic,strong)UILabel *uiLabel;

@end


@implementation HYTestUILabelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupContentView];
    }
    return self;
}

-(void)setupContentView{
    self.uiLabel = [UILabel new];
    self.uiLabel.numberOfLines = 0;
    [self.contentView addSubview:self.uiLabel];
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.uiLabel.frame = self.contentView.bounds;
}

@end

@interface YHTestUILabelViewController ()
@property(nonatomic,strong)YHTableView *tableView;
@property(nonatomic,strong)YHBaseTableViewModel *tableViewModel;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation YHTestUILabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
    for (int i = 0; i < 1000; i++) {
        HYUILabelCellModel *model = [HYUILabelCellModel new];
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"性能测试性能测试性能测试性能测试性能测试性能测试性能性能测试性能测试性能测试性能测试性能测试性能测试性能 index:%d",i]];
 
//        NSTextAttachment *attach = [NSTextAttachment new];
//        attach.image = [UIImage imageNamed:@"qq"];
//        attach.bounds = CGRectMake(0, 0, 20, 20);
//
//        for (int j = 0; j < i % 10; j++) {
//            [mutableString appendAttributedString:[NSAttributedString attributedStringWithAttachment:attach]];
//        }
        
        [mutableString appendAttributedString:[[NSAttributedString alloc] initWithString:@"test"]];
        [mutableString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:[mutableString.string rangeOfString:mutableString.string]];
        [mutableString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[mutableString.string rangeOfString:mutableString.string]];
        model.attributedString = mutableString;
        [self.dataArray addObject:model];
    }
    
    self.title = @"测试UILabel";
    [self.view addSubview:self.tableView];
    [self.tableViewModel reload];
    
    
}


-(YHTableView *)tableView{
    if (!_tableView) {
        _tableView = [[YHTableView alloc]initWithFrame:self.view.frame];
        [_tableView registerClass:[HYTestUILabelCell class] forCellReuseIdentifier:kCellId];
    }
    return _tableView;
}

-(YHBaseTableViewModel *)tableViewModel{
    if (!_tableViewModel) {
        _tableViewModel = [[YHBaseTableViewModel alloc]initWithTable:self.tableView];
        typeof(self) __weak weakSelf = self;
        
        
        [_tableViewModel setupCellForRowAtIndexPath:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
            typeof(self) __strong strongSelf = weakSelf;
            HYTestUILabelCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellId];
            if (!cell) {
                cell = [[HYTestUILabelCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellId];
            }
            
            HYUILabelCellModel *model = [strongSelf.dataArray objectAtIndex:indexPath.row];
//            [model layoutIfNeed];
            cell.uiLabel.attributedText = model.attributedString;
            return cell;
            
        }];
        
        [_tableViewModel setupHeightForRowAtIndexPath:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
            typeof(self) __strong strongSelf = weakSelf;
            HYUILabelCellModel *model = [strongSelf.dataArray objectAtIndex:indexPath.row];

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
