//
//  TuiGuangCustomView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "TuiGuangCustomView.h"

@interface TuiGuangCustomView()
//头部view
@property (nonatomic,strong)UIView *header;

@property (nonatomic,strong)UIView *moneyView;
@property (nonatomic,strong)UILabel *moneyTipLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

@property (nonatomic,strong)UILabel *dailiTipLabel;
@property (nonatomic,strong)UIView *dailiView;
@property (nonatomic,strong)UILabel *dailiTipLabel1;
@property (nonatomic,strong)UILabel *dailiLabel1;
@property (nonatomic,strong)UILabel *dailiTipLabel2;
@property (nonatomic,strong)UILabel *dailiLabel2;
@property (nonatomic,strong)UILabel *dailiTipLabel3;
@property (nonatomic,strong)UILabel *dailiLabel3;

@property (nonatomic,strong)UILabel *ruleTipLable;
@property (nonatomic,strong)UIView *ruleView;
@property (nonatomic,strong)UILabel *ruleLable;
@property (nonatomic,strong)UIImageView *ruleImageV;

@property (nonatomic,strong)UILabel *detailTipLable;
@property (nonatomic,strong)UIButton *detailBtn;


@end
@implementation TuiGuangCustomView

#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    __weak __typeof(self) weakSelf = self;

    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    

}

#pragma mark - 刷新ui
#pragma mark - act
- (void)detailBtnClick:(UIButton *)sender{

}


#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _moneyView = [UIView new];
        _moneyView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_moneyView];
        [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(100));
            make.top.mas_equalTo(Adaptor_Value(20));
        }];
        ViewRadius(_moneyView, 20);
        
        _moneyTipLabel = [UILabel lableWithText:lqStrings(@"账户余额(元)") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_moneyView addSubview:_moneyTipLabel];
        [_moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(25));
            make.left.mas_equalTo(Adaptor_Value(25));
        }];
        
        _moneyLabel = [UILabel lableWithText:lqStrings(@"0") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_moneyView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyTipLabel.mas_bottom).offset(Adaptor_Value(10));
            make.left.mas_equalTo(weakSelf.moneyTipLabel);
        }];
        
      
        
    }
    return _header;
}


@end
