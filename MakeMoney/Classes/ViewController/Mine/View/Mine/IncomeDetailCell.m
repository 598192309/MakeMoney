//
//  IncomeDetailCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "IncomeDetailCell.h"
#import "MineItem.h"

@interface IncomeDetailCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLable1;
@property (strong, nonatomic)  UILabel *titleLable2;
@property (strong, nonatomic)  UILabel *titleLable3;
@property (strong, nonatomic)  UILabel *titleLable4;


@end
@implementation IncomeDetailCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.mas_equalTo(self.contentView);
    }];
   
}

- (void)configUIWithItem:(ExtendDetailItem *)item{
    self.titleLable1.text = [NSString stringWithFormat:lqLocalized(@"1级好友%@", nil),item.invite_code];
    self.titleLable2.text = item.money;
    self.titleLable3.text = item.reward;
    self.titleLable3.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];

    
}
#pragma mark - act

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor clearColor];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];
        contentV.backgroundColor = [UIColor clearColor];

        _titleLable1 = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLable1];
        [_titleLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(30));
        }];
        
        _titleLable2 = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLable2];
        [_titleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.bottom.mas_equalTo(weakSelf.titleLable1);
            make.left.mas_equalTo(weakSelf.titleLable1.mas_right);
        }];
        
        _titleLable3 = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLable3];
        [_titleLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.bottom.mas_equalTo(weakSelf.titleLable1);
            make.left.mas_equalTo(weakSelf.titleLable2.mas_right);
        }];
        
        _titleLable4 = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLable4];
        [_titleLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.top.bottom.mas_equalTo(weakSelf.titleLable1);
            make.left.mas_equalTo(weakSelf.titleLable3.mas_right);
            make.right.mas_equalTo(contentV);
        }];
        
    }
    return _cellBackgroundView;
}
@end
