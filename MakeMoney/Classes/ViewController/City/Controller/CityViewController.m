//
//  CityViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityViewController.h"
#import "CityCell.h"
#import "HomeCollectionTopHeaderView.h"
#import "CityApi.h"
#import "CityItem.h"
@interface CityViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@property (nonatomic,strong)CityInfoItem *cityInfoDataItem;

@property (nonatomic,strong)NSMutableArray *bannerImageUrlArr;
@end

@implementation CityViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    
    [self requestData];
    [self reqestBannerAds];
}

#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(TopAdaptor_Value(25));
    }];

}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [CityApi requestCityInfoSuccess:^(CityInfoItem * _Nonnull cityInfoItem, NSString * _Nonnull msg) {
        weakSelf.cityInfoDataItem = cityInfoItem;
        [weakSelf.collectionView endHeaderRefreshing];
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
}

//获取顶部banner广告
- (void)reqestBannerAds{
    __weak __typeof(self) weakSelf = self;
    [self.bannerImageUrlArr removeAllObjects];

    [HomeApi requestAdWithType:@"0" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        for (AdsItem *item  in adsItemArr) {
            [weakSelf.bannerImageUrlArr addObject:item.img];
        }
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CityCell class]) forIndexPath:indexPath];
    [cell refreshWithItem:(indexPath.item % 2) ? [NSObject new] : nil];
    return cell;
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 0) {
            //获取顶部视图
            HomeCollectionTopHeaderView *headerView=[HomeCollectionTopHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
            [headerView refreshUIWithTitle:lqStrings(@"你大爷") tipBtnTitle:lqStrings(@"点击查看更多") bannerImageUrlArr:self.bannerImageUrlArr];
            return headerView;
        }

    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int row = 3;
    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - Adaptor_Value(5)) / row;
    CGFloat h = [self caculateCellHeight:indexPath];
    return CGSizeMake(w , h);

}
- (CGFloat)caculateCellHeight:(NSIndexPath *)indexPath{
    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - Adaptor_Value(5)) / 3;

    CGFloat h;
    h += Adaptor_Value(180);//图片固定高度
    h += Adaptor_Value(5);
    NSString *str = (indexPath.item % 2) ?  @"我是你大爷 我是你大爷 我是你大爷" : @"我是你大爷";
    CGFloat titleH = [str boundingRectWithSize:CGSizeMake(w - AdaptedWidth(20) , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.height;\
    h += titleH;
    h += 5;
    return h;
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(Adaptor_Value(5), Adaptor_Value(10), Adaptor_Value(5), Adaptor_Value(10));

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(LQScreemW, Adaptor_Value(20 + 150));
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        //创建布局对象
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //设置滚动方向为垂直滚动，说明方块是从左上到右下的布局排列方式
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
//        layout.headerReferenceSize = CGSizeMake(LQScreemW, Adaptor_Value(20));
        
        layout.minimumLineSpacing = Adaptor_Value(5);
        layout.minimumInteritemSpacing = Adaptor_Value(5);
        //创建容器视图
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate=self;//设置代理
        _collectionView.dataSource=self;//设置数据源
        _collectionView.backgroundColor = ThemeBlackColor;
        
        [_collectionView registerClass:[CityCell class] forCellWithReuseIdentifier:NSStringFromClass([CityCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        //注册容器视图中显示的顶部视图
        [_collectionView registerClass:[HomeCollectionTopHeaderView class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:NSStringFromClass([HomeCollectionTopHeaderView class])];

        [_collectionView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    }
    return _collectionView;
}

- (NSMutableArray *)bannerImageUrlArr{
    if (!_bannerImageUrlArr) {
        _bannerImageUrlArr = [NSMutableArray array];
    }
    return _bannerImageUrlArr;
}
@end
