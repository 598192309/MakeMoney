//
//  SaoMaView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "SaoMaView.h"

@interface SaoMaView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *tipLabel;
@property (nonatomic,strong)UILabel *subTipLable;
@property (nonatomic,strong)UIImageView *erweimaImageV;

@property (nonatomic,strong)EnlargeTouchSizeButton *saveBtn;
@property (nonatomic,strong)UILabel *tipCopyLable;
@property (nonatomic,strong)UILabel *urlLable;
@property (nonatomic,strong)EnlargeTouchSizeButton *urlCopyBtn;

@end
@implementation SaoMaView
#pragma mark - SETTER
- (void)setUrlStr:(NSString *)urlStr{
    _urlStr = urlStr;
    //生成对应的二维码
      NSString *erweimaStr = self.urlStr;
      UIImage *image = [UIImage generateQRCodeWithString:erweimaStr Size:Adaptor_Value(200)];
      self.erweimaImageV.image = image;
    self.urlLable.text = urlStr;
}
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
- (void)saveBtnClick:(EnlargeTouchSizeButton *)sender{
    if (self.saveBtnClickBlock) {
        self.saveBtnClickBlock(sender, self.erweimaImageV);
    }
}


- (void)copyBtnClick:(EnlargeTouchSizeButton *)sender{
    if (self.copyBtnClickBlock) {
        self.copyBtnClickBlock(sender);
    }
}

#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor whiteColor];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _tipLabel = [UILabel lableWithText:lqStrings(@"请完成支付后再离开当前界面") textColor:ThemeBlackColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(40));
        }];
        
        _subTipLable = [UILabel lableWithText:lqStrings(@"保存二维码，并打开微信扫一扫功能扫码支付") textColor:ThemeBlackColor fontSize:AdaptedBoldFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_subTipLable];
        [_subTipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.tipLabel.mas_bottom).offset(Adaptor_Value(30));
        }];

        
        _erweimaImageV = [[UIImageView alloc] init];
        [contentV addSubview:_erweimaImageV];
        [_erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(contentV);
           make.height.width.mas_equalTo(Adaptor_Value(200));
           make.top.mas_equalTo(weakSelf.subTipLable.mas_bottom).offset(Adaptor_Value(50));
        }];
        _erweimaImageV.backgroundColor = TitleGrayColor;
        
        

        
        _saveBtn = [[EnlargeTouchSizeButton alloc] init];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:ThemeBlackColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = AdaptedBoldFontSize(15);
        [_saveBtn setTitle:lqStrings(@"保存二维码") forState:UIControlStateNormal];
        [contentV addSubview:_saveBtn];
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.erweimaImageV.mas_bottom).offset(Adaptor_Value(50));
            make.centerX.mas_equalTo(contentV);
        }];
        
        _tipCopyLable = [UILabel lableWithText:lqStrings(@"或者复制以下链接发到微信聊天界面，并点击链接支付") textColor:ThemeBlackColor fontSize:AdaptedBoldFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipCopyLable];
        [_tipCopyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.saveBtn.mas_bottom).offset(Adaptor_Value(30));
        }];
        
        _urlLable = [UILabel lableWithText:lqStrings(@"") textColor:ThemeBlackColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_urlLable];
        [_urlLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.tipCopyLable.mas_bottom).offset(Adaptor_Value(30));
        }];
        
        _urlCopyBtn = [[EnlargeTouchSizeButton alloc] init];
        [_urlCopyBtn addTarget:self action:@selector(copyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_urlCopyBtn setTitleColor:ThemeBlackColor forState:UIControlStateNormal];
        _urlCopyBtn.titleLabel.font = AdaptedFontSize(15);
        [_urlCopyBtn setTitle:lqStrings(@"复制链接") forState:UIControlStateNormal];
        [contentV addSubview:_urlCopyBtn];
        [_urlCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.urlLable.mas_bottom).offset(Adaptor_Value(20));
            make.centerX.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];

    

    }
    return _header;
}



@end
