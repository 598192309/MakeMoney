//
//  NoDataView.m
//  Encropy
//
//  Created by Lqq on 2019/8/9.
//  Copyright © 2019 Lq. All rights reserved.
//  没有数据的页面

#import "NoDataView.h"

@interface NoDataView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UIImageView *iconImageV;

@end
@implementation NoDataView
#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];
        self.userInteractionEnabled = NO;
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
        _iconImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nodata"]];
        [contentV addSubview:_iconImageV];
        [_iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.width.height.mas_equalTo(Adaptor_Value(160));
            make.centerY.mas_equalTo(contentV.mas_centerY).offset(-Adaptor_Value(50));
        }];

        _tipLable = [UILabel lableWithText:lqStrings(@"暂无内容") textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.iconImageV.mas_bottom).offset(Adaptor_Value(20));
        }];
        
    }
    return _header;
}@end
