//
//  MineViewController.m
//  IUang
////我的账户
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MineViewController.h"




@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;





@end

@implementation MineViewController
#pragma mark - 重写

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (self.notFirstAppear) {
//        [self requestData];
//    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    [self configUI];
    //监听用户登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI) name:kUserSignIn object:nil];

    self. view.backgroundColor = LQRandColor;

}
#pragma mark - ui
- (void)configUI{
    [self.view addSubview:self.customTableView];
    __weak __typeof(self) weakSelf = self;
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    self.customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
//    UIView *tableHeaderView = [[UIView alloc] init];
//    [tableHeaderView addSubview:self.mineNewCustomView];
//    [self.mineNewCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(tableHeaderView);
//    }];
//    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
//    self.customTableView.tableHeaderView = tableHeaderView;
//    self.customTableView.tableHeaderView.lq_height = H;
//
//    [self mineCustomViewAct];

    
    //导航栏
    [self addNavigationView];
    self.navigationTextLabel.text = lqLocalized(@"会下款", nil);
    [self.navigationRightBtn setTitle:lqLocalized(@"联系客服", nil) forState:UIControlStateNormal];
    self.navigationBackButton.hidden = YES;
}

#pragma mark - act




#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *secHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Adaptor_Value(25))];
//
//    secHeader.backgroundColor = BackGroundColor;
//    UILabel *lable = [[UILabel alloc] init];
//
//    [secHeader addSubview:lable];
//    lable.textColor = TitleBlackColor;
//    lable.font = RegularFONT(15);
//    if (self.historyloanRecordArr.count > 0) {
//        lable.text = lqLocalized(@"历史贷款", nil);
//    }else{
//        lable.text = nil;
//    }
//    [lable sizeToFit];
//    lable.lq_x = Adaptor_Value(25);
//
//
//    return secHeader;
//
//}
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
//        _customTableView.backgroundColor = BackGroundColor;
//        _customTableView.separatorColor = BackGroundColor;
        
//        //下拉刷新
//        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
//        [_customTableView beginHeaderRefreshing];
//        _customTableView.tableFooterView = [UIView new];
        
    }
    return _customTableView;
}


@end
