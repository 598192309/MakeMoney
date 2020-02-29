//
//  ZHuanTiCell.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ZHuanTiCell.h"
#import "ZhuanTiItem.h"
#import "HomeApi.h"
@interface ZHuanTiCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;



@end
@implementation ZHuanTiCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        [self layoutSub];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = ThemeBlackColor;
        
    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.contentView);
    }];
    
}

- (void)layoutSub{
}

- (void)refreshWithItem:(ZhuanTiHomeItem*)item{
    self.titleLabel.text = item.title;
    
    __weak __typeof(self) weakSelf = self;
    [HomeApi downImageWithType:@"s_imgs" paramTitle:@"sId" ID:item.ID key:@"zhuanti" Success:^(UIImage * _Nonnull img) {
        
        weakSelf.imageV.image = img;
    } error:^(NSError *error, id resultObject) {
        
    }];
    
}

#pragma mark - act

#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor clearColor];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(Adaptor_Value(5));
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(15));
            make.bottom.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(5));
            
        }];
        contentV.backgroundColor = ThemeBlackColor;
        ViewRadius(contentV, Adaptor_Value(5));
        
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(contentV);
        }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.left.right.bottom.mas_equalTo(contentV);
        }];
        _titleLabel.backgroundColor = [UIColor lq_colorWithHexString:@"303030" alpha:0.05];

    }
    return _cellBackgroundView;
}

@end
