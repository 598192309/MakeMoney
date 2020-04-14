//
//  AVHeaderAdsImageView.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/8.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVHeaderAdsImageView.h"

@interface AVHeaderAdsImageView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIImageView *adsImageV;
@property (nonatomic,strong)AdsItem *adsItem;
@end
@implementation AVHeaderAdsImageView
#pragma mark - SETTER

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
- (void)configUIWithItem:(AdsItem *)item finishi:(void(^)(void))finishBlock{
    self.adsItem = item;
    __weak __typeof(self) weakSelf = self;
    [_adsImageV sd_setImageWithURL:[NSURL URLWithString:item.img] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

    }];
    
}

#pragma mark - act
-(void)adsTap:(UITapGestureRecognizer *)gest{
    [LqToolKit jumpAdventWithItem:self.adsItem];
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
        
        _adsImageV = [[UIImageView alloc] init];
        [contentV addSubview:_adsImageV];
        [_adsImageV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.mas_equalTo(contentV);
            make.height.mas_equalTo(0);
        }];
        _adsImageV.backgroundColor = TitleGrayColor;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adsTap:)];
        _adsImageV.userInteractionEnabled = YES;
        [_adsImageV addGestureRecognizer:tap];
 
    }
    return _header;
}


@end
