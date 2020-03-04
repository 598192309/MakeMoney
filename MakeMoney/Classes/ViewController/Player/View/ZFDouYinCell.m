//
//  ZFDouYinCell.m
//  ZFPlayer_Example
//
//  Created by 紫枫 on 2018/6/4.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import "ZFDouYinCell.h"
#import "UIImageView+ZFCache.h"
#import "ZFUtilities.h"
#import "ZFLoadingView.h"
#import "LPButton.h"
@interface ZFDouYinCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) LPButton *likeBtn;

@property (nonatomic, strong) LPButton *shareBtn;

@property (nonatomic,strong) UILabel *tagLable;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) EnlargeTouchSizeButton *seeBtn;
@property (nonatomic,strong) UILabel *timeLable;

@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIImageView *bgImgView;

@property (nonatomic, strong) UIView *effectView;

@end

@implementation ZFDouYinCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgImgView];
        [self.bgImgView addSubview:self.effectView];
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.shareBtn];
        [self.contentView addSubview:self.likeBtn];
        [self.contentView addSubview:self.tagLable];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.seeBtn];
        [self.contentView addSubview:self.timeLable];

        
        __weak __typeof(self) weakSelf = self;
        [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.contentView);
        }];
        
        [self.effectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bgImgView);
        }];
        
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.contentView);
        }];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(Adaptor_Value(60));
            make.right.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(10));
            make.bottom.mas_equalTo(- BottomAdaptor_Value(30));
        }];
        
        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.right.mas_equalTo(weakSelf.shareBtn);
            make.bottom.mas_equalTo(weakSelf.shareBtn.mas_top).offset(-Adaptor_Value(20));
        }];
        

        
        [self.seeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.bottom.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(30));
            make.height.mas_equalTo(Adaptor_Value(20));
        }];
        ViewBorderRadius(self.seeBtn, Adaptor_Value(10), 1, TitleWhiteColor);
        
        [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(weakSelf.seeBtn);
            make.left.mas_equalTo(weakSelf.seeBtn.mas_right).offset(Adaptor_Value(5));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.seeBtn);
            make.bottom.mas_equalTo(weakSelf.seeBtn.mas_top).offset(-Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(120));
        }];
        
        [self.tagLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.seeBtn);
            make.bottom.mas_equalTo(weakSelf.titleLabel.mas_top).offset(-Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.contentView).offset(-Adaptor_Value(120));
        }];
        
    }
    return self;
}

