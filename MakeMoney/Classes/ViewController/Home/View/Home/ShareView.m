//
//  ShareView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ShareView.h"
#import "MineItem.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>

@interface ShareView()
@property (strong, nonatomic)  UIView *header;
@property (nonatomic,strong)UIImageView *tipiconImageV;
@property (strong, nonatomic)  UILabel *titlelabel;
@property (nonatomic,strong)UIImageView *contentImageV;

@property (nonatomic,strong)UIImageView *erweimaImageV;
@property (strong, nonatomic)  UIButton *yaoqingmaBtn;
@property (strong, nonatomic)  UILabel *urlLable;
@property (nonatomic,strong)UIButton *saveBtn;
@property (nonatomic,strong)UIButton *urlCopyBtn;

@property (nonatomic,strong)UIView *customCoverView;
@end


@implementation ShareView


#pragma  mark - 类方法
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        
    }
    return self;
}


#pragma  mark - smzq

- (void)configUI{

    [self addSubview:self.customCoverView];
    __weak __typeof(self) weakSelf = self;
    [self.customCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(weakSelf);
        make.left.mas_equalTo(Adaptor_Value(30));
    }];
    
    //生成对应的二维码 这里不要中文
    NSString *erweimaStr = [NSString stringWithFormat:@"%@/share6.html?appkey=%@&code=%@",RI.basicItem.share_url,ErweimaShareKey,RI.infoInitItem.invite_code];
    UIImage *image = [UIImage generateIconQRCodeWithString:erweimaStr Size:Adaptor_Value(200) icon:[UIImage imageNamed:@"ic_erweima"]];
    self.erweimaImageV.image = image;
    
}
-(void)refreshUIWithItme:(HotItem *)item{
    self.titlelabel.text = item.title;
    [self.yaoqingmaBtn setTitle:[NSString stringWithFormat:lqLocalized(@"邀请码 %@", nil),RI.infoInitItem.invite_code] forState:UIControlStateNormal];
    NSString *erweimaStr = [NSString stringWithFormat:@"%@%@/share6.html?appkey=%@&code=%@",RI.basicItem.share_text,RI.basicItem.share_url,ErweimaShareKey,RI.infoInitItem.invite_code];

    self.urlLable.text = [NSString stringWithFormat:lqLocalized(@"如果扫码不能打开，请手动在流浪起输入地址：%@", nil),erweimaStr];
    
    NSString *typeStr = @"v_imgs";
    NSString *titleStr = @"vId";

    __weak __typeof(self) weakSelf = self;
    [HomeApi downImageWithType:typeStr paramTitle:titleStr ID:item.ID key:item.video_url Success:^(UIImage * _Nonnull img,NSString *ID) {
        weakSelf.contentImageV.image = img;

    } error:^(NSError *error, id resultObject) {
        
    }];
}

#pragma mark - act
- (void)saveBtnClick:(UIButton *)sender {
    if (self.saveBtnClickBlock) {
        //截图
        UIImage *image = [LScreenShot screenShotWithView:self.header size:CGSizeMake(self.header.lq_width, self.header.lq_height)];
        self.saveBtnClickBlock(sender,image);
    }
}
- (void)urlCopyBtnClick:(UIButton *)sender {
    if (self.copyBtnClickBlock) {
        self.copyBtnClickBlock(sender,self.erweimaImageV);
    }
}
- (void)tap:(UITapGestureRecognizer *)gest{
    if (self.tapClickBlock) {
        self.tapClickBlock();
    }
}

