//
//  CityCell.m
//  MakeMoney
//
//  Created by rabi on 2020/2/28.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityCell.h"

@interface CityCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;


@end
@implementation CityCell

#pragma mark - 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
}




- (void)refreshWithItem:(NSObject *)item {
    _titleLabel.text = item ? @"我是你大爷 我是你大爷 我是你大爷" : @"我是你大爷";
    [_imageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    
}
#pragma mark - act

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = TitleWhiteColor;
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(180));
        }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(5));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];

    }
    return _cellBackgroundView;
}

@end
