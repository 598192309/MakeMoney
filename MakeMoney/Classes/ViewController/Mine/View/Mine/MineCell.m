//
//  MineCell.m
//  Encropy
//
//  Created by Lqq on 2019/4/24.
//  Copyright © 2019年 Lq. All rights reserved.
//

#import "MineCell.h"

@interface MineCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *rightTitleLabel;
@property (nonatomic,strong)UIImageView *accesoryImageV;
@end
@implementation MineCell

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



- (void)refreshUIWithTitle:(NSString *)title rightTitle:(NSString *)rightTitle accessoryHidden:(BOOL)accessoryHidden{
    _titleLabel.text = title;
    _rightTitleLabel.text = rightTitle;
    _accesoryImageV.hidden = accessoryHidden;
    
    
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
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
            make.height.mas_equalTo(Adaptor_Value(50));
        }];
        contentV.backgroundColor = [UIColor lq_colorWithHexString:@"202020" alpha:0.5];
        
        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));

            make.centerY.mas_equalTo(contentV);
        }];
        
        
        _rightTitleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_rightTitleLabel];
        [_rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.centerY.mas_equalTo(contentV);
            make.height.mas_equalTo(weakSelf.rightTitleLabel.mas_width);
        }];
        
        _accesoryImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"accessory"]];
        [contentV addSubview:_accesoryImageV];
        [_accesoryImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.centerY.mas_equalTo(contentV);
            make.height.width.mas_equalTo(Adaptor_Value(20));
        }];

    }
    return _cellBackgroundView;
}

@end
