//
//  RechargeCenterViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  充值中心

#import "RechargeCenterViewController.h"
#import "RechargeCenterCell.h"
#import "RechargeCenterCustomView.h"

@interface RechargeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)RechargeCenterCustomView *rechargeCenterCustomView;
@end

@implementation RechargeCenterViewController
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
    [self requestData];
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
    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.rechargeCenterCustomView];
    [self.rechargeCenterCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self rechargeCenterCustomViewAct];
    
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"充值中心");
    [self.navigationRightBtn setTitle:lqStrings(@"充值记录") forState:UIControlStateNormal];
}
#pragma mark - act
- (void)rechargeCenterCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    self.rechargeCenterCustomView.rechargeCenterViewCheckBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    };
}
#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
  

    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
//    return self.dataArr.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RechargeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RechargeCenterCell class]) forIndexPath:indexPath];
    [cell refreshUIWithItem:nil];
    
    cell.rechargeCenterBuyBtnClickBlock = ^(UIButton * _Nonnull sender) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    };
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
        
        [_customTableView registerClass:[RechargeCenterCell class] forCellReuseIdentifier:NSStringFromClass([RechargeCenterCell class])];
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(100);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        

    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (RechargeCenterCustomView *)rechargeCenterCustomView{
    if (!_rechargeCenterCustomView) {
        _rechargeCenterCustomView = [RechargeCenterCustomView new];
    }
    return _rechargeCenterCustomView;
}
@end
