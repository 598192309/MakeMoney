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
#import "HomeCollectionHeaderView.h"
#import "AdsHeaderView.h"

@interface CityViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@property (nonatomic,strong)CityInfoItem *cityInfoDataItem;

@property (nonatomic,strong)NSMutableArray *bannerImageUrlArr;

@property (nonatomic,strong)NSArray *bottomAdsArr;
@end

@implementation CityViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self requestData];
    [self reqestBannerAds];
    [self requestAds];
    

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
        [weakSelf.collectionView endHeaderRefreshing];

    }];
}

//获取顶部banner广告
- (void)reqestBannerAds{
    __weak __typeof(self) weakSelf = self;
    [self.bannerImageUrlArr removeAllObjects];

    [HomeApi requestAdWithType:@"1" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        for (AdsItem *item  in adsItemArr) {
            [weakSelf.bannerImageUrlArr addObject:item.img];
        }
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}

//获取广告
- (void)requestAds{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestAdWithType:@"5" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        weakSelf.bottomAdsArr = adsItemArr;
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    if (section == 0) {
        return self.cityInfoDataItem.upmarketLists.count;
    }else if (section == 1){
        return self.cityInfoDataItem.hotLists.count;
    }else if (section == 2){
        return self.cityInfoDataItem.theNewLists.count;

    }
    return 0;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CityCell class]) forIndexPath:indexPath];
    CityListItem *item;
    if (indexPath.section == 0) {
        item = [self.cityInfoDataItem.upmarketLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        item = [self.cityInfoDataItem.hotLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 2) {
        item = [self.cityInfoDataItem.theNewLists safeObjectAtIndex:indexPath.row];
    }
    [cell refreshWithItem:item];
    return cell;
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       
        if (indexPath.section == 0) {
            //获取顶部视图
            HomeCollectionTopHeaderView *headerView=[HomeCollectionTopHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
            [headerView refreshUIWithTitle:lqStrings(@"高端兼职") titleImageStr:@"icon_hot_man" tipBtnTitle:lqStrings(@"按城市>>") bannerImageUrlArr:self.bannerImageUrlArr];
            return headerView;
        }
        //获取顶部视图
        NSString *title;
        NSString *subTitle;
        NSString *imageStr;

        if (indexPath.section == 1) {
            title = lqStrings(@"热门QM");
            subTitle = lqStrings(@"按地区>>");
            imageStr = @"icon_hot_hot";
        }else{
            title = lqStrings(@"最新推荐");
            subTitle = lqStrings(@"查看更多>>");
            imageStr = @"icon_hot_find";

        }
       HomeCollectionHeaderView *headerView=[HomeCollectionHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
        [headerView refreshUIWithTitle:title titleImageStr:imageStr tipBtnTitle:subTitle];
       return headerView;
    }
    AdsHeaderView *footerView = [AdsHeaderView footerViewWithCollectionView:collectionView forIndexPath:indexPath];
    footerView.backgroundColor = [UIColor redColor];
    AdsItem *item = [self.bottomAdsArr safeObjectAtIndex:indexPath.section];
    [footerView refreshUIWithImageStr:item.img];
    return footerView;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int row = 3;
    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - Adaptor_Value(5)) / row;
//    CGFloat h = [self caculateCellHeight:indexPath];
    CGFloat h = Adaptor_Value(220);
    return CGSizeMake(w , h);

}
- (CGFloat)caculateCellHeight:(NSIndexPath *)indexPath{
    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - Adaptor_Value(5)) / 3;

    CGFloat h = 0;
    h += Adaptor_Value(180);//图片固定高度
    h += Adaptor_Value(5);
    CityListItem *item;
    if (indexPath.section == 0) {
        item = [self.cityInfoDataItem.upmarketLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        item = [self.cityInfoDataItem.hotLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 2) {
        item = [self.cityInfoDataItem.theNewLists safeObjectAtIndex:indexPath.row];
    }
    NSString *str = item.title;
    CGFloat titleH = [str boundingRectWithSize:CGSizeMake(w - AdaptedWidth(20) , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.height;\
    h += titleH;
    h += 5;
    return h;
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Adaptor_Value(10), 0, Adaptor_Value(10));

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  CGSizeMake(LQScreemW, Adaptor_Value(40 + 150));
    }else{
       //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
        return  CGSizeMake(LQScreemW, Adaptor_Value(40));
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    AdsItem *item = [self.bottomAdsArr safeObjectAtIndex:section];
    //根据url 获取图片尺寸
    CGSize size = [UIImage getImageSizeWithURL:item.img];
    
    CGFloat h = LQScreemW / size.width * size.height;
    return  CGSizeMake(LQScreemW,h);
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
        
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
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
        
        [_collectionView registerClass:[HomeCollectionHeaderView class]
                  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                         withReuseIdentifier:NSStringFromClass([HomeCollectionHeaderView class])];
        
        [_collectionView registerClass:[AdsHeaderView class]
                  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                         withReuseIdentifier:NSStringFromClass([AdsHeaderView class])];


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
