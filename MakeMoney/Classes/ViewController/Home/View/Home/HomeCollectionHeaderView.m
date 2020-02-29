//
//  HomeCollectionHeaderView.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeCollectionHeaderView.h"
@interface HomeCollectionHeaderView ()
@property (nonatomic,strong)UIView *header;

@property (strong, nonatomic) UILabel *tipLabel;

@property (nonatomic,strong) EnlargeTouchSizeButton * tipBtn;

@end
@implementation HomeCollectionHeaderView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中寻找顶部视图对象，如果没有，该方法自动调用alloc/initWithFrame创建一个新的顶部视图返回
    HomeCollectionHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HomeCollectionHeaderView class]) forIndexPath:indexPath];
    return headerView;
    
}
//注册了顶部视图后，当缓存池中没有顶部视图的对象时候，自动调用alloc/initWithFrame创建
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
       [self configUI];

    }
    return self;
}
-(void)configUI{
    [self addSubview:self.header];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
}
- (void)refreshUIWithTitle:(NSString *)title tipBtnTitle:(NSString *)tipBtnTitle{
    self.tipLabel.text = title;
    [self.tipBtn setTitle:tipBtnTitle forState:UIControlStateNormal];
}

#pragma mark - act
- (void)tipBtnClick:(EnlargeTouchSizeButton *)sender{
    if (self.headerViewTipBtnClickBlock) {
        self.headerViewTipBtnClickBlock(sender);
    }
}
#pragma mark - lazy
-(UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        contentV.backgroundColor = ThemeBlackColor;
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        
        _tipLabel = [UILabel lableWithText:lqStrings(@"") textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLabel];
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentV);
            make.left.mas_equalTo(Adaptor_Value(15));
        }];
        
        
        _tipBtn = [[EnlargeTouchSizeButton alloc] init];
        [_tipBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tipBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _tipBtn.titleLabel.font = AdaptedFontSize(17);
        [contentV addSubview:_tipBtn];
        [_tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentV);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];
        
    }
    return _header;
}
@end
