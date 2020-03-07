//
//  HomeViewController.m
//  IUang
//
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#define BannerHeight (LQScreemW * 340.0 / 640.0)

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "HomeCategaryCell.h"
#import "HomeSectionHeaderView.h"
#import "HomeVideoCell.h"
#import "HomeSectionFooterView.h"
#import "AVPlayerController.h"

#import "HomeTopCell.h"
#import "HomeCollectionHeaderView.h"
#import "HomeCollectionTopHeaderView.h"
#import "HomeItem.h"
#import "HomeApi.h"
#import "ListViewController.h"
#import "AllCategoryViewController.h"
#import "ShortVideoViewController.h"
#import "MineApi.h"
#import "MineItem.h"
@interface HomeViewController()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)SDCycleScrollView *infiniteView;//轮播
@property (nonatomic, strong) MJRefreshNormalHeader *refreshHeader;
@property (strong, nonatomic) HomeInfoItem *dataSource;//容器视图
@property (nonatomic,copy)NSArray<AdsItem *> *bannerList;

@property (nonatomic,strong)CommonAlertView *commonAlertView;
@property (nonatomic,strong)UpdateItem * updateItem;

@property (nonatomic,strong)CommonAlertView *freeAlertView;

@end

@implementation HomeViewController
+ (instancetype)controller
{
    HomeViewController *vc = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"HomeViewController"];
    return vc;
}
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self requestData];
    [self updateVesion];
    
    //如果是新用户 弹框限时免费
    if (RI.infoInitItem.is_new_user) {
        NSString *str;
        if (RI.infoInitItem.new_user_free_day > 0) {
            str = [NSString stringWithFormat:@"%ld天",(long)RI.infoInitItem.new_user_free_day];
        }else{
            str = [NSString stringWithFormat:@"%ld小时",(long)RI.infoInitItem.new_user_free_hour];

        }
        [self showFreeMsg:lqStrings(@"临时体验卡") submsg:[NSString stringWithFormat:lqLocalized(@"新用户可以免费体验%@哦～", nil),str] firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:lqStrings(@"好的")];
    }
    
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
    _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    _refreshHeader.stateLabel.hidden = YES;
    [_refreshHeader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];//设置圆圈的颜色
    _collectionView.mj_header = _refreshHeader;
    
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeVideoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HomeVideoCell class])];

}

