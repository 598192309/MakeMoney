//
//  AdsHeaderView.m
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AdsHeaderView.h"

@interface AdsHeaderView ()
@property (nonatomic,strong)UIView *header;

@property (strong, nonatomic) UIImageView *imageV;


@end
@implementation AdsHeaderView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中寻找顶部视图对象，如果没有，该方法自动调用alloc/initWithFrame创建一个新的顶部视图返回
    AdsHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([AdsHeaderView class]) forIndexPath:indexPath];
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
- (void)refreshUIWithImageStr:(NSString *)titleImageStr{
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:titleImageStr]];
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
        
        _imageV = [[UIImageView alloc] init];
        [contentV addSubview:_imageV];
        [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(contentV);
        }];
        
    }
    return _header;
}
@end
