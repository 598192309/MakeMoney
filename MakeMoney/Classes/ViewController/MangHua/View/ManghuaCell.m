//
//  ManghuaCell.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ManghuaCell.h"
#import "MangHuaItem.h"
@interface ManghuaCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *tipLabel;

@property (nonatomic,strong)MangHuaDetailItem *item;

@end
@implementation ManghuaCell

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




- (void)refreshWithItem:(MangHuaDetailItem *)item {
    _titleLabel.text = item.title;
    self.tipLabel.text = @"完结";

     /**
      
     对应参数如下
     /api/v_imgs         vId=                   短视频
     /api/a_imgs         aId=                   av
     /api/qm_imgs      qmId=                同城
     /api/vt_imgs        vtId=                  全部分类
     /api/s_imgs         sId=                   专题
      */
    self.item = item;
     self.imageV.image = nil;
    __weak __typeof(self) weakSelf = self;
    if (!item) {
        return;
    }
    //加载图片做个判断，
    //cover 包含http就直接加载，否则凭借 basic接口的 video_cover_url
    //如果cover有值 就去加载cover的  否则就走以前的 另外一个借口下载图片。
    if (item.cover_url.length > 0) {
        NSString *imageUrl;
        if ([item.cover_url hasPrefix:@"http"]) {
            imageUrl = item.cover_url;
        }else{
            imageUrl = [NSString stringWithFormat:@"%@%@",RI.basicItem.cartoon_url,item.cover_url];
        }
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl]];

        
    }else{
        [LSVProgressHUD showInfoWithStatus:@"cover_url---空"];
    }
    
    
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
        contentV.backgroundColor = ThemeBlackColor;

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = ThemeBlackColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(180));
        }];
        ViewRadius(_imageV, 6);
        
        _tipLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.width.mas_equalTo(Adaptor_Value(45));
            make.bottom.mas_equalTo(weakSelf.imageV).offset(-Adaptor_Value(5));
            make.left.mas_equalTo(weakSelf.imageV);

        }];
        _tipLabel.backgroundColor = [UIColor lq_colorWithHexString:@"00e376"];

        UIView *titleBackWhiteView = [UIView new];
        titleBackWhiteView.backgroundColor = ThemeBlackColor;
        [contentV addSubview:titleBackWhiteView];
        [titleBackWhiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_greaterThanOrEqualTo(Adaptor_Value(20));
            make.right.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom);
        }];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:2];
        [titleBackWhiteView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(titleBackWhiteView);
            make.left.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(5));
        }];

    }
    return _cellBackgroundView;
}

@end
