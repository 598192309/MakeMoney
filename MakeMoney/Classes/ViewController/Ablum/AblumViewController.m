//
//  AblumViewController.m
//  MakeMoney
//
//  Created by JS on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//  写真

#import "AblumViewController.h"
#import "AblumCollectionCell.h"
#import "AblumItem.h"
#import "AblumApi.h"
#import "AblumDetailViewController.h"

@interface AblumViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation AblumViewController
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

}

#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.top.mas_equalTo(weakSelf.view);
    }];

}

#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [AblumApi requestAblumWithPageIndex:@"0" page_size:@"25" Success:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull ablumItemArr) {
            weakSelf.pageIndex = ablumItemArr.count;
            weakSelf.dataArr = [NSMutableArray arrayWithArray:ablumItemArr];
            if (ablumItemArr.count >= 25 ) {
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
        [weakSelf.collectionView endHeaderRefreshing];
        [weakSelf.collectionView reloadData];
    }];
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [AblumApi requestAblumWithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull ablumItemArr) {
        [weakSelf.dataArr addObjectsFromArray:ablumItemArr];
        [weakSelf.collectionView endFooterRefreshing];
        [weakSelf.collectionView reloadData];
        if (ablumItemArr.count < 25) {
            [weakSelf.collectionView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
      [weakSelf.collectionView endFooterRefreshing];
      [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   

    return self.dataArr.count;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    AblumCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([AblumCollectionCell class]) forIndexPath:indexPath];
    AblumItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshAblumWithItem:item];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat row = 2.0;
    CGFloat w = (LQScreemW) / row;
    CGFloat h = Adaptor_Value(270);
    return CGSizeMake(w , h);

}
//- (CGFloat)caculateCellHeight:(NSIndexPath *)indexPath{
//    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - Adaptor_Value(5)) / 3;
//
//    CGFloat h = 0;
//    h += Adaptor_Value(180);//图片固定高度
//    h += Adaptor_Value(5);
//    CityListItem *item;
//    if (indexPath.section == 0) {
//        item = [self.cityInfoDataItem.upmarketLists safeObjectAtIndex:indexPath.row];
//    }else if (indexPath.section == 1) {
//        item = [self.cityInfoDataItem.hotLists safeObjectAtIndex:indexPath.row];
//    }else if (indexPath.section == 2) {
//        item = [self.cityInfoDataItem.theNewLists safeObjectAtIndex:indexPath.row];
//    }
//    NSString *str = item.title;
//    CGFloat titleH = [str boundingRectWithSize:CGSizeMake(w - AdaptedWidth(20) , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:AdaptedFontSize(15)} context:nil].size.height;\
//    h += titleH;
//    h += 5;
//    return h;
//}
////设置每一组的上下左右间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, Adaptor_Value(10), 0, Adaptor_Value(10));
//
//}

#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    AblumDetailViewController *vc = [[AblumDetailViewController alloc] init];
    vc.ablumData = [self.dataArr safeObjectAtIndex:indexPath.row];
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
        
        [_collectionView registerClass:[AblumCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([AblumCollectionCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        

        [_collectionView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_collectionView beginHeaderRefreshing];
    }
    return _collectionView;
}
@end
