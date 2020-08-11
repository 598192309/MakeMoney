//
//  SearchCollectionHeaderView.m
//  MakeMoney
//
//  Created by rabi on 2020/8/11.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "SearchCollectionHeaderView.h"
#import "CustomerAlignTypeLayout.h"
#import "CityListSearchView.h"

@interface SearchCollectionHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UILabel *tipLable;
@property (nonatomic,strong)UICollectionView *customCollectionView;
@property (nonatomic,strong)NSArray *hotArr;
@end
@implementation SearchCollectionHeaderView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    //从缓存池中寻找顶部视图对象，如果没有，该方法自动调用alloc/initWithFrame创建一个新的顶部视图返回
    SearchCollectionHeaderView *headerView=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SearchCollectionHeaderView class]) forIndexPath:indexPath];
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
- (void)configUIWithArr:(NSArray *)arr{
    self.hotArr = arr;
    [self.customCollectionView reloadData];
}

#pragma mark - act
- (CGFloat)caculateHeight{
    CGFloat allLabelWidth = 0;
    CGFloat allLabelJiangeW = 0;
    CGFloat allLabelHeight = Adaptor_Value(30);
    int rowHeight = 1;
    for (NSString *str in self.hotArr) {
        CGFloat width = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.width;
        if (allLabelWidth + width+Adaptor_Value(15)*2  + allLabelJiangeW > LQScreemW - Adaptor_Value(15) *2 ) {
            rowHeight++;
            allLabelWidth = 0;
            allLabelJiangeW = 0;
            allLabelHeight = rowHeight*Adaptor_Value(30) + (rowHeight)* Adaptor_Value(10);
        }
        allLabelWidth = allLabelWidth + width +Adaptor_Value(15)*2;
        allLabelJiangeW = allLabelJiangeW  + Adaptor_Value(10);
    }
    return allLabelHeight;
}
#pragma mark -collection delegate/datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.hotArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([LabelCollectionViewCell class]) forIndexPath:indexPath];
    
    [cell configUIWithStr:[self.hotArr safeObjectAtIndex:indexPath.item] titleColor:TitleWhiteColor];

    
    return cell;
}



// 点击item的时候
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.hotcellClickBlock) {
        self.hotcellClickBlock(indexPath.item);
    }

    
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [self.hotArr safeObjectAtIndex:indexPath.item];

    CGSize size = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size;
    return CGSizeMake(size.width + Adaptor_Value(15) * 2,Adaptor_Value(30));
}
////设置每个item的UIEdgeInsets
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(AdaptedWidth(5), 0, 0, 0);
//}

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
        
        _tipLable = [UILabel lableWithText:@"热门搜索" textColor:TitleWhiteColor fontSize:AdaptedFontSize(17) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_tipLable];
        [_tipLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(10));
        }];
        
        [contentV addSubview:weakSelf.customCollectionView];
        [weakSelf.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(contentV);
            make.top.mas_equalTo(weakSelf.tipLable.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
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
        layout.minimumInteritemSpacing = Adaptor_Value(0);
        layout.minimumLineSpacing = Adaptor_Value(10);
        _customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _customCollectionView.backgroundColor = [UIColor clearColor];
        [_customCollectionView registerClass:[LabelCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([LabelCollectionViewCell class])];
        _customCollectionView.delegate = self;
        _customCollectionView.dataSource = self;
        _customCollectionView.showsVerticalScrollIndicator = NO;
        _customCollectionView.showsHorizontalScrollIndicator = NO;
        _customCollectionView.scrollEnabled = NO;
        
    }
    return _customCollectionView;
}
@end

