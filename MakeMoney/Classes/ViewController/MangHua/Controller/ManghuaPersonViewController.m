//
//  ManghuaPersonViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/9/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ManghuaPersonViewController.h"
#import "ManghuaCategoryCell.h"

@interface ManghuaPersonViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ManghuaPersonViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    if (@available(iOS 11.0, *)) {
        _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(weakSelf.view);
    }];
    
    
}


#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
//    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
//        weakSelf.pageIndex = zhuanTiHomeItemArr.count ;
//        weakSelf.dataArr = [NSMutableArray arrayWithArray:zhuanTiHomeItemArr];
//        if (zhuanTiHomeItemArr.count >= 25 ) {
//            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
//            [weakSelf.customTableView.mj_footer setHidden:NO];
//
//        }else{
//            [weakSelf.customTableView endHeaderRefreshing];
//            //消除尾部"没有更多数据"的状态
//            [weakSelf.customTableView.mj_footer setHidden:YES];
//        }
//        [weakSelf.customTableView endHeaderRefreshing];
//        [weakSelf.customTableView reloadData];
//    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        [weakSelf.customTableView endHeaderRefreshing];
//
//    }];
    [weakSelf.customTableView endHeaderRefreshing];
    [weakSelf.customTableView reloadData];
    
}




- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
//    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
//        [weakSelf.dataArr addObjectsFromArray:zhuanTiHomeItemArr];
//        [weakSelf.customTableView endFooterRefreshing];
//        [weakSelf.customTableView reloadData];
//        if (zhuanTiHomeItemArr.count < 25) {
//            [weakSelf.customTableView endRefreshingWithNoMoreData];
//        }else{
//            weakSelf.pageIndex = weakSelf.dataArr.count ;
//
//        }
//    } error:^(NSError *error, id resultObject) {
//        [LSVProgressHUD showError:error];
//        [weakSelf.customTableView endFooterRefreshing];
//
//
//    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManghuaCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ManghuaCategoryCell class]) forIndexPath:indexPath];
    [cell refreshWithItem:nil];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(250);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ZhuanTiHomeItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];


    
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
        
        [_customTableView registerClass:[ManghuaCategoryCell class] forCellReuseIdentifier:NSStringFromClass([ManghuaCategoryCell class])];
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
