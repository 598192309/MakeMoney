//
//  TuiGuangViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  推广赚钱

#import "TuiGuangViewController.h"
#import "TuiGuangCustomView.h"
#import "MineApi.h"
#import "MineItem.h"
#import "IncomeDetailViewController.h"

@interface TuiGuangViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)TuiGuangCustomView *tuiGuangCustomView;



@end

@implementation TuiGuangViewController
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
    [tableHeaderView addSubview:self.tuiGuangCustomView];
    [self.tuiGuangCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self tuiGuangCustomViewAct];
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"推广赚钱");
}
#pragma mark - act
- (void)tuiGuangCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    // 查看明细
    self.tuiGuangCustomView.tuiGuangCustomViewCheckBtnClickBlock = ^(UIButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
        IncomeDetailViewController *vc = [[IncomeDetailViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
}
#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD show];
    [MineApi requestExtendIncomeSuccess:^(ExtendDetailItem * _Nonnull extendDetailItem, NSString * _Nonnull msg) {
        [weakSelf.tuiGuangCustomView configUIWithItem:extendDetailItem];
        [LSVProgressHUD dismiss];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}


#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] init];
    secHeader.backgroundColor = [UIColor clearColor];
    return secHeader;

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
        
        

    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (TuiGuangCustomView *)tuiGuangCustomView{
    if (!_tuiGuangCustomView) {
        _tuiGuangCustomView = [TuiGuangCustomView new];
    }
    return _tuiGuangCustomView;
}
@end
