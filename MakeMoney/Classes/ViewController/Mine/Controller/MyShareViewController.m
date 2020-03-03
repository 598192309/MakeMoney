//
//  MyShareViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  我的邀请码

#import "MyShareViewController.h"
#import "MyShareCustomView.h"

@interface MyShareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)MyShareCustomView *myShareCustomView;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation MyShareViewController
#pragma mark - 重写
- (void)navigationRightBtnClick:(UIButton *)button{
    [LSVProgressHUD showInfoWithStatus:[button titleForState:UIControlStateNormal]];
}
#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
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
    LQLog(@"dealloc -- %@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.myShareCustomView];
    [self.myShareCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self myShareCustomViewAct];
}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"我的邀请码");
    [self.navigationRightBtn setTitle:lqStrings(@"邀请记录") forState:UIControlStateNormal];
}

#pragma mark - act

- (void)myShareCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //换个样式
    self.myShareCustomView.myshareCustomHeaderViewChangeBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
        
    };
    
    //保存分享二维码
    self.myShareCustomView.myshareCustomHeaderViewSaveBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
        
    };
    
    //copy分享链接
    self.myShareCustomView.myshareCustomHeaderViewCopyBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
        
    };
}

#pragma mark - net
//获取分享
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    
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


#pragma  mark - lazy
- (UITableView *)customTableView
{
    if (_customTableView == nil) {
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,LQScreemW, LQScreemH) style:UITableViewStylePlain];
        _customTableView.delegate = self;
        _customTableView.dataSource = self;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        _customTableView.backgroundColor = [UIColor clearColor];
        _customTableView.separatorColor = [UIColor clearColor];
//        [_customTableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];

        
    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (MyShareCustomView *)myShareCustomView{
    if (!_myShareCustomView) {
        _myShareCustomView = [MyShareCustomView new];
    }
    return _myShareCustomView;
}
@end
