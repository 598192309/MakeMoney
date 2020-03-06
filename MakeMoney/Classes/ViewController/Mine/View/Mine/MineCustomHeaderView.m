//
//  MineCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/30.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "MineCustomHeaderView.h"
#import "LPButton.h"
#import "MineItem.h"

@interface MineCustomHeaderView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *iDLable;
@property (nonatomic,strong)UILabel *vipTipLable;

@property (nonatomic,strong)UILabel *vipLable;
@property (nonatomic,strong)UIImageView *iconImageV;
@property (nonatomic,strong)UIImageView *vipImageV;


@property (nonatomic,strong)UILabel *timesLable;


@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)LPButton *yaoqingBtn;
@property (nonatomic,strong)LPButton *chongzhiBtn;
@property (nonatomic,strong)LPButton *qianbaoBtn;
@property (nonatomic,strong)LPButton *tuiguangBtn;
@property (nonatomic,strong)LPButton *vipBtn;


@end
@implementation MineCustomHeaderView
#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weakSelf);
    }];
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(InitItem *)item finishi:(void(^)(void))finishBlock{
    NSString *str = [NSString stringWithFormat:lqLocalized(@"每日观看次数 %ld/%ld", nil),item.rest_free_times,item.max_free_times];
    //字体局部变色
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:str];
    if (str.length > 0) {
        NSRange start  = [str rangeOfString:lqStrings(@"次数 ")];
        NSRange end  = [str rangeOfString:lqStrings(@"/")];
        if (start.length > 0 && end.length > 0) {
            NSRange rangel = NSMakeRange(start.location + start.length , end.location - start.location- start.length );
            [attr addAttribute:NSForegroundColorAttributeName value:CustomRedColor range:rangel];
        }
    }
    self.timesLable.attributedText = attr;
    
    self.vipLable.text = item.is_qm_vip ? item.qm_vip_end_time:lqStrings(@"未开通");
    
    finishBlock();
}

- (void)setAvter:(UIImage *)image{
    self.iconImageV.image = image;
}
#pragma mark - act
- (void)viewTap:(UIGestureRecognizer *)gest{
    if (self.mineCustomHeaderViewBlock) {
        self.mineCustomHeaderViewBlock(nil);
    }
}

- (void)yaoqingBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.mineCustomHeaderViewBtnsBlock) {
        self.mineCustomHeaderViewBtnsBlock(sender,@{});
    }
}

- (void)chongzhiBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.mineCustomHeaderViewBtnsBlock) {
        self.mineCustomHeaderViewBtnsBlock(sender,@{});
    }
}

- (void)qianbaoBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.mineCustomHeaderViewBtnsBlock) {
        self.mineCustomHeaderViewBtnsBlock(sender,@{});
    }
}
- (void)tuiguangBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.mineCustomHeaderViewBtnsBlock) {
        self.mineCustomHeaderViewBtnsBlock(sender,@{});
    }
}
- (void)vipBtnClick:(UIButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.mineCustomHeaderViewBtnsBlock) {
        self.mineCustomHeaderViewBtnsBlock(sender,@{});
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
            make.height.mas_equalTo(TopAdaptor_Value(150));
        }];
        
        _iconImageV = [[UIImageView alloc] init];
        [_iconImageV sd_setImageWithURL:[NSURL URLWithString:RI.infoInitItem.avatar] placeholderImage:[UIImage imageNamed:@"avatar"]];
        [contentV addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.height.width.mas_equalTo(Adaptor_Value(80));
            make.top.mas_equalTo(TopAdaptor_Value(40));
        }];
        ViewRadius(_iconImageV, Adaptor_Value(40));

        _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [_iconImageV addGestureRecognizer:tap];
        
        NSString *imageName;
        if (RI.infoInitItem.vip_level == 0) {
            imageName = @"icon_vip_0";
        }else if (RI.infoInitItem.vip_level == 1) {
            imageName = @"icon_vip_1";
        }else if (RI.infoInitItem.vip_level == 2) {
            imageName = @"icon_vip_2";
        }else if (RI.infoInitItem.vip_level == 3) {
            imageName = @"icon_vip_3";
        }
        _vipImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        [contentV addSubview:_vipImageV];
        [_vipImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(30));
            make.width.mas_equalTo(Adaptor_Value(60));
            make.centerY.mas_equalTo(weakSelf.iconImageV.mas_bottom);
            make.centerX.mas_equalTo(weakSelf.iconImageV);
        }];


        _nameLabel = [UILabel lableWithText:RI.infoInitItem.username.length > 0 ? [NSString stringWithFormat:lqLocalized(@"hello,%@", nil),RI.infoInitItem.username] : lqStrings(@"hello,撸友")  textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageV);
            make.left.mas_equalTo(weakSelf.iconImageV.mas_right).offset(Adaptor_Value(15));
        }];

        
        _iDLable = [UILabel lableWithText:[NSString stringWithFormat:lqLocalized(@"ID:%@", nil),RI.infoInitItem.sex_id] textColor:TitleWhiteColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_iDLable];
        [_iDLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.nameLabel.mas_bottom).offset(Adaptor_Value(5));
            make.left.mas_equalTo(weakSelf.nameLabel);
        }];
                        
        _vipTipLable = [UILabel lableWithText:lqStrings(@"同城VIP:") textColor:TitleWhiteColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_vipTipLable];
        [_vipTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.top.mas_equalTo(weakSelf.iDLable.mas_bottom).offset(Adaptor_Value(5));
    
            
        }];
        
        _vipLable = [UILabel lableWithText:RI.infoInitItem.is_vip ? lqStrings(@"已开通"):lqStrings(@"未开通") textColor:LightYellowColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_vipLable];
        [_vipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.vipTipLable.mas_right).offset(Adaptor_Value(5));
            make.top.mas_equalTo(weakSelf.iDLable.mas_bottom).offset(Adaptor_Value(5));
            
        }];
        
        _timesLable = [UILabel lableWithText:@"每日观看次数" textColor:TitleWhiteColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_timesLable];
        [_timesLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.nameLabel);
            make.top.mas_equalTo(weakSelf.vipLable.mas_bottom).offset(Adaptor_Value(5));
        }];
  


    }
    return _header;
}


- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor lq_colorWithHexString:@"202020" alpha:0.5];
        [_bottomView addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomView);
            make.height.mas_equalTo(Adaptor_Value(90));
        }];
        
        _yaoqingBtn = [[LPButton alloc] init];
        [_yaoqingBtn addTarget:self action:@selector(yaoqingBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_yaoqingBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _yaoqingBtn.titleLabel.font = AdaptedFontSize(12);
        [_yaoqingBtn setImage:[UIImage imageNamed:@"icon_share"] forState:UIControlStateNormal];
        [_yaoqingBtn setTitle:lqStrings(@"我的邀请码") forState:UIControlStateNormal];
        [contentV addSubview:_yaoqingBtn];
        [_yaoqingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_equalTo(contentV);
        }];
//        [_yaoqingBtn setIconInTopWithSpacing:Adaptor_Value(25)];
        _yaoqingBtn.style = LPButtonStyleTop;
        _yaoqingBtn.delta = Adaptor_Value(15);

        _chongzhiBtn = [[LPButton alloc] init];
        [_chongzhiBtn addTarget:self action:@selector(chongzhiBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_chongzhiBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _chongzhiBtn.titleLabel.font = AdaptedFontSize(12);
        [_chongzhiBtn setImage:[UIImage imageNamed:@"icon_buy_vip"] forState:UIControlStateNormal];
        [_chongzhiBtn setTitle:lqStrings(@"充值中心") forState:UIControlStateNormal];
        [contentV addSubview:_chongzhiBtn];
        [_chongzhiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(weakSelf.yaoqingBtn);
            make.left.mas_equalTo(weakSelf.yaoqingBtn.mas_right);
        }];
//        [_chongzhiBtn setIconInTopWithSpacing:Adaptor_Value(25)];
        _chongzhiBtn.style = LPButtonStyleTop;
        _chongzhiBtn.delta = Adaptor_Value(15);

        
        _qianbaoBtn = [[LPButton alloc] init];
        [_qianbaoBtn addTarget:self action:@selector(qianbaoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_qianbaoBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _qianbaoBtn.titleLabel.font = AdaptedFontSize(12);
        [_qianbaoBtn setImage:[UIImage imageNamed:@"icon_wallet"] forState:UIControlStateNormal];
        [_qianbaoBtn setTitle:lqStrings(@"我的钱包") forState:UIControlStateNormal];
        [contentV addSubview:_qianbaoBtn];
        [_qianbaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(weakSelf.yaoqingBtn);
            make.left.mas_equalTo(weakSelf.chongzhiBtn.mas_right);
        }];
//        [_qianbaoBtn setIconInTopWithSpacing:Adaptor_Value(25)];
        _qianbaoBtn.style = LPButtonStyleTop;
        _qianbaoBtn.delta = Adaptor_Value(15);

        
        _tuiguangBtn = [[LPButton alloc] init];
        [_tuiguangBtn addTarget:self action:@selector(tuiguangBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tuiguangBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _tuiguangBtn.titleLabel.font = AdaptedFontSize(12);
        [_tuiguangBtn setImage:[UIImage imageNamed:@"icon_daili"] forState:UIControlStateNormal];
        [_tuiguangBtn setTitle:lqStrings(@"推广赚钱") forState:UIControlStateNormal];
        [contentV addSubview:_tuiguangBtn];
        [_tuiguangBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(weakSelf.yaoqingBtn);
            make.left.mas_equalTo(weakSelf.qianbaoBtn.mas_right);
        }];
//        [_tuiguangBtn setIconInTopWithSpacing:Adaptor_Value(25)];
        _tuiguangBtn.style = LPButtonStyleTop;
        _tuiguangBtn.delta = Adaptor_Value(15);

        
        _vipBtn = [[LPButton alloc] init];

        [_vipBtn addTarget:self action:@selector(vipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_vipBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _vipBtn.titleLabel.font = AdaptedFontSize(12);
        [_vipBtn setImage:[UIImage imageNamed:@"icon_exchange"] forState:UIControlStateNormal];
        [_vipBtn setTitle:lqStrings(@"VIP兑换") forState:UIControlStateNormal];
        [contentV addSubview:_vipBtn];
        [_vipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.mas_equalTo(weakSelf.yaoqingBtn);
            make.left.mas_equalTo(weakSelf.tuiguangBtn.mas_right);
            make.right.mas_equalTo(contentV);
        }];
//        [_vipBtn setIconInTopWithSpacing:Adaptor_Value(25)];
        _vipBtn.style = LPButtonStyleTop;
        _vipBtn.delta = Adaptor_Value(15);

    }
    return _bottomView;

}

@end
