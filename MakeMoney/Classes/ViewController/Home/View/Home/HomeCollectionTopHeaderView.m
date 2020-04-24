//
//  HomeCollectionTopHeaderView.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeCollectionTopHeaderView.h"
#import "SDCycleScrollView.h"

@interface HomeCollectionTopHeaderView ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)UIView *header;

@property (strong, nonatomic) EnlargeTouchSizeButton *titleBtn;

@property (nonatomic,strong) EnlargeTouchSizeButton * tipBtn;
@property (nonatomic,strong)SDCycleScrollView *infiniteView;//轮播
@end
@implementation HomeCollectionTopHeaderView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中寻找顶部视图对象，如果没有，该方法自动调用alloc/initWithFrame创建一个新的顶部视图返回
    HomeCollectionTopHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HomeCollectionTopHeaderView class]) forIndexPath:indexPath];
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
    __weak __typeof(self) weakSelf = self;
    [self addSubview:self.infiniteView];
    [self.infiniteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weakSelf);
        make.height.mas_equalTo(Adaptor_Value(150));
    }];
    
    [self addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.infiniteView.mas_bottom);
    }];
}
- (void)refreshUIWithTitle:(NSString *)title titleImageStr:(NSString *)titleImageStr tipBtnTitle:(NSString *)tipBtnTitle bannerImageUrlArr:(NSMutableArray  *)bannerImageUrlArr{
    [self.titleBtn setTitle:title forState:UIControlStateNormal];
    [self.titleBtn setImage:[UIImage imageNamed:titleImageStr] forState:UIControlStateNormal];

    [self.tipBtn setTitle:tipBtnTitle forState:UIControlStateNormal];
    self.infiniteView.imageURLStringsGroup = bannerImageUrlArr;
}

#pragma mark - act
- (void)tipBtnClick:(EnlargeTouchSizeButton *)sender{
    if (self.headerViewTipBtnClickBlock) {
        self.headerViewTipBtnClickBlock(sender);
    }
}
#pragma  mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
//    [LSVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"*****%ld",(long)index]];
    if (self.bannerClickBlock) {
        self.bannerClickBlock(index);
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
        
        
        _titleBtn = [[EnlargeTouchSizeButton alloc] init];
        [_titleBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _titleBtn.titleLabel.font = AdaptedBoldFontSize(15);
        [contentV addSubview:_titleBtn];
        [_titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentV);
            make.left.mas_equalTo(Adaptor_Value(15));
            
        }];
        
        
        _tipBtn = [[EnlargeTouchSizeButton alloc] init];
        [_tipBtn addTarget:self action:@selector(tipBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tipBtn setTitleColor:[UIColor whiteColor]  forState:UIControlStateNormal];
        _tipBtn.titleLabel.font = AdaptedFontSize(12);
        [contentV addSubview:_tipBtn];
        [_tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(contentV);
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(15));
        }];
        
    }
    return _header;
}

- (SDCycleScrollView *)infiniteView{
    if (!_infiniteView) {
        _infiniteView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, LQScreemW, Adaptor_Value(150)) delegate:self placeholderImage:nil];
        _infiniteView.backgroundColor = [UIColor clearColor];
        _infiniteView.boworrWidth = LQScreemW;
        _infiniteView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _infiniteView.cellSpace = 0;
    }
    return _infiniteView;
}
@end
