//
//  HomeViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTopCell.h"
#import "HomeCollectionHeaderView.h"
#import "HomeCollectionTopHeaderView.h"
#import "HomeItem.h"
#import "HomeApi.h"

@interface HomeViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@property (strong, nonatomic) HomeInfoItem *homeInfoDataItem;//容器视图
@property (nonatomic,strong)NSMutableArray *bannerImageUrlArr;
@end

@implementation HomeViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
        
    
    [self requestData];
    
    [self reqestBannerAds];
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
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
    [HomeApi requestHotListSuccess:^(HomeInfoItem * _Nonnull homeInfoItem, NSString * _Nonnull msg) {
        weakSelf.homeInfoDataItem = homeInfoItem;
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
    [HomeApi requestAdWithType:@"0" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        for (AdsItem *item  in adsItemArr) {
            [weakSelf.bannerImageUrlArr addObject:item.img];
        }
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}
//下载图片
- (void)requestImagesWithType:(NSString *)type paramTitle:(NSString *)paramTitle ID:(NSString *)ID key:(NSString *)key{
    __weak __typeof(self) weakSelf = self;
    [HomeApi downImageWithType:type paramTitle:paramTitle ID:ID key:key Success:^(UIImage * _Nonnull img,NSString *ID) {
        
    } error:^(NSError *error, id resultObject) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    HomeTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeTopCell class]) forIndexPath:indexPath];
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
        //获取顶部视图
        HomeCollectionHeaderView *headerView=[HomeCollectionHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
        [headerView refreshUIWithTitle:lqStrings(@"你大爷") tipBtnTitle:lqStrings(@"点击查看更多")];
        return headerView;
    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int row = 3;
    if (indexPath.section == 0) {
        CGFloat w = (LQScreemW - (row + 1) * Adaptor_Value(15)) / row;
        return CGSizeMake(w , Adaptor_Value(80));
        
    }else{
        row = 2;
        CGFloat w = (LQScreemW - (row + 1) * Adaptor_Value(10)) / row;
        return CGSizeMake(w , Adaptor_Value(130));
    }

}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(Adaptor_Value(10), Adaptor_Value(15), Adaptor_Value(10), Adaptor_Value(15));
    }else{
        return UIEdgeInsetsMake(Adaptor_Value(10), Adaptor_Value(10), Adaptor_Value(10), Adaptor_Value(10));

    }

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  CGSizeMake(LQScreemW, Adaptor_Value(30 + 150));
    }else{
       //设置顶部视图和底部视图的大小，当滚动方向为垂直时，设置宽度无效，当滚动方向为水平时，设置高度无效
        return  CGSizeMake(LQScreemW, Adaptor_Value(20));
    }
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
        
        layout.minimumLineSpacing = Adaptor_Value(15);
        layout.minimumInteritemSpacing = Adaptor_Value(5);
        //创建容器视图
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate=self;//设置代理
        _collectionView.dataSource=self;//设置数据源
        _collectionView.backgroundColor = ThemeBlackColor;
        
        [_collectionView registerClass:[HomeTopCell class] forCellWithReuseIdentifier:NSStringFromClass([HomeTopCell class])];
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
