//
//  MineViewController.m
//  IUang
////我的账户
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MineViewController.h"
#import "MineCustomHeaderView.h"
#import "MineCell.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)MineCustomHeaderView *mineCustomHeaderView;
@property (nonatomic,strong)UIImageView *backImageV;
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
    if (@available(iOS 11.0, *)) {
           _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
       } else {
           // Fallback on earlier versions
           self.automaticallyAdjustsScrollViewInsets = NO;
       }
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
        make.left.bottom.right.top.mas_equalTo(weakSelf.view);
    }];
    self.customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.mineCustomHeaderView];
    [self.mineCustomHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self mineCustomHeaderViewAct];
}

#pragma mark - act

- (void)mineCustomHeaderViewAct{
    __weak __typeof(self) weakSelf = self;
    self.mineCustomHeaderView.mineCustomHeaderViewBlock = ^(NSDictionary *dict) {
        
    };
}


#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            {
                return 1;
            }
            break;

        case 1:
            {
                return 1;
            }
            break;
        case 2:
            {
                return 3;
            }
            break;
        case 3:
            {
                return 1;
            }
            break;
        case 4:
            {
                return 4;
            }
            break;
            
        default:
            break;
    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineCell class]) forIndexPath:indexPath];
    NSString *title;
    NSString *subTitle;
    if (indexPath.section == 0) {
        title = [NSString stringWithFormat:lqLocalized(@"官方邮箱%@", nil),@"***"];
        subTitle = lqStrings(@"复制");
    }else if (indexPath.section == 1){
        title = lqStrings(@"我的收藏");
        subTitle = nil;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            title = lqStrings(@"绑定手机号");
            subTitle = lqStrings(@"未绑定");
        }else  if (indexPath.row == 1) {
            title = lqStrings(@"我的邀请人");
            subTitle = lqStrings(@"未绑定");
        }else  if (indexPath.row == 2) {
            title = lqStrings(@"安全码设置");
            subTitle = lqStrings(@"");
        }

    }else if (indexPath.section == 3){
        title = lqStrings(@"密码锁");
        subTitle = nil;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            title = lqStrings(@"清理缓存");
            subTitle = lqStrings(@"多大");
        }else  if (indexPath.row == 1) {
            title = lqStrings(@"问题反馈");
            subTitle = lqStrings(@"");
        }else  if (indexPath.row == 2) {
            title = lqStrings(@"使用者协定");
            subTitle = lqStrings(@"");
        }else  if (indexPath.row == 3) {
            title = lqStrings(@"当前版本");
            subTitle = lqStrings(@"");
        }
    }
    [cell refreshUIWithTitle:title rightTitle:subTitle accessoryHidden:subTitle.length > 0];
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Adaptor_Value(5);
    
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
        [_customTableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];

        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _customTableView.tableFooterView = [UIView new];
        
    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}

- (MineCustomHeaderView *)mineCustomHeaderView{
    if (!_mineCustomHeaderView) {
        _mineCustomHeaderView = [MineCustomHeaderView new];
    }
    return _mineCustomHeaderView;
}
@end
