//
//  ListViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ListViewController.h"
#import "HomeVideoCell.h"
#import "ShortVideoViewController.h"
#import "AVPlayerController.h"

@interface ListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *customCollectionView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ListViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setUpNav];
        
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.customCollectionView];

    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(TopAdaptor_Value(NavMaxY));
    }];
    
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationTextLabel.text = self.navTitle;
}




#pragma mark -  net
//-(void)requestData{
//    __weak __typeof(self) weakSelf = self;
//    [HomeApi requestHotCategoryListwithType_id:self.tag pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
//            weakSelf.pageIndex = hotItemArr.count ;
//            weakSelf.dataArr = [NSMutableArray arrayWithArray:hotItemArr];
//            if (hotItemArr.count >= 25 ) {
//                [weakSelf.customCollectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
//                [weakSelf.customCollectionView.mj_footer setHidden:NO];
//
//            }else{
//                [weakSelf.customCollectionView endHeaderRefreshing];
//                //消除尾部"没有更多数据"的状态
//                [weakSelf.customCollectionView.mj_footer setHidden:YES];
//            }
//            [weakSelf.customCollectionView endHeaderRefreshing];
//            [weakSelf.customCollectionView reloadData];
//    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        [weakSelf.customCollectionView endHeaderRefreshing];
//    }];
//
//
//}
//
//
//- (void)requestMoreData{
//    __weak __typeof(self) weakSelf = self;
//    [HomeApi requestHotCategoryListwithType_id:self.tag pageIndex: page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
//        [weakSelf.dataArr addObjectsFromArray:hotItemArr];
//        [weakSelf.customCollectionView endFooterRefreshing];
//        [weakSelf.customCollectionView reloadData];
//        if (hotItemArr.count < 25) {
//            [weakSelf.customCollectionView endRefreshingWithNoMoreData];
//        }else{
//            weakSelf.pageIndex = weakSelf.dataArr.count ;
//
//        }
//    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        [weakSelf.customCollectionView endHeaderRefreshing];
//    }];
//}

- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestHotListMorewithTag:self.tag text:self.text type:self.type pageIndex:@"0" page_size:@"15" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = hotItemArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:hotItemArr];
        if (hotItemArr.count >= 15 ) {
            [weakSelf.customCollectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customCollectionView.mj_footer setHidden:NO];

        }else{
            [weakSelf.customCollectionView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customCollectionView.mj_footer setHidden:YES];
        }
        [weakSelf.customCollectionView endHeaderRefreshing];
        [weakSelf.customCollectionView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customCollectionView endHeaderRefreshing];
    }];
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestHotListMorewithTag:self.tag text:self.text type:self.type pageIndex:IntTranslateStr(self.pageIndex) page_size:@"15" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
       [weakSelf.dataArr addObjectsFromArray:hotItemArr];
       [weakSelf.customCollectionView endFooterRefreshing];
       [weakSelf.customCollectionView reloadData];
       if (hotItemArr.count < 15) {
           [weakSelf.customCollectionView endRefreshingWithNoMoreData];
       }else{
           weakSelf.pageIndex = weakSelf.dataArr.count ;

       }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customCollectionView endHeaderRefreshing];
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

    HomeVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeVideoCell class]) forIndexPath:indexPath];
    HotItem *hotItem = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshCellWithItem:hotItem videoType:self.type.integerValue];
    return cell;
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((LQScreemW - 10*2 - 10) / 2 , Adaptor_Value(160));

}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 20, 10);

}


#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    HotItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];

    if (self.type.integerValue == VideoType_ShortVideo) {//短视频
        //判断是否还有观看次数
//            if (RI.infoInitItem.rest_free_times == 0) {
//                [self showMsg:lqStrings(@"今日观看次数已用完,明天再来吧,分享可获得无限观影哦") firstBtnTitle:lqStrings(@"分享") secBtnTitle:lqStrings(@"购买VIP") singleBtnTitle:@""];
//                return;
//            }

        ShortVideoViewController *vc = [ShortVideoViewController controllerWith:item];
        [self.navigationController pushViewController:vc animated:YES];


    }else{//av
        AVPlayerController *vc = [AVPlayerController controllerWith:item];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}
#pragma mark - lazy
- (UICollectionView *)customCollectionView{
      if (!_customCollectionView) {
          UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
          //设置collectionView滚动方向
          [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
          _customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];


          _customCollectionView.backgroundColor = ThemeBlackColor;
          [_customCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeVideoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HomeVideoCell class])];
          _customCollectionView.delegate = self;
          _customCollectionView.dataSource = self;
          _customCollectionView.showsVerticalScrollIndicator = NO;
          _customCollectionView.showsHorizontalScrollIndicator = NO;
          
          [_customCollectionView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
          [_customCollectionView beginHeaderRefreshing];
    
          
      }
      return _customCollectionView;
}


@end
