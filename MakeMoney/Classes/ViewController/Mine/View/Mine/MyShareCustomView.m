//
//  MyShareCustomView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MyShareCustomView.h"
@interface MyShareCustomView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIView *erweimaView;
@property (nonatomic,strong)UIImageView *erweimaImageV;
@property (nonatomic,strong)UILabel *erweimaLable;

@property (nonatomic,strong)EnlargeTouchSizeButton *changeBtn;
@property (nonatomic,strong)EnlargeTouchSizeButton *savePictureBtn;
@property (nonatomic,strong)EnlargeTouchSizeButton *urlCopyBtn;

@end
@implementation MyShareCustomView
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
    
    //生成对应的二维码 这里不要中文
    NSString *erweimaStr = [NSString stringWithFormat:@"%@/share5.html?appkey=%@&code=%@",RI.basicItem.share_url,ErweimaShareKey,RI.infoInitItem.invite_code];
    UIImage *image = [UIImage generateIconQRCodeWithString:erweimaStr Size:Adaptor_Value(200) icon:[UIImage imageNamed:@"ic_erweima"]];
    self.erweimaImageV.image = image;

}


#pragma mark - 刷新ui
- (void)configUIWithItem:(NSObject *)item finishi:(void(^)(void))finishBlock{

    
    finishBlock();
}

#pragma mark - act
- (void)changeBtnClick:(EnlargeTouchSizeButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.myshareCustomHeaderViewChangeBtnClickBlock) {
        self.myshareCustomHeaderViewChangeBtnClickBlock(sender,@{});
    }
}
- (void)saveBtnClick:(EnlargeTouchSizeButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.myshareCustomHeaderViewSaveBtnClickBlock) {
        self.myshareCustomHeaderViewSaveBtnClickBlock(sender,self.erweimaImageV);
    }
}

- (void)copyBtnClick:(EnlargeTouchSizeButton *)sender{
//    [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    if (self.myshareCustomHeaderViewCopyBtnClickBlock) {
        self.myshareCustomHeaderViewCopyBtnClickBlock(sender,@{});
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
        
        _erweimaView = [UIView new];
        _erweimaView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:_erweimaView];
        [_erweimaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(10));
            make.width.mas_equalTo(Adaptor_Value(240));
            make.height.mas_equalTo(Adaptor_Value(280));
        }];
        ViewRadius(_erweimaView, 10);
        
        _erweimaImageV = [[UIImageView alloc] init];
        [_erweimaView addSubview:_erweimaImageV];
        [_erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(weakSelf.erweimaView);
           make.height.width.mas_equalTo(Adaptor_Value(200));
           make.top.mas_equalTo(Adaptor_Value(20));
        }];
        _erweimaImageV.backgroundColor = TitleGrayColor;
        
        
        _erweimaLable = [UILabel lableWithText:[NSString stringWithFormat:lqLocalized(@"我的推荐码: %@", nil),RI.infoInitItem.invite_code] textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [_erweimaView addSubview:_erweimaLable];
        [_erweimaLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(weakSelf.erweimaView);
            make.bottom.mas_equalTo(weakSelf.erweimaView.mas_bottom).offset(-Adaptor_Value(20));
            
        }];
        
        _changeBtn = [[EnlargeTouchSizeButton alloc] init];
        [_changeBtn addTarget:self action:@selector(changeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_changeBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _changeBtn.titleLabel.font = AdaptedFontSize(15);
        [_changeBtn setTitle:lqStrings(@"换个样式") forState:UIControlStateNormal];
        [contentV addSubview:_changeBtn];
        [_changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.erweimaView.mas_bottom).offset(Adaptor_Value(20));
            make.centerX.mas_equalTo(contentV);
        }];
        
        _savePictureBtn = [[EnlargeTouchSizeButton alloc] init];
        [_savePictureBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_savePictureBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _savePictureBtn.titleLabel.font = AdaptedFontSize(15);
        [_savePictureBtn setTitle:lqStrings(@"保存图片分享") forState:UIControlStateNormal];
        [contentV addSubview:_savePictureBtn];
        [_savePictureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.changeBtn.mas_bottom).offset(Adaptor_Value(20));
            make.right.mas_equalTo(contentV.mas_centerX).offset(-Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
        }];
        [_savePictureBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_savePictureBtn, Adaptor_Value(20));
        
        
        _urlCopyBtn = [[EnlargeTouchSizeButton alloc] init];
        [_urlCopyBtn addTarget:self action:@selector(copyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_urlCopyBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _urlCopyBtn.titleLabel.font = AdaptedFontSize(15);
        [_urlCopyBtn setTitle:lqStrings(@"复制链接分享") forState:UIControlStateNormal];
        [contentV addSubview:_urlCopyBtn];
        [_urlCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.changeBtn.mas_bottom).offset(Adaptor_Value(20));
            make.left.mas_equalTo(contentV.mas_centerX).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
            
            make.bottom.mas_equalTo(contentV);
        }];
        [_urlCopyBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_urlCopyBtn, Adaptor_Value(20));
  


    }
    return _header;
}



@end
