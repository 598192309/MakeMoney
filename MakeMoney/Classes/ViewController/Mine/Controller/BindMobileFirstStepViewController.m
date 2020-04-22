//
//  BindMobileFirstStepViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//  绑定手机 第一步

#import "BindMobileFirstStepViewController.h"
#import "BindMobileFirstStepView.h"
#import "BindMobileSecStepViewController.h"
#import "MineApi.h"
#import "BindMobileSetPwdViewController.h"

@interface BindMobileFirstStepViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)BindMobileFirstStepView *bindMobileFirstStepView;



@end

@implementation BindMobileFirstStepViewController

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
    [tableHeaderView addSubview:self.bindMobileFirstStepView];
    [self.bindMobileFirstStepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
//    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = LQScreemH;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = LQScreemH;

    [self bindMobileFirstStepViewAct];
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
#pragma mark - act
- (void)bindMobileFirstStepViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击确认
    self.bindMobileFirstStepView.confirmBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
        [weakSelf verifyMoblieWithMobile:tf.text sender:sender];
    };
}
#pragma mark -  net
//验证手机号是否存在
- (void)verifyMoblieWithMobile:(NSString *)mobile sender:(UIButton *)sender{
    sender.userInteractionEnabled= NO;
    __weak __typeof(self) weakSelf = self;
    [LSVProgressHUD show];
    [MineApi checkMobileRealWithMobile:mobile success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        if (status == 1 && weakSelf.isFindBackPwd) {//手机号码不存在 进入验证码界面 或者找回密码时
            BindMobileSecStepViewController *vc = [BindMobileSecStepViewController new];
            vc.mobile = mobile;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{//手机号码存在 进入输入密码界面
            BindMobileSetPwdViewController *vc = [[BindMobileSetPwdViewController alloc] init];
            vc.mobile = mobile;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }

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
- (BindMobileFirstStepView *)bindMobileFirstStepView{
    if (!_bindMobileFirstStepView) {
        _bindMobileFirstStepView = [BindMobileFirstStepView new];
        _bindMobileFirstStepView.isFindBackPwd = _isFindBackPwd;
    }
    return _bindMobileFirstStepView;
}

@end
