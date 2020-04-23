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
#import "CityDetailCustomView.h"
#import "RechargeCenterViewController.h"
#import "AblumDetailNewCell.h"

@interface CityDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)CityDetailCustomView *cityDetailCustomView;
@property (nonatomic,strong)UIView *tabelHeaderV;
@property (nonatomic,strong)CommonAlertView *tipAlertView;
@property (nonatomic,strong)CityListItem *cityListItem;
@property (nonatomic,strong)NSMutableArray *imagesArr;
@end

@implementation CityDetailViewController

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.notFirstAppear) {
        __weak __typeof(self) weakSelf = self;
        [weakSelf.cityDetailCustomView configUIWithItem:self.cityListItem finishi:^{
            CGFloat H = [weakSelf.cityDetailCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            weakSelf.tabelHeaderV.lq_height = H;
            weakSelf.customTableView.tableHeaderView = weakSelf.tabelHeaderV;
            weakSelf.customTableView.tableHeaderView.lq_height = H;
        }];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesArr = [NSMutableArray array];
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
    [tableHeaderView addSubview:self.cityDetailCustomView];
    self.tabelHeaderV = tableHeaderView;
    [self.cityDetailCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self cityDetailCustomViewACT];
    
}

- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
}
#pragma mark -- act
- (void)cityDetailCustomViewACT{
    __weak __typeof(self) weakSelf = self;
    //查看联系方式
    self.cityDetailCustomView.contactBtnClickBlock = ^(UIButton * _Nonnull sender) {
        [weakSelf showTipMsg:@"" msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:lqStrings(@"哥哥想联系我么？你必须是同城VIP会员喔，么么哒") subFont:AdaptedFontSize(15) subColor:TitleBlackColor firstBtnTitle:@"取消" secBtnTitle:@"购买VIP" singleBtnTitle:@""];

    };
}

- (void)showTipMsg:(NSString *)msg msgFont:(UIFont *)msgFont msgColor:(UIColor *)msgColor subTitle:(NSString *)subTitle subFont:(UIFont *)subFont subColor:(UIColor *)subColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.tipAlertView refreshUIWithTitle:msg titlefont:msgFont titleColor:msgColor subtitle:subTitle subTitleFont:subFont subtitleColor:subColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tipAlertView];
    [self.tipAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
#pragma mark -- net
- (void)requestData{
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    [CityApi requestCityDetailwithId:self.ID pageIndex:@"0" page_size:@"100" Success:^(CityListItem * _Nonnull cityItem, NSString * _Nonnull msg) {
        [LSVProgressHUD dismiss];
        weakSelf.cityListItem = cityItem;
        weakSelf.navigationTextLabel.text = cityItem.title;
        [weakSelf.cityDetailCustomView configUIWithItem:cityItem finishi:^{
            CGFloat H = [weakSelf.cityDetailCustomView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
            weakSelf.tabelHeaderV.lq_height = H;
            weakSelf.customTableView.tableHeaderView = weakSelf.tabelHeaderV;
            weakSelf.customTableView.tableHeaderView.lq_height = H;
        }];
        //循环获取image
        for (int i = 1; i < 9; i++) {
            [weakSelf requestImagesWithqmid:cityItem.ID imgID:IntTranslateStr(i) key:cityItem.title];
        }
        
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];
    
}

- (void)requestImagesWithqmid:(NSString *)qmid imgID:(NSString *)imgid key:(NSString *)key{
    __weak __typeof(self) weakSelf = self;
    [CityApi requestCityDetailImageswithQmid:qmid imgId:imgid key:key Success:^(UIImage * _Nonnull img) {
        if (img) {
            [weakSelf.imagesArr addObject:img];
        }
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}
#pragma mark -  UITableViewDataSource
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.imagesArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    AblumDetailNewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AblumDetailNewCell class]) forIndexPath:indexPath];

    [cell refreshTongchengDetailUIWithImage:[self.imagesArr safeObjectAtIndex:indexPath.section]];
    __weak __typeof(self) weakSelf = self;
    cell.imageSizeSetSuccessBlock = ^{
        [weakSelf.customTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    };
    return cell;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage  *image = [self.imagesArr safeObjectAtIndex:indexPath.section];
    if (image.size.width > 0) {
        return (LQScreemW - Adaptor_Value(50)) * image.size.height / image.size.width;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
    
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

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (CommonAlertView *)tipAlertView{
    if (!_tipAlertView) {
        _tipAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _tipAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {
            if (index == 2) {
                RechargeCenterViewController *vc = [[RechargeCenterViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
            
            [weakSelf.tipAlertView removeFromSuperview];
            weakSelf.tipAlertView = nil;

        };
    }
    return _tipAlertView;
}
- (CityDetailCustomView *)cityDetailCustomView{
    if(!_cityDetailCustomView){
        _cityDetailCustomView = [CityDetailCustomView new];
    }
    return _cityDetailCustomView;
}
@end