#pragma mark - act
- (void)showMsg:(NSString *)msg firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.commonAlertView refreshUIWithTitle:msg titlefont:AdaptedFontSize(15) titleColor:TitleBlackColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.commonAlertView];
    [self.commonAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
//新用户 限时免费 免的和其他提示冲突了
- (void)showFreeMsg:(NSString *)msg submsg:(NSString *)submsg firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.freeAlertView refreshUIWithTitle:msg titlefont:AdaptedFontSize(15) titleColor:TitleBlackColor subtitle:submsg subTitleFont:AdaptedFontSize(12) subtitleColor:TitleBlackColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.freeAlertView];
    [self.freeAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
#pragma mark - net
- (void)requestData{
    
    //同时请求banner数据
    [self reqestBannerAds];
    
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestHotListSuccess:^(HomeInfoItem * _Nonnull homeInfoItem, NSString * _Nonnull msg) {
        weakSelf.dataSource = homeInfoItem;
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
    [HomeApi requestAdWithType:@"0" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        weakSelf.bannerList = adsItemArr;
        NSMutableArray *bannerUrlList = [NSMutableArray arrayWithCapacity:adsItemArr.count];
        for (AdsItem *item  in adsItemArr) {
            [bannerUrlList addObject:item.img];
        }
        [weakSelf.collectionView addSubview:weakSelf.infiniteView];
        weakSelf.infiniteView.imageURLStringsGroup = bannerUrlList;
        weakSelf.collectionView.mj_insetT =  weakSelf.infiniteView.lq_height;
        weakSelf.refreshHeader.ignoredScrollViewContentInsetTop = BannerHeight;

    } error:^(NSError *error, id resultObject) {
        
    }];
}
//检查是否有版本更新
- (void)updateVesion{
    __weak __typeof(self) weakSelf = self;
    [MineApi updateSuccess:^(UpdateItem * _Nonnull updateItem, NSString * _Nonnull msg) {
        weakSelf.updateItem = updateItem;
        if (updateItem.status == 2) {//强制
            [weakSelf showMsg:updateItem.content firstBtnTitle:lqStrings(@"") secBtnTitle:@"" singleBtnTitle:lqStrings(@"去升级")];

        }else{
            [weakSelf showMsg:updateItem.content firstBtnTitle:lqStrings(@"暂时不升级") secBtnTitle:lqStrings(@"去升级") singleBtnTitle:nil];

        }
    } error:^(NSError *error, id resultObject) {
        
    }];
}
#pragma mark - UICollectionViewDataSource
//设置容器中有多少个组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataSource.video.count + 1;
}
//设置每个组有多少个方块
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0 && _dataSource != nil) {
        return 3;
    }
    HomeVideoList *videoList = _dataSource.video[section - 1];
    return videoList.lists.count;
}
//设置方块的视图
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        HomeCategaryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeCategaryCell class]) forIndexPath:indexPath];
        if (indexPath.row == 0) {
            [cell refreshCellWithItem:_dataSource.most_new.firstObject des:@"最新上传"];
        }else if (indexPath.row == 1) {
            [cell refreshCellWithItem:_dataSource.most_play.firstObject des:@"最多播放"];

        }else if (indexPath.row == 2) {
            [cell refreshCellWithItem:_dataSource.most_love.firstObject des:@"最多点赞"];

        }
        return cell;

    }
    
    HomeVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HomeVideoCell class]) forIndexPath:indexPath];
    HomeVideoList *videoList = _dataSource.video[indexPath.section - 1];
    [cell refreshCellWithItem:videoList.lists[indexPath.row] videoType:videoList.type];
    return cell;
    
}
//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HomeSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([HomeSectionHeaderView class]) forIndexPath:indexPath];

        if (indexPath.section == 0) {
            [headerView refreshViewWithVideo:nil];
        } else {
            HomeVideoList *video = [_dataSource.video safeObjectAtIndex:indexPath.section - 1];

            [headerView refreshViewWithVideo:video];
        }
        headerView.headerViewTipBtnClickBlock = ^(UIButton * _Nonnull sender) {
            if (indexPath.section == 0) {
                AllCategoryViewController *vc = [[AllCategoryViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
                ListViewController *vc = [[ListViewController alloc] init];
                HomeVideoList *videoItem = [weakSelf.dataSource.video safeObjectAtIndex:indexPath.section - 1];
                vc.navTitle = videoItem.title;
                vc.tag = IntTranslateStr(videoItem.tag);
                vc.type = IntTranslateStr(videoItem.type);
                vc.text = videoItem.text.length > 0 ? videoItem.text : @"51778";
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }

        };
        return headerView;
    } else {
        if (indexPath.section % 2 == 0) {
            AdsItem *item = [_dataSource.ads safeObjectAtIndex:indexPath.section / 2];
            HomeSectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([HomeSectionFooterView class]) forIndexPath:indexPath];
            [footerView refreshViewWith:item];
            __weak __typeof(self) weakSelf = self;
            footerView.imageLoadSuccess = ^{
                [weakSelf.collectionView reloadData];
            };
            return footerView;
        }
    }
    return nil;
}
#pragma mark - UICollectionViewDelegateFlowLayout
//设置各个方块的大小尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {

        return CGSizeMake((LQScreemW - 15*2 - 25) / 3, Adaptor_Value(80));

    }
    return CGSizeMake((LQScreemW - 10*2 - 10) / 2 , Adaptor_Value(160));

}
//设置每一组的上下左右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 15, 20, 15);
    }else{
        return UIEdgeInsetsMake(0, 10, 20, 10);
    }

}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    if (section % 2 == 0) {
//        return CGSizeMake(LQScreemW, 50);
//    }
//    return  CGSizeMake(LQScreemW, 50 + Adaptor_Value(100));
//}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section % 2 == 0) {
        AdsItem *item = [_dataSource.ads safeObjectAtIndex:section / 2];
        if (item.imageSize.height > 0) {
            return CGSizeMake(LQScreemW, LQScreemW * item.imageSize.height / item.imageSize.width);
        }
        return  CGSizeMake(LQScreemW,Adaptor_Value(50));
    }
    return CGSizeZero;
}
#pragma mark - UICollectionViewDelegate
//方块被选中会调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击选择了第%ld组，第%ld个方块",indexPath.section,indexPath.row);
    if (indexPath.section == 0) {
        HotItem *item ;
        NSString *title;
        NSString *video_type;

        if (indexPath.row == 0) {
            item = self.dataSource.most_new.firstObject;
            title = lqStrings(@"最新上传");
            video_type = @"1001";

        }else if (indexPath.row == 1) {
            item = self.dataSource.most_play.firstObject;
            title = lqStrings(@"最多播放");
            video_type = @"1002";

        }else if (indexPath.row == 2) {
            item = self.dataSource.most_love.firstObject;
            title = lqStrings(@"最多点赞");
            video_type = @"1003";

        }
        ListViewController *vc = [[ListViewController alloc] init];
        HomeVideoList *videoItem = [self.dataSource.video safeObjectAtIndex:indexPath.section - 1];
        vc.navTitle = title;
        vc.tag = IntTranslateStr(videoItem.tag);
        vc.type = IntTranslateStr(videoItem.type);
        vc.text = videoItem.text.length > 0 ? videoItem.text : @"51778";
        vc.video_type = video_type;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        HomeVideoList *videoListItem = [_dataSource.video safeObjectAtIndex:indexPath.section - 1];
        HotItem *item = [videoListItem.lists safeObjectAtIndex:indexPath.row];

        if (videoListItem.type == VideoType_ShortVideo) {//短视频
            //判断是否还有观看次数
            if (RI.infoInitItem.rest_free_times == 0) {
                [self showMsg:lqStrings(@"今日观看次数已用完,明天再来吧,分享可获得无限观影哦") firstBtnTitle:lqStrings(@"分享") secBtnTitle:lqStrings(@"购买VIP") singleBtnTitle:@""];
                return;
            }

            ShortVideoViewController *vc = [ShortVideoViewController controllerWith:item];
            [self.navigationController pushViewController:vc animated:YES];


        }else{//av
            AVPlayerController *vc = [AVPlayerController controllerWith:item];
            [self.navigationController pushViewController:vc animated:YES];
        }

    }
    
}


