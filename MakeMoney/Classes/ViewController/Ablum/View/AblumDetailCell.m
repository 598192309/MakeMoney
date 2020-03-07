//
//  AblumDetailCell.m
//  MakeMoney
//
//  Created by JS on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AblumDetailCell.h"

@interface AblumDetailCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (nonatomic,strong)UIImageView *contentImageV;
@end
@implementation AblumDetailCell

#pragma mark - 生命周期
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)configUI{
    [self.contentView addSubview:self.cellBackgroundView];
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.mas_equalTo(self.contentView);
    }];
   
}

#pragma mark - act
- (void)refreshUIWithImageStr:(NSString*)imageStr{
    [self.contentImageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",RI.basicItem.album_url,imageStr]]];

}
#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor clearColor];
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
        }];
        
        
        _contentImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
        [contentV addSubview:_contentImageV];
        [_contentImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(2.5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(2.5));

        }];

    }
    return _cellBackgroundView;
}


@end
