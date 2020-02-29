//
//  ZhuanTiViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ZhuanTiViewController.h"
#import "ZHuanTiCell.h"
#import "ZhuanTiApi.h"
#import "ZhuanTiItem.h"
@interface ZhuanTiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ZhuanTiViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
        
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
        make.top.mas_equalTo(TopAdaptor_Value(25));
    }];
    
    
}




#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:@"1" page_size:@"25" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = 2;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:zhuanTiHomeItemArr];
        if (zhuanTiHomeItemArr.count >= 25 ) {
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
    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:zhuanTiHomeItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (zhuanTiHomeItemArr.count < 25) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex += 1;
            
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
    [cell refreshWithItem: item];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(180);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [LSVProgressHUD showInfoWithStatus:@"点击"];
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
        
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];

    }
    return _customTableView;
}

@end