#pragma  mark - SDCycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    AdsItem *item = [self.bannerList safeObjectAtIndex:index];
    [LqToolKit jumpAdventWithItem:item];

    
}


#pragma mark  - Lazy
- (SDCycleScrollView *)infiniteView{
    if (!_infiniteView) {
        _infiniteView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -BannerHeight, LQScreemW, BannerHeight) delegate:self placeholderImage:nil];
        _infiniteView.backgroundColor = [UIColor clearColor];
        _infiniteView.boworrWidth = LQScreemW;
        _infiniteView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
        _infiniteView.cellSpace = 0;
        _infiniteView.showPageControl = YES;
    }
    return _infiniteView;
}
- (CommonAlertView *)commonAlertView{
    if (!_commonAlertView) {
        _commonAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _commonAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {

            if (index == 1) {//分享
                [weakSelf.commonAlertView removeFromSuperview];
                weakSelf.commonAlertView = nil;
                if ([str isEqualToString:lqStrings(@"暂时不升级")]) {
                    
                }else{
                    [LSVProgressHUD showInfoWithStatus:@"分享"];
                    
                }
            }else if (index == 2) {//购买VIP
                [weakSelf.commonAlertView removeFromSuperview];
                weakSelf.commonAlertView = nil;
                if ([str isEqualToString:lqStrings(@"去升级")]) {
                    NSURL *url = [NSURL URLWithString:weakSelf.updateItem.download_url];
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    [LSVProgressHUD showInfoWithStatus:@"购买VIP"];
                    
                }
            }else if (index == 3){
                if ([str isEqualToString:lqStrings(@"去升级")]) {
                    NSURL *url = [NSURL URLWithString:weakSelf.updateItem.download_url];
                    [[UIApplication sharedApplication] openURL:url];
                }else if ([str isEqualToString:lqStrings(@"好的")]){
                    [weakSelf.commonAlertView removeFromSuperview];
                    weakSelf.commonAlertView = nil;
                }
            }else if (index == 4){
                if ([weakSelf.commonAlertView.titleStr containsString:lqStrings(@"今日观看次数已用完")]) {
                    [weakSelf.commonAlertView removeFromSuperview];
                    weakSelf.commonAlertView = nil;
                }//强制升级 不给消失

            }
        };
    }
    return _commonAlertView;
}

- (CommonAlertView *)freeAlertView{
    if (!_freeAlertView) {
        _freeAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _freeAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {
            [weakSelf.freeAlertView removeFromSuperview];
            weakSelf.freeAlertView = nil;
        };
    }
    return _freeAlertView;
}
@end
