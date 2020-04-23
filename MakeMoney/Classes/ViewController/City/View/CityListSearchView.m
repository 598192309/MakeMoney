//
//  CityListSearchView.m
//  MakeMoney
//
//  Created by JS on 2020/4/23.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityListSearchView.h"
#import "CustomerAlignTypeLayout.h"
@interface CityListSearchView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UICollectionView *customCollectionView;
@property (nonatomic,strong)UIView *customCoverView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation CityListSearchView


#pragma mark - 生命周期
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUI];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    [self addSubview:self.header];
    [self addSubview:self.customCoverView];

    [self addSubview:self.customCollectionView];
    __weak __typeof(self) weakSelf = self;
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(weakSelf);
    }];
    [self.customCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];

}
#pragma mark --act
- (void)show{
    //约束动画
    __weak __typeof(self) weakSelf = self;
    [self layoutIfNeeded];//如果其约束还没有生成的时候需要动画的话，就请先强制刷新后才写动画，否则所有没生成的约束会直接跑动画
    
    
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.header mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf);
            
        }];
        
        [weakSelf layoutIfNeeded];//强制绘制
    }];
}
- (void)dismiss{
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.5 animations:^{
        [weakSelf.header mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf).offset(285);
            
        }];
        [weakSelf layoutIfNeeded];//强制绘制
    } completion:^(BOOL finished) {
        if (weakSelf.closeBlock) {
            weakSelf.closeBlock();
        }
        
    }];
    
    
    
}

#pragma mark -collection delegate/datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LabelCollectionViewCell class]) forIndexPath:indexPath];
    
    [cell configUIWithStr:@"111"];

    
    return cell;
}



// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   

    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    SearchDataItem *item = [self.historyArr safeObjectAtIndex:indexPath.row];
    NSString *str = @"111";
    CGSize size = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size;
    return CGSizeMake(size.width + Adaptor_Value(15) * 2,Adaptor_Value(30));
}
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(AdaptedWidth(5), 0, 0, 0);
//}


#pragma Mark - 懒加载



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
            
        _tipLable = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
        [contentV addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(contentV);
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        

        _lineView = [UIView new];
        _lineView.backgroundColor = TitleBlackColor;
        [contentV addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.tipLable.mas_bottom).offset(Adaptor_Value(10));
        }];
        
    }
    return _header;
}


- (UICollectionView *)customCollectionView {
    if (!_customCollectionView) {
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        //设置collectionView滚动方向
//        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        CustomerAlignTypeLayout *layout = [[CustomerAlignTypeLayout alloc] initWthType:AlignWithLeft];
        layout.minimumInteritemSpacing = Adaptor_Value(5);
        layout.minimumLineSpacing = Adaptor_Value(10);
        _customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _customCollectionView.backgroundColor = [UIColor clearColor];
        [_customCollectionView registerClass:[LabelCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LabelCollectionViewCell class])];
        _customCollectionView.delegate = self;
        _customCollectionView.dataSource = self;
        _customCollectionView.showsVerticalScrollIndicator = NO;
        _customCollectionView.showsHorizontalScrollIndicator = NO;
        
    }
    return _customCollectionView;
}

- (UIView *)customCoverView{
    if (!_customCoverView) {
        _customCoverView = [UIView new];
        _customCoverView.backgroundColor = [UIColor lq_colorWithHexString:@"#14181A" alpha:0.5];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_customCoverView addGestureRecognizer:tap];

    }
    return _customCoverView;
}
@end

@interface LabelCollectionViewCell()


@property (nonatomic,strong) UIView * cellBackgroundView;

@property (nonatomic, strong) UILabel * nameLabel;

@end

@implementation LabelCollectionViewCell
- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.contentView.backgroundColor = [UIColor clearColor];
        [self addPageSubviews];
    }
    return self;
}
-(void)addPageSubviews{
    [self.contentView addSubview:self.cellBackgroundView];
    __weak __typeof(self) weakSelf = self;
    [self.cellBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.contentView);
    }];
    
}

- (void)configUIWithStr:(NSString *)str{
    self.nameLabel.text = str;
}

#pragma mark - getters
-(UIView *)cellBackgroundView{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [UIView new];
        _cellBackgroundView.backgroundColor = [UIColor clearColor];
        
        UIView *contentV = [UIView new];
        __weak __typeof(self) weakSelf = self;
        [_cellBackgroundView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.cellBackgroundView);
            make.height.mas_equalTo(Adaptor_Value(30));
        }];
        ViewRadius(_cellBackgroundView, Adaptor_Value(15));
        
        
        _nameLabel = [UILabel lableWithText:@"" textColor:TitleBlackColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:1];
        [contentV addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.centerY.mas_equalTo(contentV);
        }];
        

        
        
        
        
    }
    return _cellBackgroundView;
}


@end
