//
//  CityDetailViewController.m
//  MakeMoney
//
//  Created by JS on 2020/4/22.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityDetailViewController.h"
#import "CityApi.h"
#import "CityItem.h"

@interface CityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation CityDetailViewController

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
    
}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
#pragma mark -- net
- (void)requestData{
    [LSVProgressHUD show];
    [CityApi requestCityDetailwithId:self.ID pageIndex:@"0" page_size:@"100" Success:^(CityListItem * _Nonnull cityItem, NSString * _Nonnull msg) {
        [LSVProgressHUD dismiss];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}
#pragma mark -  UITableViewDataSource
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

//    AblumDetailNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AblumDetailNewCell class]) forIndexPath:indexPath];
//
//    [cell refreshUIWithAblumImage:[_dataSource safeObjectAtIndex:indexPath.row]];
//    __weak __typeof(self) weakSelf = self;
//    cell.imageSizeSetSuccessBlock = ^{
//        [weakSelf.customTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
//    };
//    return cell;
    return nil;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    M_AblumImage *ablum = _dataSource[indexPath.row];
//    if (ablum.imageSize.width > 0) {
//        return LQScreemW * ablum.imageSize.height / ablum.imageSize.width;
//    }
    return 0;
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
//        [_customTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AblumDetailNewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AblumDetailNewCell class])];

        
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
