//
//  HomeSectionHeaderView.m
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeSectionHeaderView.h"

@interface HomeSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgaView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) HomeVideoList *video;
@property (nonatomic, strong) AdsItem *adItem;

@end

@implementation HomeSectionHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    _adImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAdImage)];
    [_adImageView addGestureRecognizer:tap];
}

- (void)refreshViewWithVideo:(nullable HomeVideoList *)video ad:(nullable AdsItem *)adItem {
    _video = video;
    _adItem = adItem;
    if (video) {
        _iconImgaView.hidden = YES;
        _iconImgaView.image = nil;
        _titleLabel.text = video.title;
        [_btn setTitle:@">" forState:UIControlStateNormal];
    } else {
        _iconImgaView.hidden = NO;
        _iconImgaView.image = [UIImage imageNamed:@"icon_hot_hot"];
        _titleLabel.text = @"人气热榜";
        [_btn setTitle:@"全部分类 >" forState:UIControlStateNormal];
    }
    
    if (adItem) {
        _adImageView.hidden = NO;
        [_adImageView sd_setImageWithURL:[NSURL URLWithString:adItem.img]];
    } else {
        _adImageView.hidden = YES;
        
    }
}
- (IBAction)eventAction:(id)sender {
    if (_video) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"跳转到%@分类",_video.title]];
    } else {
        [SVProgressHUD showInfoWithStatus:@"跳转到“全部分类”"];
    }
}

- (void)clickedAdImage{
    if (_adItem) {
        [LqToolKit jumpAdventWithItem:_adItem];
    }
}

@end
