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
#import "CityListSearchView.h"
#import "CityDetailViewController.h"

@interface CityListViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图

@property (nonatomic,strong)NSMutableArray *cityInfoDataItemArr;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)CityListSearchView *searchView;
@property (nonatomic,strong)NSMutableArray *searchViewDataArr;

@end

@implementation CityListViewController
#pragma mark -重写
- (void)navigationRightBtnClick:(UIButton *)button{
    
    //获取list
    [self requestList:button];

}
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
- (void)dealloc{
    
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    
    //nav
    [self addNavigationView];
    self.navigationTextLabel.text = self.navStr;
    if(self.cityType == CityType_QM || self.cityType == CityType_High){
        [self.navigationRightBtn setTitle:lqStrings(@"全部") forState:UIControlStateNormal];
    }

}
#pragma mark - act
//弹框
- (void)showSearchView{
    __weak __typeof(self) weakSelf = self;
    //弹框
    [weakSelf.view addSubview:self.searchView];
    weakSelf.searchView.dataArr = weakSelf.searchViewDataArr;

    [weakSelf.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(weakSelf.view);
    }];
    weakSelf.searchView.closeBlock = ^() {
        [weakSelf.searchView removeFromSuperview];
        weakSelf.searchView = nil;
    };
    
    weakSelf.searchView.cellClickBlock = ^(NSIndexPath * _Nonnull indexpath) {
        //根据region 查询
        CityListItem *item = [weakSelf.searchViewDataArr safeObjectAtIndex:indexpath.row];
        weakSelf.regionID = item.region_id;
        [weakSelf checkInfoWithRegionID];
        [weakSelf.searchView removeFromSuperview];
        weakSelf.searchView = nil;
        if(weakSelf.cityType == CityType_QM || self.cityType == CityType_High){
            [weakSelf.navigationRightBtn setTitle:item.region_name forState:UIControlStateNormal];
        }
    };
}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD show];
    [CityApi requestQMNewCityListWithType:IntTranslateStr(self.cityType) pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
        [LSVProgressHUD dismiss];
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
    [LSVProgressHUD show];
    [CityApi requestHighCityListWithRegionID:self.regionID pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
        [LSVProgressHUD dismiss];

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

    [CityApi requestHighCityListWithRegionID:self.regionID pageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
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
//点击全部 获取list
-(void)requestList:(UIButton *)sender{
    sender.userInteractionEnabled= NO;
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    if (self.cityType == CityType_QM) {
        [CityApi requestCityListQMSearchListSuccess:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
            [LSVProgressHUD dismiss];
            sender.userInteractionEnabled = YES;
            weakSelf.searchViewDataArr = [NSMutableArray arrayWithArray:cityItemArr];
            
            //弹框
            [weakSelf showSearchView];
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
            sender.userInteractionEnabled = YES;

        }];
    }else{
        [CityApi requestCityListHighSearchListSuccess:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
            [LSVProgressHUD dismiss];
            sender.userInteractionEnabled = YES;
            weakSelf.searchViewDataArr = [NSMutableArray arrayWithArray:cityItemArr];
            //弹框
            [weakSelf showSearchView];
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
            sender.userInteractionEnabled = YES;
        }];
    }
}

//根据region 查询
- (void)checkInfoWithRegionID{
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    if (self.cityType == CityType_QM) {
        [CityApi requestQMCityListWithRegionID:self.regionID pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
            [LSVProgressHUD dismiss];
                weakSelf.pageIndex = cityItemArr.count ;
                weakSelf.cityInfoDataItemArr = [NSMutableArray arrayWithArray:cityItemArr];
                if (cityItemArr.count >= 25 ) {
                    [weakSelf.collectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestQMCityListWithRegionIDMoreData)];
                    [weakSelf.collectionView.mj_footer setHidden:NO];
            
                }else{
                    [weakSelf.collectionView endHeaderRefreshing];
                    //消除尾部"没有更多数据"的状态
                    [weakSelf.collectionView.mj_footer setHidden:YES];
                }
                [weakSelf.collectionView endHeaderRefreshing];
                [weakSelf.collectionView reloadData];
                
        } error:^(NSError *error, id resultObject) {
            [weakSelf.collectionView endHeaderRefreshing];
            [LSVProgressHUD showError:error];
        }];
    }else{
//        [CityApi requestHighCityListWithRegionID:regionID pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
//
//        } error:^(NSError *error, id resultObject) {
//
//        }];
        [self requestHighData];
    }
}

- (void)requestQMCityListWithRegionIDMoreData{
    __weak __typeof(self) weakSelf = self;
    [CityApi requestQMCityListWithRegionID:self.regionID pageIndex:IntTranslateStr(self.cityInfoDataItemArr.count) page_size:@"25" Success:^(NSArray * _Nonnull cityItemArr, NSString * _Nonnull msg) {
        [weakSelf.cityInfoDataItemArr addObjectsFromArray:cityItemArr];
        [weakSelf.collectionView endFooterRefreshing];
        [weakSelf.collectionView reloadData];
        if (cityItemArr.count < 25) {
            [weakSelf.collectionView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.cityInfoDataItemArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [weakSelf.collectionView endFooterRefreshing];

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
//    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    CityListItem *item = [self.cityInfoDataItemArr safeObjectAtIndex:indexPath.row];

    CityDetailViewController *vc = [[CityDetailViewController alloc] init];
    vc.ID = item.ID;
    [self.navigationController pushViewController:vc animated:YES];
    
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

- (CityListSearchView *)searchView{
    if (!_searchView) {
        _searchView = [CityListSearchView new];
    }
    return _searchView;
}

@end
