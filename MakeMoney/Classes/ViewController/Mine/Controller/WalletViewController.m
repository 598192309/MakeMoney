//
//  WalletViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  我的钱包

#import "WalletViewController.h"
#import "WalletCustomView.h"
#import "MineApi.h"
#import "MineItem.h"

@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)WalletCustomView *walletCustomView;



@end

@implementation WalletViewController
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
    [tableHeaderView addSubview:self.walletCustomView];
    [self.walletCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self walletCustomViewAct];
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"我的钱包");
    [self.navigationRightBtn setTitle:lqStrings(@"提现明细") forState:UIControlStateNormal];
}
#pragma mark - act
- (void)walletCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击提现
    self.walletCustomView.walletCustomViewCashBtnClickBlock = ^(UIButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
        NSString *rate = [dict safeObjectForKey:@"rate"];
        NSString *account = [dict safeObjectForKey:@"account"];
        NSString *bankcard = [dict safeObjectForKey:@"bankcard"];
        NSString *money = [dict safeObjectForKey:@"money"];
        NSString *safe_code = [dict safeObjectForKey:@"safe_code"];
        if (!(rate.length > 0 && account.length > 0 && bankcard.length > 0 && money.length > 0 && safe_code.length > 0 )) {
            [LSVProgressHUD showInfoWithStatus:lqStrings(@"请将信息填写完整")];
            return ;
        }
        
        [weakSelf cashWithRate:rate account:account bankcard:bankcard money:money safe_code:safe_code sender:sender];
    };

}
#pragma mark -  net
//获取余额
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD show];
    [MineApi requestBalanceSuccess:^(NSInteger status, NSString * _Nonnull msg) {
        [weakSelf.walletCustomView refreshMoney:msg];
        [LSVProgressHUD dismiss];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}

//提现
- (void)cashWithRate:(NSString *)rate account:(NSString *)account bankcard:(NSString *)bankcard money:(NSString *)money safe_code:(NSString *)safe_code sender:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD show];
    //type   1银行卡   2.支付宝    3.微信  暂时只支持银行卡
    [MineApi cashWithType:@"1" rate:rate account:account bankcard:bankcard money:money safe_code:safe_code Success:^(NSInteger status, NSString * _Nonnull msg) {
        [LSVProgressHUD showInfoWithStatus:msg];
        [weakSelf.navigationController popViewControllerAnimated:YES];
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
- (WalletCustomView *)walletCustomView{
    if (!_walletCustomView) {
        _walletCustomView = [WalletCustomView new];
    }
    return _walletCustomView;
}
@end
