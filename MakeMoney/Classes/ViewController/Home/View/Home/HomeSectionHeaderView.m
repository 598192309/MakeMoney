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
@property (weak, nonatomic) IBOutlet UIButton *btn;

@property (nonatomic, strong) HomeVideoList *video;

@end

@implementation HomeSectionHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    
}

- (void)refreshViewWithVideo:(nullable HomeVideoList *)video{
    _video = video;
    if (video) {
        _iconImgaView.image = nil;
        _titleLabel.text = video.title;
        [_btn setTitle:@">" forState:UIControlStateNormal];
    } else {
        _iconImgaView.hidden = NO;
        _iconImgaView.image = [UIImage imageNamed:@"hot"];
        _titleLabel.text = @"人气热榜";
        [_btn setTitle:@"全部分类 >" forState:UIControlStateNormal];
    }
}
- (IBAction)eventAction:(id)sender {
    if (_video) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"跳转到%@分类",_video.title]];
    } else {
        [SVProgressHUD showInfoWithStatus:@"跳转到“全部分类”"];
    }
}



@end
