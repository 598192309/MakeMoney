//
//  AllCategoryViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//  全部分类

#import "AllCategoryViewController.h"
#import "ZHuanTiCell.h"
#import "HomeApi.h"
#import "HomeItem.h"
#import "ListViewController.h"
#import "ZhuanTiItem.h"
@interface AllCategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation AllCategoryViewController
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
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];

}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationTextLabel.text = lqStrings(@"全部分类");
}



#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestAllHotListwithPageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = hotItemArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:hotItemArr];
        if (hotItemArr.count >= 25 ) {
            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customTableView.mj_footer setHidden:NO];
    
        }else{
            [weakSelf.customTableView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customTableView.mj_footer setHidden:YES];
        }
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];
    }];

    
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestAllHotListwithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:hotItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (hotItemArr.count < 25) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];
    }];
}



#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHuanTiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZHuanTiCell class]) forIndexPath:indexPath];
    ZhuanTiHomeItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshWithItem: item  downImageType:@"分类"];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(180);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ListViewController *vc = [[ListViewController alloc] init];
    ZhuanTiHomeItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    vc.navTitle = item.title;
    vc.tag = IntTranslateStr(item.tag);
    vc.type = IntTranslateStr(item.type);
    vc.text = item.text.length > 0 ? item.text : @"51778";
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


#pragma mark - lazy
- (UITableView *)customTableView{
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.backgroundColor = ThemeBlackColor;
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        [_customTableView registerClass:[ZHuanTiCell class] forCellReuseIdentifier:NSStringFromClass([ZHuanTiCell class])];
//        //高度自适应
//        _customTableView.estimatedRowHeight=Adaptor_Value(50);
//        _customTableView.rowHeight=UITableViewAutomaticDimension;
        
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];

    }
    return _customTableView;
}

@end
