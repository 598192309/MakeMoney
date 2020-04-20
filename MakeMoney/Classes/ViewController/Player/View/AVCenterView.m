//
//  AVCenterView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//  播放器 中间 广告 名称等

#import "AVCenterView.h"
#import "HomeItem.h"
@interface AVCenterView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *adsImageV;
@property (nonatomic,strong)UILabel *titleLable;
@property (strong, nonatomic)  UILabel *seeCountsLable;
@property (strong, nonatomic)  UILabel *timeLable;
@property (strong, nonatomic)  UILabel *tipLable;
@property (nonatomic,strong)EnlargeTouchSizeButton *loveBtn;
@property (nonatomic,strong)AdsItem *adsItem;

@end
@implementation AVCenterView
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
- (void)configUIWithItem:(HotItem *)item finishi:(void(^)(void))finishBlock{

    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];
    self.seeCountsLable.text = [NSString stringWithFormat:lqLocalized(@"%@次播放", nil),item.play];
    self.titleLable.text = item.title;
    finishBlock();
}

- (void)configAds:(AdsItem *)item finishi:(void(^)(void))finishBlock{
    self.adsItem = item;
    //根据url 获取图片尺寸
//    CGSize size = [UIImage getImageSizeWithURL:item.img];
    
//    CGFloat h = LQScreemW / size.width * size.height;
//    [self.adsImageV sd_setImageWithURL:[NSURL URLWithString:item.img]];
//    [self.adsImageV mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(h);
//    }];
    __weak __typeof(self) weakSelf = self;
    [self.adsImageV sd_setImageWithURL:[NSURL URLWithString:item.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            CGFloat h = LQScreemW /image.size.width * image.size.height;
            [weakSelf.adsImageV mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(h);
            }];
            finishBlock();

        }
    }];
}

#pragma mark - act
- (void)adsTap:(UITapGestureRecognizer *)gest{
    [LqToolKit jumpAdventWithItem:self.adsItem];
}

//收藏
- (void)loveBtnClick:(UIButton *)sender{
    if (self.loveBtn) {
        self.loveBlock(sender);
    }
    sender.selected = !sender.selected;
}
#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = TitleWhiteColor;
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        
        _adsImageV = [[UIImageView alloc] init];
        [contentV addSubview:_adsImageV];
        [_adsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
           make.top.mas_equalTo(Adaptor_Value(10));
            make.height.mas_equalTo(0);
        }];
        ViewRadius(_adsImageV, 5);
        UITapGestureRecognizer *adsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adsTap:)];
        _adsImageV.userInteractionEnabled = YES;
        [_adsImageV addGestureRecognizer:adsTap];

        
        _titleLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:AdaptedBoldFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(weakSelf.adsImageV.mas_bottom).offset(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            
        }];
        
         _seeCountsLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
         [contentV addSubview:_seeCountsLable];
         [_seeCountsLable mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.mas_equalTo(weakSelf.titleLable);
             make.top.mas_equalTo(weakSelf.titleLable.mas_bottom).offset(Adaptor_Value(10));
             make.height.mas_equalTo(Adaptor_Value(20));
         }];
       

         _timeLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
         [contentV addSubview:_timeLable];
         [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {            make.left.mas_equalTo(weakSelf.seeCountsLable.mas_right).offset(Adaptor_Value(20));
             make.centerY.mas_equalTo(weakSelf.seeCountsLable);
         }];
        
        _tipLable = [UILabel lableWithText:lqLocalized(@"狼友推荐",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {            make.left.mas_equalTo(weakSelf.seeCountsLable);
            make.top.mas_equalTo(weakSelf.seeCountsLable.mas_bottom).offset(Adaptor_Value(20));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        
        
        _loveBtn = [[EnlargeTouchSizeButton alloc] init];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_before"] forState:UIControlStateNormal];
//        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_after"] forState:UIControlStateSelected];
        [_loveBtn setTitle:lqStrings(@"收藏") forState:UIControlStateNormal];
        [_loveBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        [_loveBtn setTitle:lqStrings(@"已收藏") forState:UIControlStateSelected];
        [_loveBtn setTitleColor:TitleGrayColor forState:UIControlStateSelected];
        _loveBtn.titleLabel.font = AdaptedFontSize(15);


        [contentV addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(20));
            make.centerY.mas_equalTo(weakSelf.tipLable);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        _loveBtn.touchSize = CGSizeMake(Adaptor_Value(50), Adaptor_Value(50));
//        _loveBtn.selected = YES;//现在默认选择 现在没有显示 选中和不选中的判断

        UIView *loveBtnBackView = [UIView new];
        loveBtnBackView.backgroundColor = [UIColor lq_colorWithHexString:@"ffffff" alpha:0.3];
        [contentV insertSubview:loveBtnBackView belowSubview:_loveBtn];
        [loveBtnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(40));
            make.center.mas_equalTo(weakSelf.loveBtn);
        }];
        ViewRadius(loveBtnBackView, Adaptor_Value(20));


    }
    return _header;
}


@end
