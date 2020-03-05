//
//  RechargeDetailCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "RechargeDetailCell.h"

@interface RechargeDetailCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *orderLabel;
@property (strong, nonatomic)  UILabel *vipLable;
@property (strong, nonatomic)  EnlargeTouchSizeButton *orderBtn;
@property (strong, nonatomic)  UILabel *moneyLable;
@property (strong, nonatomic)  UILabel *timeLable;

@end
@implementation RechargeDetailCell

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

        _orderLabel = [UILabel lableWithText:lqLocalized(@"订单编号:",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_orderLabel];
        [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        
        
        _vipLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_vipLable];
        [_vipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.orderLabel);
            make.top.mas_equalTo(weakSelf.orderLabel.mas_bottom).offset(Adaptor_Value(25));
        }];
        
        _timeLable = [UILabel lableWithText:lqLocalized(@"   ",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.orderLabel);
            make.top.mas_equalTo(weakSelf.vipLable.mas_bottom).offset(Adaptor_Value(25));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
        
        
        _orderBtn = [[EnlargeTouchSizeButton alloc ] init];
       [_orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_orderBtn setTitle:lqStrings(@"复制订单号") forState:UIControlStateNormal];
        [_orderBtn setTitleColor:TitleGrayColor forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = AdaptedFontSize(12);
       [contentV addSubview:_orderBtn];
       [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
           make.top.mas_equalTo(Adaptor_Value(20));
       }];
        
        _moneyLable = [UILabel lableWithText:lqLocalized(@"  ",nil) textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyLable];
        [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(weakSelf.orderBtn.mas_bottom).offset(Adaptor_Value(20));
        }];


      
        
        
    }
    return _cellBackgroundView;
}
@end
