//
//  RechargeDetailViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//  充值记录

#import "RechargeDetailViewController.h"
#import "RechargeDetailCell.h"
#import "MineApi.h"
#import "MineItem.h"

@interface RechargeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation RechargeDetailViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    [self setUpNav];
    
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
    [self.view addSubview:self.backImageV];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
    
    
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
 
    
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"充值记录");
}
#pragma mark - act

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestPayRecordswithPageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull payRecordItemArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = payRecordItemArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:payRecordItemArr];
        if (payRecordItemArr.count >= 25 ) {
            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customTableView.mj_footer setHidden:NO];

        }else{
            [weakSelf.customTableView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customTableView.mj_footer setHidden:YES];
        }
        [weakSelf.customTableView reloadData];
        [weakSelf.customTableView endHeaderRefreshing];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];
}

-(void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestPayRecordswithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull payRecordItemArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:payRecordItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (payRecordItemArr.count < 25) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endFooterRefreshing];

        
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
    RechargeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RechargeDetailCell class]) forIndexPath:indexPath];
    PayRecordItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item];
    return cell;


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
        _customTableView.backgroundColor = [UIColor clearColor];
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(100);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        
        [_customTableView registerClass:[RechargeDetailCell class] forCellReuseIdentifier:NSStringFromClass([RechargeDetailCell class])];
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];
    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}

@end
