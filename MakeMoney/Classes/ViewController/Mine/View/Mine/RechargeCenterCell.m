//
//  RechargeCenterCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "RechargeCenterCell.h"
#import "MineItem.h"
@interface RechargeCenterCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *titleLabel;
@property (strong, nonatomic)  UILabel *tipLabel;
@property (strong, nonatomic)  UILabel *detailLable;
@property (strong, nonatomic)  UIButton  *buyBtn;

@end
@implementation RechargeCenterCell

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



- (void)refreshUIWithItem:(PayCenterInfotem *)item{
    self.titleLabel.text = item.price;
    self.detailLable.text = item.text;
    
    //type 1 视频  2 同城
    self.tipLabel.text = item.name;

    
}
#pragma mark - act
- (void)buyBtnClick:(UIButton *)sender{
    if (self.rechargeCenterBuyBtnClickBlock) {
        self.rechargeCenterBuyBtnClickBlock(sender);
    }
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
            make.height.mas_equalTo(Adaptor_Value(90));
        }];
        contentV.backgroundColor = [UIColor clearColor];

        _titleLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(30) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(15));
        }];
        
        
        _tipLabel = [UILabel lableWithText:lqLocalized(@"",nil) textColor:LightYellowColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel.mas_right).offset(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(25));
        }];
        
        _detailLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_detailLable];
        [_detailLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.titleLabel);
            make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).offset(Adaptor_Value(10));
        }];

        
        _buyBtn = [[UIButton alloc] init];
        [_buyBtn addTarget:self action:@selector(buyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_buyBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _buyBtn.titleLabel.font = AdaptedBoldFontSize(17);
        [_buyBtn setTitle:lqStrings(@"购买") forState:UIControlStateNormal];
        [contentV addSubview:_buyBtn];
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.titleLabel);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.height.mas_equalTo(Adaptor_Value(40));
            make.width.mas_equalTo(Adaptor_Value(120));
        }];
        [_buyBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_buyBtn, 10);
        
        
    }
    return _cellBackgroundView;
}

@end