#pragma mark - lazy
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        __weak __typeof(self) weakSelf = self;
        UIView *contentV = [UIView new];
        [_header addSubview:contentV];
        contentV.backgroundColor = RGBCOLOR(29, 29, 29);
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        ViewRadius(contentV, 10);
    
        
        _tipiconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_sex"]];
        [contentV addSubview:_tipiconImageV];
        [_tipiconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(Adaptor_Value(15));
           make.top.mas_equalTo(TopAdaptor_Value(10));
            make.width.height.mas_equalTo(Adaptor_Value(70));
        }];
        
        
        _titlelabel = [UILabel lableWithText:[NSString stringWithFormat:lqLocalized(@"", nil),RI.infoInitItem.invite_code] textColor:TitleWhiteColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titlelabel];
        [_titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(weakSelf.tipiconImageV);
            make.left.mas_equalTo(weakSelf.tipiconImageV.mas_right).offset(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));

        }];
        
        _contentImageV = [[UIImageView alloc] init];
        [contentV addSubview:_contentImageV];
        [_contentImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(Adaptor_Value(15));
           make.top.mas_equalTo(weakSelf.titlelabel.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(150));
            make.right.mas_equalTo(weakSelf.titlelabel);
        }];
        _contentImageV.backgroundColor = TitleGrayColor;
        
        _erweimaImageV = [[UIImageView alloc] init];
        [contentV addSubview:_erweimaImageV];
        [_erweimaImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(weakSelf.contentImageV);
           make.top.mas_equalTo(weakSelf.contentImageV.mas_bottom).offset(Adaptor_Value(20));
            make.height.width.mas_equalTo(Adaptor_Value(120));
        }];
        _erweimaImageV.backgroundColor = TitleGrayColor;
        
        
        _yaoqingmaBtn = [[UIButton alloc] init];
        [_yaoqingmaBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _yaoqingmaBtn.titleLabel.font = AdaptedFontSize(15);
        [_yaoqingmaBtn setTitle:lqStrings(@"") forState:UIControlStateNormal];
        [contentV addSubview:_yaoqingmaBtn];
        [_yaoqingmaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.erweimaImageV);
            make.left.mas_equalTo(weakSelf.erweimaImageV.mas_right).offset(Adaptor_Value(20));
            make.height.mas_equalTo(Adaptor_Value(40));

        }];
        [_yaoqingmaBtn setBackgroundColor:CustomRedColor];
        ViewRadius(_yaoqingmaBtn, Adaptor_Value(20));
        [_yaoqingmaBtn setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
        
        
        _urlLable = [UILabel lableWithText:[NSString stringWithFormat:lqLocalized(@"", nil),RI.infoInitItem.invite_code] textColor:TitleWhiteColor fontSize:AdaptedFontSize(11) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_urlLable];
        [_urlLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(weakSelf.yaoqingmaBtn);
            make.top.mas_equalTo(weakSelf.yaoqingmaBtn.mas_bottom).offset(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.titlelabel);

        }];
        
        _saveBtn = [[UIButton alloc] init];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _saveBtn.titleLabel.font = AdaptedFontSize(15);
        [_saveBtn setTitle:lqStrings(@"保存图片分享") forState:UIControlStateNormal];
        [contentV addSubview:_saveBtn];
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_greaterThanOrEqualTo(weakSelf.erweimaImageV.mas_bottom).offset(Adaptor_Value(25));
            make.top.mas_greaterThanOrEqualTo(weakSelf.urlLable.mas_bottom).offset(Adaptor_Value(20));
            make.right.mas_equalTo(contentV.mas_centerX).offset(-Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));

        }];
        [_saveBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_saveBtn, Adaptor_Value(20));
        
        _urlCopyBtn = [[UIButton alloc] init];
        [_urlCopyBtn addTarget:self action:@selector(urlCopyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_urlCopyBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _urlCopyBtn.titleLabel.font = AdaptedFontSize(15);
        [_urlCopyBtn setTitle:lqStrings(@"复制链接分享") forState:UIControlStateNormal];
        [contentV addSubview:_urlCopyBtn];
        [_urlCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.saveBtn);
            make.left.mas_equalTo(contentV.mas_centerX).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
            
        }];
        [_urlCopyBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_urlCopyBtn, Adaptor_Value(20));
    }
    return _header;
}

- (UIView *)customCoverView{
    if (!_customCoverView) {
        _customCoverView = [UIView new];
        _customCoverView.backgroundColor = [UIColor lq_colorWithHexString:@"#14181A" alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

        [_customCoverView addGestureRecognizer:tap];

    }
    return _customCoverView;
}


@end
