//
//  AVCell.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/2/28.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVCell.h"

@interface AVCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UIImageView *imageV;
@property (strong, nonatomic)  UILabel *vipLabel;
@property (strong, nonatomic)  EnlargeTouchSizeButton *loveBtn;
@property (strong, nonatomic)  UILabel *timeLable;
@property (strong, nonatomic)  EnlargeTouchSizeButton *seeTimesBtn;
@property (strong, nonatomic)  UILabel *vedioTimesLable;
@property (strong, nonatomic)  UILabel *titleLable;



@end
@implementation AVCell

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

- (void)refreshWithItem:(NSObject*)item{
    self.titleLable.text = lqStrings(@"你好o");
    [_imageV sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    self.vipLabel.text = 1 ? lqStrings(@"VIP") : lqStrings(@"VIP");
    self.vipLabel.backgroundColor= 1 ? CustomPinkColor : LightYellowColor;

    self.timeLable.text = @"2020-2-2";
    [self.seeTimesBtn setTitle:@"877" forState:UIControlStateNormal];
    self.vedioTimesLable.text = @"01:24";

}

#pragma mark - act
//收藏
- (void)loveBtnClick:(UIButton *)sender{
    
}
#pragma mark - lazy
- (UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = TitleWhiteColor;
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
            
        }];
        contentV.backgroundColor = TitleWhiteColor;
        
        _imageV = [[UIImageView alloc] init];
        _imageV.backgroundColor = TitleGrayColor;
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(contentV);
            make.height.mas_equalTo(Adaptor_Value(210));
        }];
        
        _vipLabel = [UILabel lableWithText:lqLocalized(@"VIP",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(13) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_vipLabel];
        [_vipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.width.mas_equalTo(Adaptor_Value(45));
            make.left.top.mas_equalTo(contentV);
        }];
        _vipLabel.backgroundColor = CustomPinkColor;
        
        _loveBtn = [[EnlargeTouchSizeButton alloc] init];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loveBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateSelected];
        _loveBtn.backgroundColor = [UIColor purpleColor];
        [contentV addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(40));
            make.top.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];

        _timeLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.left.mas_equalTo(Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        _seeTimesBtn = [[EnlargeTouchSizeButton alloc] init];
//        [_seeTimesBtn addTarget:self action:@selector(seeTimesBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_seeTimesBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _seeTimesBtn.titleLabel.font = AdaptedFontSize(12);
        [contentV addSubview:_seeTimesBtn];
        [_seeTimesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.centerY.mas_equalTo(weakSelf.timeLable);
            make.left.mas_equalTo(weakSelf.timeLable.mas_right).offset(Adaptor_Value(20));
        }];
        
        _vedioTimesLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentRight numberofLines:0];
        [contentV addSubview:_vedioTimesLable];
        [_vedioTimesLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.right.mas_equalTo(-Adaptor_Value(10));
            make.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        UIView *alfaView  = [UIView new];
        alfaView.backgroundColor = [UIColor lq_colorWithHexString:@"303030" alpha:0.2];
        [contentV insertSubview:alfaView belowSubview:_timeLable];
        [alfaView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(25)));
            make.left.right.bottom.mas_equalTo(weakSelf.imageV);
        }];
        
        _titleLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleBlackColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLable];
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(Adaptor_Value(40)));
            make.right.bottom.mas_equalTo(contentV);
            make.left.mas_equalTo(Adaptor_Value(14));
            make.top.mas_equalTo(weakSelf.imageV.mas_bottom);
        }];

    }
    return _cellBackgroundView;
}

@end
