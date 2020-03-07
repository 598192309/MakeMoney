//
//  RechargeDetailCell.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "RechargeDetailCell.h"
#import "MineItem.h"
@interface RechargeDetailCell()
@property (nonatomic,strong) UIView * cellBackgroundView;
@property (strong, nonatomic)  UILabel *orderLabel;
@property (strong, nonatomic)  UILabel *vipLable;
@property (strong, nonatomic)  EnlargeTouchSizeButton *orderBtn;
@property (strong, nonatomic)  UILabel *moneyLable;
@property (strong, nonatomic)  UILabel *timeLable;

@property (nonatomic,strong)PayRecordItem *item;
@end
@implementation RechargeDetailCell

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

- (void)configUIWithItem:(PayRecordItem *)item{
    self.item = item;
    self.orderLabel.text = [NSString stringWithFormat:lqLocalized(@"订单编号:%@", nil),item.order_no];
    //type 1 视频  2 同城 3写真
    NSString *str1;
    if (item.type == 1) {
        str1 = lqStrings(@"视频VIP");
    }else if (item.type == 2) {
        str1 = lqStrings(@"同城VIP");
    }else if (item.type == 3) {
        str1 = lqStrings(@"写真VIP");
    }
    NSString *status = item.status == 1 ? lqStrings(@"已支付"):lqStrings(@"未支付");
    self.vipLable.text = [NSString stringWithFormat:@"%@     %@",str1,status];
    self.timeLable.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd HH:mm:ss"];
    self.moneyLable.text = [NSString stringWithFormat:@"%@%@",item.price,item.unit];
    
}
#pragma mark - act
- (void)orderBtnClick:(UIButton *)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.item.order_no;
    [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"复制成功", nil)];
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
            make.left.mas_equalTo(Adaptor_Value(15));
            make.right.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(5));
            make.bottom.mas_equalTo(weakSelf.cellBackgroundView).offset(-Adaptor_Value(5));
        }];
        contentV.backgroundColor = TitleWhiteColor;
        ViewRadius(contentV, 10);

        _orderLabel = [UILabel lableWithText:lqLocalized(@"订单编号:",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_orderLabel];
        [_orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        
        
        _vipLable = [UILabel lableWithText:lqLocalized(@"",nil) textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_vipLable];
        [_vipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.orderLabel);
            make.top.mas_equalTo(weakSelf.orderLabel.mas_bottom).offset(Adaptor_Value(25));
        }];
        
        _timeLable = [UILabel lableWithText:lqLocalized(@"   ",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_timeLable];
        [_timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.orderLabel);
            make.top.mas_equalTo(weakSelf.vipLable.mas_bottom).offset(Adaptor_Value(25));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
        
        
        _orderBtn = [[EnlargeTouchSizeButton alloc ] init];
       [_orderBtn addTarget:self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_orderBtn setTitle:lqStrings(@"复制订单号") forState:UIControlStateNormal];
        [_orderBtn setTitleColor:TitleGrayColor forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = AdaptedFontSize(12);
       [contentV addSubview:_orderBtn];
       [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
           make.top.mas_equalTo(Adaptor_Value(20));
       }];
        
        _moneyLable = [UILabel lableWithText:lqLocalized(@"  ",nil) textColor:ThemeBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_moneyLable];
        [_moneyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.top.mas_equalTo(weakSelf.orderBtn.mas_bottom).offset(Adaptor_Value(10));
        }];


      
        
        
    }
    return _cellBackgroundView;
}
@end
