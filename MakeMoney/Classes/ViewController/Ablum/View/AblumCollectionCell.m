//
//  AblumCollectionCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AblumCollectionCell.h"
#import "AblumItem.h"
@interface AblumCollectionCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *timeLable;
@property (strong, nonatomic)  UILabel *vedioTimesLable;
@property (strong, nonatomic)  UILabel *titleLable;

@property (nonatomic,strong)HotItem *item;
@end
@implementation AblumCollectionCell

#pragma mark - 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        self.contentView.backgroundColor = TitleWhiteColor;

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

- (void)refreshAblumWithItem:(AblumItem *)item{
    self.titleLable.text = item.album_name;
    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd"];
    self.vedioTimesLable.text = [NSString stringWithFormat:@"%ld张",(long)item.img_count];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RI.basicItem.album_url,item.imgs.firstObject]]];
}


#pragma mark - act

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];
        contentV.backgroundColor = TitleWhiteColor;

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.clipsToBounds = YES;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(5));
            make.height.mas_equalTo(Adaptor_Value(235));
            make.left.mas_equalTo(Adaptor_Value(5));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(5));
        }];
        

        _timeLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.left.mas_equalTo(Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];

        
        _vedioTimesLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
        [contentV addSubview:_vedioTimesLable];
        [_vedioTimesLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.right.mas_equalTo(-Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        UIView *alfaView  = [UIView new];
        alfaView.backgroundColor = [UIColor lq_colorWithHexString:@"303030" alpha:0.4];
        [contentV insertSubview:alfaView belowSubview:_timeLable];
        [alfaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(30)));
            make.left.right.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        UIView *titleBackWhiteView = [UIView new];
        titleBackWhiteView.backgroundColor = TitleWhiteColor;
        [contentV addSubview:titleBackWhiteView];
        [titleBackWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom);
            make.bottom.mas_equalTo(contentV);
        }];
        
        _titleLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:1];
        [titleBackWhiteView addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(titleBackWhiteView);
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(5));
        }];
    }
    return _cellBackgroundView;
}
@end
