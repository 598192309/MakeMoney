//
//  AblumDetailViewController.m
//  MakeMoney
//
//  Created by JS on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//  

#import "AblumDetailViewController.h"
#import "AblumItem.h"
#import "AblumApi.h"
#import "AblumDetailNewCell.h"
@interface AblumDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;

@property (nonatomic,strong)UIView *loveView;
@property (nonatomic,strong)EnlargeTouchSizeButton *loveBtn;
@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic , assign) BOOL hadShowOpenVip;
@end

@implementation AblumDetailViewController

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}

- (void)setAblumData:(AblumItem *)ablumData
{
    _ablumData = ablumData;
    _dataSource = [NSMutableArray array];
    for (NSString *url in ablumData.imgs) {
        M_AblumImage *data = [[M_AblumImage alloc] init];
        data.imageUrl = url;
        [_dataSource addObject:data];
    }
    [self.customTableView reloadData];
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
 
    [self.view addSubview:self.customTableView];
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    
    [self.view addSubview:self.loveView];
    [self.loveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.view).offset(-Adaptor_Value(20));
        make.bottom.mas_equalTo(weakSelf.view).offset(-Adaptor_Value(40));
    }];

}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = self.ablumData.album_name;
}

#pragma mark - act
- (void)loveBtnClick:(UIButton *)sender{
    //收藏 与取消
    [self love];
}
#pragma mark - net
//收藏 与取消
- (void)love{
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    [AblumApi loveAblumWithAblumId:self.ablumData.album_id Success:^(NSInteger status, NSString * _Nonnull msg) {
        [LSVProgressHUD showInfoWithStatus:msg];
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

//    AblumDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AblumDetailCell class]) forIndexPath:indexPath];
    AblumDetailNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AblumDetailNewCell class]) forIndexPath:indexPath];

    [cell refreshUIWithAblumImage:[_dataSource safeObjectAtIndex:indexPath.row]];
    __weak __typeof(self) weakSelf = self;
    cell.imageSizeSetSuccessBlock = ^{
        [weakSelf.customTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    M_AblumImage *ablum = _dataSource[indexPath.row];
    if (ablum.imageSize.width > 0) {
        return LQScreemW * ablum.imageSize.height / ablum.imageSize.width;
    }
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
        [_customTableView registerNib:[UINib nibWithNibName:NSStringFromClass([AblumDetailNewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([AblumDetailNewCell class])];

        
    }
    return _customTableView;
}
- (UIView *)loveView{
    if (!_loveView) {
        _loveView = [UIView new];
        __weak __typeof(self) weakSelf = self;
        UIView *contentV = [UIView new];
        contentV.backgroundColor = TitleWhiteColor;
        [_loveView addSubview:contentV];
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.loveView);
            make.height.width.mas_equalTo(Adaptor_Value(50));
        }];
        ViewRadius(contentV, Adaptor_Value(25));
        
        
        _loveBtn = [[EnlargeTouchSizeButton alloc] init];
        [_loveBtn addTarget:self action:@selector(loveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_before"] forState:UIControlStateNormal];
        [_loveBtn setImage:[UIImage imageNamed:@"icon_home_like_after"] forState:UIControlStateSelected];
        _loveBtn.selected = YES;//现在默认选择 现在没有显示 选中和不选中的判断
        [contentV addSubview:_loveBtn];
        [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.width.mas_equalTo(Adaptor_Value(30));
            make.center.mas_equalTo(contentV);
        }];
        _loveBtn.touchSize = CGSizeMake(Adaptor_Value(50), Adaptor_Value(50));

    }
    return _loveView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"%f,%f,%d,%d",contentOffsetY,scrollView.contentSize.height,_hadShowOpenVip,RI.infoInitItem.is_album_vip);
    if (contentOffsetY >= (scrollView.contentSize.height - scrollView.bounds.size.height) && !_hadShowOpenVip && !RI.infoInitItem.is_album_vip) {
        _hadShowOpenVip = YES;
        [LSVProgressHUD showInfoWithStatus:@"哥哥，开通VIP才能看全套写真哦~"];
    }
}
@end



