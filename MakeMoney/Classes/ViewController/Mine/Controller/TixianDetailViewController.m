//
//  TixianDetailViewController.m
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  提现明细

#import "TixianDetailViewController.h"
#import "TixianDetailCell.h"
#import "MineItem.h"
#import "MineApi.h"

@interface TixianDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation TixianDetailViewController
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
    self.navigationTextLabel.text = lqStrings(@"提现明细");
}
#pragma mark - act

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestCashDetailwithPageIndex:@"0" page_size:@"25" Success:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull tixianDetailItemArr) {
        weakSelf.pageIndex = tixianDetailItemArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:tixianDetailItemArr];
        if (tixianDetailItemArr.count >= 25 ) {
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
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
    }];
    
}
- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestCashDetailwithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull tixianDetailItemArr) {
        [weakSelf.dataArr addObjectsFromArray:tixianDetailItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (tixianDetailItemArr.count < 25) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
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
    TixianDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TixianDetailCell class]) forIndexPath:indexPath];
    TixianDetailItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
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
        _customTableView.estimatedRowHeight=Adaptor_Value(120);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        
        [_customTableView registerClass:[TixianDetailCell class] forCellReuseIdentifier:NSStringFromClass([TixianDetailCell class])];

        
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
