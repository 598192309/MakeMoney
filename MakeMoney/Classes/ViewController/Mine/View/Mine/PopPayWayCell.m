//
//  PopPayWayCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "PopPayWayCell.h"
#import "MineItem.h"
@interface PopPayWayCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
//@property (strong, nonatomic)  UIImageView *iconImageV;
//@property (strong, nonatomic)  UILabel *titleLable2;

@property (nonatomic,strong)UIButton *payBtn;
@end
@implementation PopPayWayCell

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
- (void)configUIWithItem:(PayWayItem *)item{
    [self.payBtn setTitle:item.name forState:UIControlStateNormal];
    NSString *image;
    if ([item.name containsString:@"支付宝"]) {
        image = @"icon_pay_ali";
    }else if ([item.name containsString:@"微信"]) {
        image = @"icon_pay_wechat";
    }else if ([item.name containsString:@"QQ"]) {
        image = @"icon_pay_qq";
    }else if ([item.name containsString:@"卡密支付"]) {
        image = @"";
    }else if ([item.name containsString:@"银行卡"]) {
        image = @"icon_pay_bank";
    }
    [self.payBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
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
        contentV.backgroundColor = [UIColor whiteColor];

       _payBtn = [[UIButton alloc] init];
       [_payBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
       [contentV addSubview:_payBtn];
       [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.edges.mas_equalTo(contentV);
       }];
        [_payBtn setIconInLeftWithSpacing:Adaptor_Value(5)];
        _payBtn.userInteractionEnabled = NO;
    }
    return _cellBackgroundView;
}

@end
