//
//  TixianDetailCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "TixianDetailCell.h"

@interface TixianDetailCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *typeLabel;
@property (strong, nonatomic)  UILabel *feeLable;
@property (strong, nonatomic)  UILabel *detailLable;
@property (strong, nonatomic)  UILabel *tixianLable;
@property (strong, nonatomic)  UILabel *daozhangLable;
@property (strong, nonatomic)  UILabel *timeLable;
@property (strong, nonatomic)  UILabel *statusLable;

@end
@implementation TixianDetailCell

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

- (void)configUIWithItem:(NSObject *)item{
    self.typeLabel.text = [NSString stringWithFormat:lqLocalized(@"提现类型：%@", nil),item];
    self.feeLable.text = [NSString stringWithFormat:lqLocalized(@"手续费：%@", nil),item];
    self.detailLable.text = [NSString stringWithFormat:@"%@       %@",item,item];
    self.tixianLable.text = [NSString stringWithFormat:lqLocalized(@"提现：%@", nil),item];
    self.daozhangLable.text = [NSString stringWithFormat:lqLocalized(@"到账：%@", nil),item];
    self.timeLable.text = @"2012-12-12";
    self.statusLable.text = @"已放款";
    
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
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(5));
        }];
        contentV.backgroundColor = TitleWhiteColor;
        ViewRadius(contentV, 10);

        _typeLabel = [UILabel lableWithText:lqLocalized(@"提现类型:",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_typeLabel];
        [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        
        
        _feeLable = [UILabel lableWithText:lqLocalized(@"手续费:",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_feeLable];
        [_feeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.typeLabel.mas_right).offset(Adaptor_Value(80));
            make.centerY.mas_equalTo(weakSelf.typeLabel);
        }];
        
        _statusLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:CustomRedColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_statusLable];
        [_statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(weakSelf.typeLabel);
        }];
        
        _detailLable = [UILabel lableWithText:lqLocalized(@"  ",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_detailLable];
        [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.typeLabel);
            make.top.mas_equalTo(weakSelf.typeLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        _tixianLable = [UILabel lableWithText:lqLocalized(@"  ",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tixianLable];
        [_tixianLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.typeLabel);
            make.top.mas_equalTo(weakSelf.detailLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        
        _daozhangLable = [UILabel lableWithText:lqLocalized(@"  ",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_daozhangLable];
        [_daozhangLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.tixianLable);
            make.left.mas_equalTo(weakSelf.feeLable);
        }];

        _timeLable = [UILabel lableWithText:lqLocalized(@"   ",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.typeLabel);
            make.top.mas_equalTo(weakSelf.tixianLable.mas_bottom).offset(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
        
      
        
        
    }
    return _cellBackgroundView;
}
@end
