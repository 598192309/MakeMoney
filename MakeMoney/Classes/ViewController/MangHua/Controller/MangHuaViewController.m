//
//  MangHuaViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/8/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "MangHuaViewController.h"
#import "HomeCollectionTopHeaderView.h"
#import "ManghuaCell.h"
#import "SearchViewController.h"
#import "MangHuaApi.h"
#import "HomeCollectionHeaderView.h"
@interface MangHuaViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;//容器视图


@property (nonatomic,strong)NSMutableArray *bannerImageUrlArr;

@property (nonatomic,strong)NSArray *bottomAdsArr;

@property (nonatomic,strong)NSArray *adsItemArr;
@property (nonatomic,strong)MangHuaItem *mangHuaDataItem;

@end

@implementation MangHuaViewController
#pragma mark - 重写
- (void)navigationRightBtnClick:(UIButton *)button{

}

-(void)navigationRightSecBtnClick:(UIButton*)button{
//    [LSVProgressHUD showInfoWithStatus:[button titleForState:UIControlStateNormal]];
    SearchViewController *vc = [SearchViewController new];
    vc.searchType = SearchType_vedio;
    [self.navigationController pushViewController:vc animated:YES];

}
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setUpNav];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self requestData];
    [self reqestBannerAds];
    

}

#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;

    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
        make.bottom.mas_equalTo(weakSelf.view);
    }];

}

- (void)setUpNav{
    __weak __typeof(self) weakSelf = self;

    [self addNavigationView];
    [self.navigationRightBtn setTitle:lqStrings(@"分类") forState:UIControlStateNormal];
    [self.navigationRightBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.navigationView).with.offset(-Adaptor_Value(10));
        make.centerY.mas_equalTo(weakSelf.navigationTextLabel);
        make.height.mas_equalTo(Adaptor_Value(40));
        make.width.mas_equalTo(Adaptor_Value(40));

    }];
    [self.navigationRightSecBtn setTitle:lqStrings(@"搜你想搜看你想看") forState:UIControlStateNormal];
    [self.navigationRightSecBtn setBackgroundColor:TitleWhiteColor];
    [self.navigationRightSecBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.navigationRightSecBtn setIconInLeftWithSpacing:5];
    [self.navigationRightSecBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.navigationRightBtn.mas_left).offset(-Adaptor_Value(5));
        make.left.mas_equalTo(Adaptor_Value(10));
        make.height.mas_equalTo(Adaptor_Value(30));
        make.centerY.mas_equalTo(weakSelf.navigationRightBtn);
    }];
    ViewRadius(self.navigationRightSecBtn, Adaptor_Value(15));
    self.navigationBackButton.hidden = YES;
}
#pragma mark - net
- (void)requestData{
    __weak __typeof(self) weakSelf = self;

    [MangHuaApi requestCartoonHomeDataSuccess:^(NSInteger status, NSString * _Nonnull msg,MangHuaItem *mangHuaItem) {
        weakSelf.mangHuaDataItem = mangHuaItem;
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

    [HomeApi requestAdWithType:@"10" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        for (AdsItem *item  in adsItemArr) {
            [weakSelf.bannerImageUrlArr addObject:item.img];
        }
        weakSelf.adsItemArr = adsItemArr;
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
    if (section == 0 ) {
        return self.mangHuaDataItem.hotLists.count;
    }
    else if (section == 1 ) {
        return self.mangHuaDataItem.NewLists.count;
    }
    else if (section == 2 ) {
        return self.mangHuaDataItem.guessLists.count;
    }

    return 0;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //获取cell视图，内部通过去缓存池中取，如果缓存池中没有，就自动创建一个新的cell
    ManghuaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ManghuaCell class]) forIndexPath:indexPath];
    MangHuaDetailItem *item;
    if (indexPath.section == 0) {
        item = [self.mangHuaDataItem.hotLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 1) {
        item = [self.mangHuaDataItem.NewLists safeObjectAtIndex:indexPath.row];
    }else if (indexPath.section == 2) {
        item = [self.mangHuaDataItem.guessLists safeObjectAtIndex:indexPath.row];
    }
    [cell refreshWithItem:item];
    return cell;
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {

        if (indexPath.section == 0) {
            HomeCollectionTopHeaderView *headerView=[HomeCollectionTopHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];

            //获取顶部视图
            [headerView refreshUIWithTitle:lqStrings(@"大家都在看") titleImageStr:@"" tipBtnTitle:lqStrings(@">") bannerImageUrlArr:self.bannerImageUrlArr];
            headerView.headerViewTipBtnClickBlock = ^(UIButton * _Nonnull sender) {

            };
            //点击banner
            headerView.bannerClickBlock = ^(NSInteger index){
                AdsItem *item = [self.adsItemArr safeObjectAtIndex:index];
                [LqToolKit jumpAdventWithItem:item];
            };
            return headerView;
        }
         //获取顶部视图
         NSString *title;
         NSString *subTitle;
         NSString *imageStr;

         if (indexPath.section == 1) {
             title = lqStrings(@"每日更新");
             subTitle = lqStrings(@">");
             imageStr = @"";
         }else{
             title = lqStrings(@"猜你喜欢");
             subTitle = lqStrings(@"");
             imageStr = @"";

         }
        HomeCollectionHeaderView *headerView=[HomeCollectionHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
         [headerView refreshUIWithTitle:title titleImageStr:imageStr tipBtnTitle:subTitle];
         headerView.headerViewTipBtnClickBlock = ^(UIButton * _Nonnull sender) {
             
         };
        return headerView;


    }

    return nil;

}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int row = 3;
    CGFloat w = (LQScreemW - 2 * Adaptor_Value(10) - 2 * Adaptor_Value(5)) / row;
    CGFloat h = Adaptor_Value(220);
    return CGSizeMake(w , h);

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
        layout.minimumInteritemSpacing = Adaptor_Value(5);
        //创建容器视图
        _collectionView=[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate=self;//设置代理
        _collectionView.dataSource=self;//设置数据源
        _collectionView.backgroundColor = ThemeBlackColor;
        
        [_collectionView registerClass:[ManghuaCell class] forCellWithReuseIdentifier:NSStringFromClass([ManghuaCell class])];
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
