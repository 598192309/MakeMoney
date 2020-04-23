//
//  CityDetailCustomView.m
//  MakeMoney
//
//  Created by JS on 2020/4/22.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityDetailCustomView.h"
#import "CityItem.h"
@interface CityDetailCustomView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *timeLabel;
@property (nonatomic,strong)UILabel *detailLabel;
@property (nonatomic,strong)UIButton *contactBtn;

@end
@implementation CityDetailCustomView
#pragma mark - SETTER

#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}


#pragma mark - 刷新ui
- (void)configUIWithItem:(CityListItem *)item finishi:(void(^)(void))finishBlock{
    self.timeLabel.text = [item.create_time lq_getTimeFromTimestampWithFormatter:@"yyyy-MM-dd HH:mm"];
    if (RI.infoInitItem.is_qm_vip || !item.is_vip) {//没有设置需要VIP才可观看的
        if (item.qq.length > 0) {
            item.text = [NSString stringWithFormat:@"%@\nQQ:%@",item.text,item.qq];
        }
        if (item.wechat.length > 0) {
            item.text = [NSString stringWithFormat:@"%@\n微信:%@",item.text,item.wechat];
        }
        if (item.mobile.length > 0) {
            item.text = [NSString stringWithFormat:@"%@\n电话%@",item.text,item.mobile];
        }
        self.contactBtn.hidden = YES;
    }else{
        self.contactBtn.hidden = NO;
    }
    NSAttributedString *att = [item.text lq_getAttributedStringWithLineSpace:5 kern:0 aliment:NSTextAlignmentLeft];

    self.detailLabel.attributedText = att;
    finishBlock();
}

#pragma mark - act
- (void)contactBtnClick:(UIButton *)sender{
    if (self.contactBtnClickBlock) {
        self.contactBtnClickBlock(sender);
    }
}

#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
       _timeLabel = [UILabel lableWithText:lqStrings(@"") textColor:TitleGrayColor fontSize:AdaptedFontSize(14) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
       [contentV addSubview:_timeLabel];
       [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.left.mas_equalTo(Adaptor_Value(15));           make.top.mas_equalTo(Adaptor_Value(15));
       }];
       
       _detailLabel = [UILabel lableWithText:@"" textColor:TitleWhiteColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
       [contentV addSubview:_detailLabel];
       [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
           make.left.mas_equalTo(Adaptor_Value(15));
           make.width.mas_equalTo(LQScreemW - Adaptor_Value(30));
           make.top.mas_equalTo(weakSelf.timeLabel.mas_bottom).offset(Adaptor_Value(10));
           
       }];
       _contactBtn = [[UIButton alloc] init];
       [_contactBtn addTarget:self action:@selector(contactBtnClick:) forControlEvents:UIControlEventTouchUpInside];
       [_contactBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
       _contactBtn.titleLabel.font = AdaptedFontSize(18);
       [_contactBtn setTitle:lqStrings(@"查看联系方式>>") forState:UIControlStateNormal];
       [contentV addSubview:_contactBtn];
       [_contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(weakSelf.detailLabel.mas_bottom).offset(Adaptor_Value(20));
           make.height.mas_equalTo(Adaptor_Value(30));
           make.left.mas_equalTo(weakSelf.detailLabel);
           make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
       }];
 
    }
    return _header;
}

@end
