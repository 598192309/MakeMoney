//
//  ManghuaCategoryCell.m
//  MakeMoney
//
//  Created by rabi on 2020/9/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ManghuaCategoryCell.h"
#import "MangHuaItem.h"

@interface ManghuaCategoryCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *tipLabel;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *contenLable;

@property (strong, nonatomic)  UILabel *authorLable;
@property (strong, nonatomic)  UIView  *lineView;

@property (nonatomic,strong)MangHuaDetailItem *item;

@end
@implementation ManghuaCategoryCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
    _titleLabel.text = @"TOuch Me";
    _contenLable.text = @"lalalallalalal啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦啦";
    _authorLable.text = @"作者:是谁";
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
            make.height.mas_equalTo(Adaptor_Value(250));
        }];
        contentV.backgroundColor = ThemeBlackColor;

        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(contentV).offset(Adaptor_Value(5));
            make.height.mas_equalTo(Adaptor_Value(220));
            make.top.mas_equalTo(Adaptor_Value(20));
            make.width.mas_equalTo(Adaptor_Value(160));
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

        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleWhiteColor fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.imageV.mas_right).offset(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(35));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];
        
        _contenLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_contenLable];
        [_contenLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.titleLabel);
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(Adaptor_Value(25));
        }];

        
        _authorLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_authorLable];
        [_authorLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.titleLabel);
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(25));
        }];
        
        _lineView = [UIView new];
        _lineView.backgroundColor = LineGrayColor;
        [contentV addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.imageV);
            make.right.mas_equalTo(contentV.mas_right).offset(-Adaptor_Value(5));
            make.height.mas_equalTo(kOnePX);
            make.bottom.mas_equalTo(contentV);
        }];
    }
    return _cellBackgroundView;
}

@end
