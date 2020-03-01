//
//  HomeSectionFooterView.m
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeSectionFooterView.h"

@interface HomeSectionFooterView ()
@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (nonatomic, strong) AdsItem *adItem;

@end

@implementation HomeSectionFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
    _adImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedAdImage)];
    [_adImageView addGestureRecognizer:tap];
}

- (void)refreshViewWith:(AdsItem *)item{
    _adItem = item;
    [_adImageView sd_setImageWithURL:[NSURL URLWithString:item.img]];
}

- (void)clickedAdImage{
    if (_adItem) {
        [LqToolKit jumpAdventWithItem:_adItem];
    }
}
@end
