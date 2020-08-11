//
//  SearchViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/8/11.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "SearchViewController.h"
#import "HomeVideoCell.h"
#import "SearchCollectionHeaderView.h"
#import "ShortVideoViewController.h"

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *customCollectionView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIView *header;
@property (nonatomic,strong)UIButton *backBtn;
@property (nonatomic,strong)UITextField *textF;
@property (nonatomic,strong)EnlargeTouchSizeButton *searchBtn;

@property (nonatomic,strong)NSArray *hotArr;
@property (nonatomic,strong)NSString *searchText;
@end

@implementation SearchViewController
#pragma mark - 重写
///右滑返回功能，默认开启（YES）
- (BOOL)gestureRecognizerShouldBegin{
    return NO;
}
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _hotArr = @[@"自拍",@"口活",@"3P",@"自慰",@"学生妹",@"人妻",@"双飞",@"后入",@"情趣",@"模特",@"巨乳",@"主播",@"网红",@"偷拍",@"女同",@"强奸",@"制服",@"颜射",@"约炮",@"丝袜",@"群P",@"SM",@"萝莉",@"三级片",@"门事件",@"欧美"];
    _searchText = _hotArr.firstObject;
    [self configUI];
    [self requestData];
        
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.header];
    [self.header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(weakSelf.view);
    }];
    
    [self.view addSubview:self.customCollectionView];

    [self.customCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.header.mas_bottom);
    }];
    
    
}



#pragma mark - act
- (void)backBtnClick:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBtnClick:(UIButton *)sender{
    [self requestData];
}
/**
 * 监听textField值的变化
 */
-(void)textFDidChange:(UITextField *)textField
{
    
}
#pragma mark -  net


- (void)requestData{
   __weak __typeof(self) weakSelf = self;
    NSString *url;
    if (self.searchType == SearchType_AV) {
        url = @"/api/video_av/search";
    }else if (self.searchType == SearchType_vedio) {
        url = @"/api/video/search";
    }else if (self.searchType == SearchType_cartoon) {
        url = @"/api/cartoon/search";
    }
    [LSVProgressHUD show];
    [HomeApi searchWithText:self.searchText page_index:@"0" page_size:@"20" url:url Success:^(NSArray * _Nonnull searchArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = searchArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:searchArr];
        if (searchArr.count >= 20 ) {
            [weakSelf.customCollectionView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customCollectionView.mj_footer setHidden:NO];

        }else{
            [weakSelf.customCollectionView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customCollectionView.mj_footer setHidden:YES];
        }
        [weakSelf.customCollectionView endHeaderRefreshing];
        [weakSelf.customCollectionView reloadData];
        [LSVProgressHUD dismiss];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customCollectionView endHeaderRefreshing];
    }];
}

- (void)requestMoreData{
   __weak __typeof(self) weakSelf = self;
    NSString *url;
    [LSVProgressHUD show];
    [HomeApi searchWithText:self.searchText page_index:IntTranslateStr(self.pageIndex) page_size:@"20" url:url Success:^(NSArray * _Nonnull searchArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:searchArr];
        [weakSelf.customCollectionView endFooterRefreshing];
        [weakSelf.customCollectionView reloadData];
        if (searchArr.count < 20) {
            [weakSelf.customCollectionView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;

        }
        [LSVProgressHUD dismiss];

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
    [cell refreshCellWithItem:hotItem videoType:VideoType_ShortVideo];
    [cell setLoveBtnAppear:YES];

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

    //判断是否还有观看次数
//            if (RI.infoInitItem.rest_free_times == 0) {
//                [self showMsg:lqStrings(@"今日观看次数已用完,明天再来吧,分享可获得无限观影哦") firstBtnTitle:lqStrings(@"分享") secBtnTitle:lqStrings(@"购买VIP") singleBtnTitle:@""];
//                return;
//            }

    ShortVideoViewController *vc = [ShortVideoViewController controllerWith:item];
    [self.navigationController pushViewController:vc animated:YES];
    
}
//方块取消选中会调用
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"取消选择第%ld组，第%ld个方块",indexPath.section,indexPath.row);
}

//设置顶部视图和底部视图
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    __weak __typeof(self) weakSelf = self;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       
        if (indexPath.section == 0) {
            //获取顶部视图
            SearchCollectionHeaderView *headerView=[SearchCollectionHeaderView headerViewWithCollectionView:collectionView forIndexPath:indexPath];
            [headerView configUIWithArr:self.hotArr];
            headerView.hotcellClickBlock = ^(NSInteger index) {
                weakSelf.searchText = [weakSelf.hotArr safeObjectAtIndex:index];
                weakSelf.textF.text = weakSelf.searchText;
            };
            return headerView;
        }
    
    }
    return nil;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return  CGSizeMake(LQScreemW, [self caculateHeight]);
}

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
#pragma mark - lazy
- (UICollectionView *)customCollectionView{
      if (!_customCollectionView) {
          UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
          //设置collectionView滚动方向
          [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
          _customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];


          _customCollectionView.backgroundColor = ThemeBlackColor;
          [_customCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeVideoCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([HomeVideoCell class])];
          
          //注册容器视图中显示的顶部视图
          [_customCollectionView registerClass:[SearchCollectionHeaderView class]
             forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                    withReuseIdentifier:NSStringFromClass([SearchCollectionHeaderView class])];
          _customCollectionView.delegate = self;
          _customCollectionView.dataSource = self;
          _customCollectionView.showsVerticalScrollIndicator = NO;
          _customCollectionView.showsHorizontalScrollIndicator = NO;
          

    

      }
      return _customCollectionView;
}
- (UIView *)header{
    if (!_header) {
        _header = [UIView new];
        UIView *contentV = [UIView new];
        [_header addSubview:contentV];
        __weak __typeof(self) weakSelf = self;
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(NavMaxY);
            make.edges.mas_equalTo(weakSelf.header);
        }];
        
        _backBtn = [[UIButton alloc] init];
        [_backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [contentV addSubview:_backBtn];
        [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(10));
            make.centerY.mas_equalTo(contentV);
            make.height.width.mas_equalTo(Adaptor_Value(20));
        }];
        
        _textF = [[UITextField alloc] init];
        [contentV addSubview:_textF];
        [_textF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(Adaptor_Value(50));
            make.left.mas_equalTo(weakSelf.backBtn.mas_right).offset(Adaptor_Value(15));
            make.centerY.mas_equalTo(contentV);
            make.right.mas_equalTo(contentV);

        }];
        _textF.textColor = TitleWhiteColor;
        [_textF addTarget:self action:@selector(textFDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textF.font = AdaptedFontSize(15);
        _textF.text = self.hotArr.firstObject;
        
        _searchBtn = [[EnlargeTouchSizeButton alloc] init];
        [_searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchDown];
        [_searchBtn setTitle:lqStrings(@"搜索") forState:UIControlStateNormal];
        [_searchBtn setTitleColor:TitleWhiteColor forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = AdaptedFontSize(15);
        [contentV addSubview:_searchBtn];
        [_searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(contentV).offset(-Adaptor_Value(10));
            make.centerY.mas_equalTo(contentV);
            make.height.width.mas_equalTo(Adaptor_Value(50));
        }];
        
        
    }
    return _header;
}
@end
