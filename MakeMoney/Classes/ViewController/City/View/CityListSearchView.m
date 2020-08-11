//
//  CityListSearchView.m
//  MakeMoney
//
//  Created by JS on 2020/4/23.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityListSearchView.h"
#import "CustomerAlignTypeLayout.h"
#import "CityItem.h"
@interface CityListSearchView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UICollectionView *customCollectionView;
@property (nonatomic,strong)UIView *customCoverView;
@end

@implementation CityListSearchView

- (void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr= dataArr;
    [self.customCollectionView reloadData];
}

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
    
    [self addSubview:self.customCoverView];
    [self addSubview:self.header];

    __weak __typeof(self) weakSelf = self;

    [self.customCoverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf);
        make.top.mas_equalTo(Adaptor_Value(150));
        make.left.mas_equalTo(Adaptor_Value(50));
    }];


}
#pragma mark --act

- (void)dismiss{
    if (self.closeBlock) {
        self.closeBlock();
    }
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
    CityListItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithStr:item.region_name];

    
    return cell;
}



// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (self.cellClickBlock) {
        self.cellClickBlock(indexPath);
    }
    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CityListItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    NSString *str = item.region_name;
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
        contentV.backgroundColor = [UIColor whiteColor];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.header);
        }];
        ViewRadius(contentV, 5);
            
        _tipLable = [UILabel lableWithText:lqStrings(@"按地区查询") textColor:TitleBlackColor fontSize:AdaptedFontSize(18) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
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
            make.height.mas_equalTo(kOnePX);
        }];
        
        [contentV addSubview:self.customCollectionView];
        [weakSelf.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.lineView.mas_bottom).offset(Adaptor_Value(10));
            make.height.mas_equalTo(Adaptor_Value(300));
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

- (void)configUIWithStr:(NSString *)str titleColor:(UIColor *)titleColor{
    self.nameLabel.text = str;
    self.nameLabel.textColor = titleColor;
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
