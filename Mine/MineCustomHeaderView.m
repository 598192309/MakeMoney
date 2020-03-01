//
//  MineCustomView.m
//  HuiXiaKuan
//
//  Created by Lqq on 2018/8/30.
//  Copyright © 2018年 Lq. All rights reserved.
//

#import "MineCustomHeaderView.h"
@interface MineCustomHeaderView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *nameLabel;
@property (nonatomic,strong)UILabel *phoneLabel;
@property (nonatomic,strong)UILabel *verifyTipLabel;
@property (nonatomic,strong)UIImageView *iconImageV;
//未登录状态
@property (nonatomic,strong)UILabel *unlorigTipLable;

@property (nonatomic,strong)UIButton *accesoryyBtn;


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
        make.edges.mas_equalTo(weakSelf);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(NSObject *)item finishi:(void(^)(void))finishBlock{

    
    finishBlock();
}
#pragma mark - act
- (void)viewTap:(UIGestureRecognizer *)gest{
    if (self.mineCustomHeaderViewBlock) {
        self.mineCustomHeaderViewBlock(nil);
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
        
        _iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avart"]];
        [contentV addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(30));
            make.height.width.mas_equalTo(Adaptor_Value(60));
            make.top.mas_equalTo(TopAdaptor_Value(60));
        }];
        ViewRadius(_iconImageV, Adaptor_Value(9));
//        UITapGestureRecognizer *iconTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
//        _iconImageV.userInteractionEnabled = YES;
//        [_iconImageV addGestureRecognizer:iconTap];
        _iconImageV.contentMode = UIViewContentModeScaleAspectFill;
        

        _nameLabel = [UILabel lableWithText:@"aaa"  textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.iconImageV.mas_centerY).offset(-Adaptor_Value(5));
            make.left.mas_equalTo(weakSelf.iconImageV.mas_right).offset(Adaptor_Value(15));
        }];


        
        _phoneLabel = [UILabel lableWithText:@"" textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_phoneLabel];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.iconImageV.mas_centerY).offset(Adaptor_Value(5));
            make.left.mas_equalTo(weakSelf.nameLabel);
        }];
        

        
     

        
        _unlorigTipLable = [UILabel lableWithText:@"登录/注册" textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(30) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_unlorigTipLable];
        [_unlorigTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.phoneLabel);
            make.centerY.mas_equalTo(weakSelf.iconImageV);
            
        }];
//        _unlorigTipLable.userInteractionEnabled = YES;
//
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
//        [_unlorigTipLable addGestureRecognizer:tap];
        
        UIView *tapView = [UIView new];
        [contentV addSubview:tapView];
        [tapView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_equalTo(weakSelf.iconImageV);
            make.right.mas_greaterThanOrEqualTo(weakSelf.nameLabel.mas_right);
            make.right.mas_greaterThanOrEqualTo(weakSelf.phoneLabel.mas_right);
            make.right.mas_greaterThanOrEqualTo(weakSelf.unlorigTipLable.mas_right);

        }];
        tapView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [tapView addGestureRecognizer:tap];

        
        
        _verifyTipLabel = [UILabel lableWithText:@"bbb" textColor:[UIColor redColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_verifyTipLabel];
        [_verifyTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.nameLabel.mas_right).offset(Adaptor_Value(10));
            make.centerY.mas_equalTo(weakSelf.nameLabel);
            make.width.mas_equalTo(Adaptor_Value(50));
            make.height.mas_equalTo(Adaptor_Value(25));
            
        }];
        ViewRadius(_verifyTipLabel, Adaptor_Value(2.5));
        //        _verifyTipLabel.hidden = !RI.is_logined;
        _verifyTipLabel.backgroundColor = [UIColor lq_colorWithHexString:@"00e376" alpha:0.1];
        
        UITapGestureRecognizer *authTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(authTap:)];
        _verifyTipLabel.userInteractionEnabled = YES;
        [_verifyTipLabel addGestureRecognizer:authTap];
        
        
//        _accesoryyBtn = [[UIButton alloc] init];
//        [_accesoryyBtn setImage:[UIImage imageNamed:@"accessory"] forState:UIControlStateNormal];
//        [_accesoryyBtn addTarget:self action:@selector(accesoryyBtnClick:) forControlEvents:UIControlEventTouchDown];
//        [contentV addSubview:_accesoryyBtn];
//        [_accesoryyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.height.width.mas_equalTo(Adaptor_Value(50));
//            make.centerY.mas_equalTo(contentV);
//            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
//        }];
        
        _nameLabel.hidden = !RI.is_logined;
        _phoneLabel.hidden = !RI.is_logined;
        _verifyTipLabel.hidden = !RI.is_logined;
        
        _unlorigTipLable.hidden = RI.is_logined;
        _accesoryyBtn.hidden = !RI.is_logined;


    }
    return _header;
}


@end