#pragma mark - ui
- (void)setDataItem:(HotItem *)dataItem{
    _dataItem = dataItem;
//    if (data.thumbnail_width >= data.thumbnail_height) {
//        self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
//        self.coverImageView.clipsToBounds = NO;
//    } else {
//        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
//        self.coverImageView.clipsToBounds = YES;
//    }
    [self.coverImageView setImageWithURLString:dataItem.img_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
    [self.bgImgView setImageWithURLString:dataItem.img_url placeholder:[UIImage imageNamed:@"loading_bgView"]];
    self.titleLabel.text = dataItem.title;
    [self.likeBtn setTitle:dataItem.love forState:UIControlStateNormal];
    self.timeLable.text = dataItem.total_time;
    /**<string name=“video_tag1”>#自拍</string>
    <string name=“video_tag2”>#口活</string>
    <string name=“video_tag3”>#3P</string>
    <string name=“video_tag4”>#自慰</string>
    <string name=“video_tag5”>#學生妹</string>
    <string name=“video_tag6”>#人妻</string>
    <string name=“video_tag7”>#双飞</string>
    <string name=“video_tag8”>#國語對白</string>
    <string name=“video_tag9”>#後入</string>
    <string name=“video_tag10”>#情趣</string>
    <string name=“video_tag11”>#熱舞</string>
    <string name=“video_tag12”>#瘋狂夜場</string>
    <string name=“video_tag13”>#露出</string>
    <string name=“video_tag14”>#绿奴</string>
    <string name=“video_tag15”>#調教</string>
    <string name=“video_tag16”>#超清</string>
    <string name=“video_tag17”>#約炮</string>
    <string name=“video_tag18”>#模特</string>
    <string name=“video_tag19”>#巨乳</string>
    <string name=“video_tag20”>#主播</string>
    <string name=“video_tag21”>#素人</string>
    <string name=“video_tag22”>#网红</string>
    <string name=“video_tag23”>#偷拍</string>
    <string name=“video_tag100”>#迪卡侬</string>
    <string name=“video_tag101”>#AI明星换脸</string>
    <string name=“video_tag102”>#网曝门事件</string>
    <string name=“video_tag103”>#三级片</string>
    <string name=“video_tag104”>#动画</string>
    <string name=“video_tag105”>#欧美</string>
    <string name=“video_tag106”>#萌白酱</string>*/
    self.tagLable.text = dataItem.video_tag;
}


#pragma mark - act
- (void)seeBtnClick:(UIButton *)sender{
    if (self.douYinCellSeeBtnClickBlock) {
        self.douYinCellSeeBtnClickBlock(sender);
    }
}

- (void)likeBtnClick:(UIButton *)sender{
    if (self.douYinCellLikeBtnClickBlock) {
        self.douYinCellLikeBtnClickBlock(sender);
    }
}

- (void)shareBtnClick:(UIButton *)sender{
    if (self.douYinCellShareBtnClickBlock) {
        self.douYinCellShareBtnClickBlock(sender);
    }
}
#pragma mark - lazy

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = AdaptedFontSize(17);
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)tagLable{
    if (!_tagLable) {
        _tagLable = [UILabel new];
        _tagLable.textColor = [UIColor whiteColor];
        _tagLable.font = AdaptedFontSize(15);
        _tagLable.numberOfLines = 0;

    }
    return _tagLable;
}

- (UILabel *)timeLable{
    if (!_timeLable) {
        _timeLable = [UILabel new];
        _timeLable.textColor = [UIColor whiteColor];
        _timeLable.font = AdaptedFontSize(13);
    }
    return _timeLable;
}

- (EnlargeTouchSizeButton *)seeBtn{
    if (!_seeBtn) {
        _seeBtn = [[EnlargeTouchSizeButton alloc] init];
        [_seeBtn addTarget:self action:@selector(seeBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_seeBtn setImage:[UIImage imageNamed:@"icon_video_play_detail_white"] forState:UIControlStateNormal];
        _seeBtn.titleLabel.font = AdaptedFontSize(11);
        [_seeBtn setTitle:lqStrings(@"观看完整版") forState:UIControlStateNormal];
        [_seeBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        [_seeBtn setContentEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    }
    return _seeBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [LPButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        [_likeBtn setTitle:lqStrings(@" ") forState:UIControlStateNormal];
        [_likeBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _likeBtn.style =LPButtonStyleTop;
        [_likeBtn addTarget:self action:@selector(likeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _likeBtn.delta = Adaptor_Value(5);
        
        _likeBtn.titleLabel.font = AdaptedFontSize(13);
    }
    return _likeBtn;
}


- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [LPButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
        [_shareBtn setTitle:lqStrings(@"分享") forState:UIControlStateNormal];
        [_shareBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _shareBtn.style =LPButtonStyleTop;
        _shareBtn.delta = 0;

        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.titleLabel.font = AdaptedFontSize(13);

    }
    return _shareBtn;
}

- (UIImage *)placeholderImage {
    if (!_placeholderImage) {
        _placeholderImage = [ZFUtilities imageWithColor:[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1] size:CGSizeMake(1, 1)];
    }
    return _placeholderImage;
}




- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.tag = 100;
//        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] init];
        _bgImgView.userInteractionEnabled = YES;
    }
    return _bgImgView;
}

- (UIView *)effectView {
    if (!_effectView) {
        if (@available(iOS 8.0, *)) {
            UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
            _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        } else {
            UIToolbar *effectView = [[UIToolbar alloc] init];
            effectView.barStyle = UIBarStyleBlackTranslucent;
            _effectView = effectView;
        }
    }
    return _effectView;
}

@end
