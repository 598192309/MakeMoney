//
//  BindMobileSecStepViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//  绑定手机 第2步 验证码

#import "BindMobileSecStepViewController.h"
#import "BindMobileSecStepView.h"
#import "MineApi.h"
#import "BindMobileSetPwdViewController.h"

@interface BindMobileSecStepViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)BindMobileSecStepView *bindMobileSecStepView;



@end

@implementation BindMobileSecStepViewController

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
    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.bindMobileSecStepView];
    [self.bindMobileSecStepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
//    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = LQScreemH;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = LQScreemH;

    [self bindMobileSecStepViewAct];
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
#pragma mark - act
- (void)bindMobileSecStepViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击确认
    self.bindMobileSecStepView.confirmBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
        [weakSelf checkCodeWithMobile:weakSelf.mobile code:tf.text sender:sender];
    };
    //点击发送验证码
    self.bindMobileSecStepView.codeBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
        [weakSelf requestCodeWithMobile:weakSelf.mobile sender:sender];
    };
}
#pragma mark -  net
//获取验证码
- (void)requestCodeWithMobile:(NSString *)mobile  sender:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    [MineApi requestCodeWithMobile:mobile Success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        [sender startWithTime:60 title:lqStrings(@"") titleColor:TitleWhiteColor countDownTitle:NSLocalizedString(@"s", nil) countDownTitleColor:TitleWhiteColor mainColor:[UIColor lq_colorWithHexString:@"#666666" alpha:0.5] countColor:[UIColor lq_colorWithHexString:@"#303030" alpha:0.3]];
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;

    }];
}

//验证验证码
- (void)checkCodeWithMobile:(NSString *)mobile code:(NSString *)code  sender:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
    [MineApi checkCodeWithMobile:mobile code:code Success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        BindMobileSetPwdViewController *vc = [[BindMobileSetPwdViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;

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
- (BindMobileSecStepView *)bindMobileSecStepView{
    if (!_bindMobileSecStepView) {
        _bindMobileSecStepView = [BindMobileSecStepView new];
    }
    return _bindMobileSecStepView;
}

@end
