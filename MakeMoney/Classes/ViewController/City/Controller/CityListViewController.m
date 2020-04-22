//
//  CityListViewController.m
//  MakeMoney
//
//  Created by JS on 2020/4/22.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityListViewController.h"
#import "CityApi.h"
#import "CityItem.h"
#import "CityCell.h"
@interface CityListViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@property (nonatomic,strong)NSMutableArray *cityInfoDataItemArr;
@property (nonatomic,assign)NSInteger pageIndex;
@end

@implementation CityListViewController
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
    
    if (self.cityType == CityType_QM || self.cityType == CityType_New) {
        [self requestData];

    }else{//高端
        [self requestHighData];
    }
    
    
}

#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(TopAdaptor_Value(25));
    }];
    
    //nav
    [self addNavigationView];
    self.navigationTextLabel.text = self.navStr;

}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [CityApi requestQMNewCityListWithType:IntTranslateStr(self.cityType) pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {

        weakSelf.pageIndex = cityItemArr.count ;
        weakSelf.cityInfoDataItemArr = [NSMutableArray arrayWithArray:cityItemArr];
        if (cityItemArr.count >= 25 ) {
            [weakSelf.collectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.collectionView.mj_footer setHidden:NO];
    
        }else{
            [weakSelf.collectionView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.collectionView.mj_footer setHidden:YES];
        }
        [weakSelf.collectionView endHeaderRefreshing];
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.collectionView endHeaderRefreshing];

    }];
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [CityApi requestQMNewCityListWithType:IntTranslateStr(self.cityType) pageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
        [weakSelf.cityInfoDataItemArr addObjectsFromArray:cityItemArr];
        [weakSelf.collectionView endFooterRefreshing];
        [weakSelf.collectionView reloadData];
        if (cityItemArr.count < 25) {
            [weakSelf.collectionView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.cityInfoDataItemArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.collectionView endHeaderRefreshing];

    }];
}

//高端
- (void)requestHighData{
    __weak __typeof(self) weakSelf = self;
    // region_id       分类id //100.全部

    [CityApi requestQMNewCityListWithRegionID:self.regionID pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {

        weakSelf.pageIndex = cityItemArr.count ;
        weakSelf.cityInfoDataItemArr = [NSMutableArray arrayWithArray:cityItemArr];
        if (cityItemArr.count >= 25 ) {
            [weakSelf.collectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.collectionView.mj_footer setHidden:NO];
    
        }else{
            [weakSelf.collectionView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.collectionView.mj_footer setHidden:YES];
        }
        [weakSelf.collectionView endHeaderRefreshing];
        [weakSelf.collectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.collectionView endHeaderRefreshing];

    }];
}
- (void)requestHighMoreData{
    __weak __typeof(self) weakSelf = self;
    // region_id       分类id //100.全部

    [CityApi requestQMNewCityListWithRegionID:self.regionID pageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
        [weakSelf.cityInfoDataItemArr addObjectsFromArray:cityItemArr];
        [weakSelf.collectionView endFooterRefreshing];
        [weakSelf.collectionView reloadData];
        if (cityItemArr.count < 25) {
            [weakSelf.collectionView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.cityInfoDataItemArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.collectionView endHeaderRefreshing];

    }];
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   
    
    return self.cityInfoDataItemArr.count;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    CityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CityCell class]) forIndexPath:indexPath];
    CityListItem *item = [self.cityInfoDataItemArr safeObjectAtIndex:indexPath.row];

    [cell refreshWithItem:item];
    return cell;
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
    CityListItem *item = [self.cityInfoDataItemArr safeObjectAtIndex:indexPath.row];
    NSString *str = item.title;
    CGFloat titleH = [str boundingRectWithSize:CGSizeMake(w - AdaptedWidth(20) , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.height;
    h += titleH;
    h += 5;
    return h;
}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, Adaptor_Value(10), 0, Adaptor_Value(10));

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
        
    

        [_collectionView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    }
    return _collectionView;
}

@end
