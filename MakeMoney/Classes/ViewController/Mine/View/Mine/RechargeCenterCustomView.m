//
//  RechargeCenterCustomView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "RechargeCenterCustomView.h"

@interface RechargeCenterCustomView()
//头部view
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UITextField *orderTF;
@property (nonatomic,strong)UIButton *checkBtn;
@property (nonatomic,strong)UIView *lineView;

@end
@implementation RechargeCenterCustomView
#pragma mark - 生命周期
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
- (void)configUIWithItem:(NSObject *)item finishi:(void(^)(void))finishBlock{

    
    finishBlock();
}

#pragma mark - act
- (void)checkBtnClick:(EnlargeTouchSizeButton *)sender{

    if (self.rechargeCenterViewCheckBtnClickBlock) {
        self.rechargeCenterViewCheckBtnClickBlock(sender,self.orderTF);
    }

}
#pragma  mark - UITextField delegate
- (void)textFDidChange:(UITextField *)textf{
    
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
        
        _orderTF = [[UITextField alloc] init];
        [contentV addSubview:_orderTF];
        [_orderTF mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(Adaptor_Value(25));
              make.width.mas_equalTo(Adaptor_Value(200));
              make.height.mas_equalTo(Adaptor_Value(40));
              make.top.mas_equalTo(Adaptor_Value(10));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(10));
        }];
        _orderTF.textColor = TitleWhiteColor;
        [_orderTF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _orderTF.placeholder = lqStrings(@"请输入订单号");

          // "通过KVC修改placeholder的颜色"
    //        [_nameTextF setValue:TitleGrayColor forKeyPath:@"_placeholderLabel.textColor"];
        [_orderTF setPlaceholderColor:TitleGrayColor font:nil];
//        _orderTF.backgroundColor = TitleWhiteColor;
        
        _checkBtn = [[UIButton alloc] init];
        [_checkBtn addTarget:self action:@selector(checkBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_checkBtn setTitleColor:TitleBlackColor forState:UIControlStateNormal];
        _checkBtn.titleLabel.font = AdaptedBoldFontSize(17);
        [_checkBtn setTitle:lqStrings(@"查询") forState:UIControlStateNormal];
        [contentV addSubview:_checkBtn];
        [_checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.orderTF);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
            make.width.mas_equalTo(Adaptor_Value(120));
            make.height.mas_equalTo(Adaptor_Value(40));

        }];
        
        [_checkBtn setBackgroundColor:TitleWhiteColor];
        ViewRadius(_checkBtn, 10);
        
        _lineView = [UIView new];
        _lineView.backgroundColor = TitleGrayColor;
        [contentV addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(weakSelf.checkBtn);
            make.left.mas_equalTo(Adaptor_Value(15));
            
            make.height.mas_equalTo(kOnePX);
            make.bottom.mas_equalTo(contentV);
        }];
    }
    return _header;
}



@end
