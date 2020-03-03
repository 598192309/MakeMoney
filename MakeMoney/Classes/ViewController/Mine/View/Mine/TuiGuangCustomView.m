//
//  TuiGuangCustomView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "TuiGuangCustomView.h"
#import "MineItem.h"
@interface TuiGuangCustomView()
//头部view
@property (nonatomic,strong)UIView *header;

@property (nonatomic,strong)UIView *moneyView;
@property (nonatomic,strong)UILabel *moneyTipLabel;
@property (nonatomic,strong)UILabel *moneyLabel;

@property (nonatomic,strong)UILabel *remainderTipLabel;//剩余总额
@property (nonatomic,strong)UILabel *remainderLabel;

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
- (void)configUIWithItem:(ExtendDetailItem *)item{
    self.moneyLabel.text = item.total_money;
    self.remainderLabel.text = item.balance;
    self.dailiLabel1.text = item.one_level;
    self.dailiLabel2.text = item.two_level;
    self.dailiLabel3.text = item.three_level;

}
#pragma mark - act
- (void)detailBtnClick:(UIButton *)sender{
    if (self.tuiGuangCustomViewCheckBtnClickBlock) {
        self.tuiGuangCustomViewCheckBtnClickBlock(sender,@{});
    }
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
        
        UIView *totalView = [UIView new];
        [_moneyView addSubview:totalView];
        [totalView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(weakSelf.moneyView);
        }];
        
        UIView *remindarView = [UIView new];
        [_moneyView addSubview:remindarView];
        [remindarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.mas_equalTo(weakSelf.moneyView);
            make.left.mas_equalTo(totalView.mas_right);
            make.width.mas_equalTo(totalView);
        }];
        
        _moneyTipLabel = [UILabel lableWithText:lqStrings(@"总收益(元)") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [totalView addSubview:_moneyTipLabel];
        [_moneyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(totalView.mas_centerY).offset(-Adaptor_Value(5));
            make.centerX.mas_equalTo(totalView);
        }];
        
        _moneyLabel = [UILabel lableWithText:lqStrings(@"--") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [totalView addSubview:_moneyLabel];
        [_moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(totalView.mas_centerY).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(totalView);
        }];
        
        _remainderTipLabel = [UILabel lableWithText:lqStrings(@"余额(元)") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [remindarView addSubview:_remainderTipLabel];
        [_remainderTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(remindarView.mas_centerY).offset(-Adaptor_Value(5));
            make.centerX.mas_equalTo(remindarView);
        }];
        
        _remainderLabel = [UILabel lableWithText:lqStrings(@"--") textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [remindarView addSubview:_remainderLabel];
        [_remainderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(remindarView.mas_centerY).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(remindarView);
        }];
        
        
        _dailiTipLabel = [UILabel lableWithText:lqStrings(@"推广人数统计") textColor:TitleWhiteColor fontSize:AdaptedBoldFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_dailiTipLabel];
        [_dailiTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.moneyView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.moneyView);
        }];
        
        _dailiView = [UIView new];
        _dailiView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_dailiView];
        [_dailiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(100));
            make.top.mas_equalTo(weakSelf.dailiTipLabel.mas_bottom).offset(Adaptor_Value(10));
        }];
        ViewRadius(_dailiView, 20);
        
        UIView *oneView = [UIView new];
        UIView *twoView = [UIView new];
        UIView *threeView = [UIView new];
        [_dailiView addSubview:oneView];
        [_dailiView addSubview:twoView];
        [_dailiView addSubview:threeView];
        
        [oneView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(weakSelf.dailiView);
        }];
        
        [twoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(oneView);
            make.left.mas_equalTo(oneView.mas_right);
        }];
        [threeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(oneView);
            make.left.mas_equalTo(twoView.mas_right);
            make.right.mas_equalTo(weakSelf.dailiView);
        }];

        _dailiTipLabel1 = [UILabel lableWithText:lqStrings(@"一级代理") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [oneView addSubview:_dailiTipLabel1];
        [_dailiTipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(oneView.mas_centerY).offset(-Adaptor_Value(5));
            make.centerX.mas_equalTo(oneView);

        }];
        
        _dailiLabel1 = [UILabel lableWithText:lqStrings(@"") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [oneView addSubview:_dailiLabel1];
        [_dailiLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(oneView.mas_centerY).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(oneView);

        }];
        
        _dailiTipLabel2 = [UILabel lableWithText:lqStrings(@"二级代理") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [twoView addSubview:_dailiTipLabel2];
        [_dailiTipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(twoView.mas_centerY).offset(-Adaptor_Value(5));
            make.centerX.mas_equalTo(twoView);

        }];
        
        _dailiLabel2 = [UILabel lableWithText:lqStrings(@"") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [twoView addSubview:_dailiLabel2];
        [_dailiLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(twoView.mas_centerY).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(twoView);

        }];
        
        _dailiTipLabel3 = [UILabel lableWithText:lqStrings(@"三级代理") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [threeView addSubview:_dailiTipLabel3];
        [_dailiTipLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(threeView.mas_centerY).offset(-Adaptor_Value(5));
            make.centerX.mas_equalTo(threeView);

        }];
        
        _dailiLabel3 = [UILabel lableWithText:lqStrings(@"") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [threeView addSubview:_dailiLabel3];
        [_dailiLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(threeView.mas_centerY).offset(Adaptor_Value(5));
            make.centerX.mas_equalTo(threeView);

        }];
        
        

      
        _ruleTipLable = [UILabel lableWithText:lqStrings(@"推广规则") textColor:TitleWhiteColor fontSize:AdaptedBoldFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_ruleTipLable];
        [_ruleTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.dailiView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.dailiView);
        }];
        
        _ruleView = [UIView new];
        _ruleView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_ruleView];
        [_ruleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.top.mas_equalTo(weakSelf.ruleTipLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        ViewRadius(_ruleView, 20);
        
        _ruleLable = [UILabel lableWithText:lqStrings(@"新用户通过邀请链接下载安装APP后,即可绑定推荐关系,用户每一次消费,您都可以获得返利。好友奖励分成如下:") textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [_ruleView addSubview:_ruleLable];
        [_ruleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(20));
            make.left.mas_equalTo(Adaptor_Value(20));
            make.right.mas_equalTo(weakSelf.ruleView).offset(-Adaptor_Value(20));
        }];
        
        _ruleImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"invite_img"]];
        _ruleImageV.contentMode = UIViewContentModeScaleAspectFill;
        [_ruleView addSubview:_ruleImageV];
        [_ruleImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.ruleLable.mas_bottom).offset(Adaptor_Value(20));
            make.right.left.mas_equalTo(weakSelf.ruleLable);
            make.height.mas_equalTo(Adaptor_Value(220));
            make.bottom.mas_equalTo(weakSelf.ruleView.mas_bottom).offset(-Adaptor_Value(20));
        }];
        
        
        _detailTipLable = [UILabel lableWithText:lqStrings(@"收益明细") textColor:TitleWhiteColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_detailTipLable];
        [_detailTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.ruleView.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(weakSelf.ruleView);
        }];
        
        _detailBtn = [[UIButton alloc] init];
        [_detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _detailBtn.backgroundColor = TitleWhiteColor;
        [_detailBtn setTitle:lqStrings(@"查看明细") forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = AdaptedBoldFontSize(18);
        [contentV addSubview:_detailBtn];
        [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(50));
            make.top.mas_equalTo(weakSelf.detailTipLable.mas_bottom).offset(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(30));
        }];
        ViewRadius(_detailBtn, 10);
    }
    return _header;
}


@end
