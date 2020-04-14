//
//  IncomeDetailViewController.m
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  收益明细

#import "IncomeDetailViewController.h"
#import "IncomeDetailCell.h"
#import "MineApi.h"
#import "MineItem.h"

@interface IncomeDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation IncomeDetailViewController
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
 
    
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"收益明细");
}
#pragma mark - act

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestExtendDetailwithVideoInviteCode:self.inviteCode pageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull extendArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = extendArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:extendArr];
        if (extendArr.count >= 25 ) {
            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customTableView.mj_footer setHidden:NO];
    
        }else{
            [weakSelf.customTableView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customTableView.mj_footer setHidden:YES];
        }
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
    }];
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestExtendDetailwithVideoInviteCode:self.inviteCode pageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull extendArr, NSString * _Nonnull msg) {
       [weakSelf.dataArr addObjectsFromArray:extendArr];
       [weakSelf.customTableView endFooterRefreshing];
       [weakSelf.customTableView reloadData];
       if (extendArr.count < 25) {
           [weakSelf.customTableView endRefreshingWithNoMoreData];
       }else{
           weakSelf.pageIndex = weakSelf.dataArr.count ;
           
       }
    } error:^(NSError *error, id resultObject) {
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IncomeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IncomeDetailCell class]) forIndexPath:indexPath];
    ExtendDetailItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item];
    return cell;


}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    
    secHeader.backgroundColor = [UIColor clearColor];

    UILabel *titleLable1 = [UILabel lableWithText:lqLocalized(@"好友",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable1];
    [titleLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(secHeader);
        make.height.mas_equalTo(Adaptor_Value(30));
    }];
    
    UILabel *titleLable2 = [UILabel lableWithText:lqLocalized(@"充值金额",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable2];
    [titleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(titleLable1);
        make.left.mas_equalTo(titleLable1.mas_right);
    }];
    
    UILabel *titleLable3 = [UILabel lableWithText:lqLocalized(@"返利",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable3];
    [titleLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(titleLable1);
        make.left.mas_equalTo(titleLable2.mas_right);
    }];
    
    UILabel *titleLable4 = [UILabel lableWithText:lqLocalized(@"时间",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable4];
    [titleLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(titleLable1);
        make.left.mas_equalTo(titleLable3.mas_right);
        make.right.mas_equalTo(secHeader);
    }];
    return secHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return Adaptor_Value(30);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
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
        
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(30);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        
        [_customTableView registerClass:[IncomeDetailCell class] forCellReuseIdentifier:NSStringFromClass([IncomeDetailCell class])];

        
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];
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
