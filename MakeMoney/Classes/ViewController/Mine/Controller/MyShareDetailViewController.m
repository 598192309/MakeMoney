//
//  MyShareDetailViewController.m
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  邀请记录

#import "MyShareDetailViewController.h"
#import "MyShareDetailCell.h"
#import "MineItem.h"
#import "MineApi.h"

@interface MyShareDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;

@end

@implementation MyShareDetailViewController
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
    self.navigationTextLabel.text = lqStrings(@"邀请记录");
}
#pragma mark - act

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
 
    [MineApi requestShareRecordsWithInviteCode:RI.infoInitItem.invite_code Success:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull extendDetailItemArr) {
        weakSelf.pageIndex = extendDetailItemArr.count ;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:extendDetailItemArr];
//        if (extendArr.count >= 25 ) {
//            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
//            [weakSelf.customTableView.mj_footer setHidden:NO];
//
//        }else{
//            [weakSelf.customTableView endHeaderRefreshing];
//            //消除尾部"没有更多数据"的状态
//            [weakSelf.customTableView.mj_footer setHidden:YES];
//        }
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
        
    } error:^(NSError *error, id resultObject) {
        [weakSelf.customTableView endHeaderRefreshing];
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
    MyShareDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyShareDetailCell class]) forIndexPath:indexPath];
    ExtendDetailItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item];
    return cell;


}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] init];
    __weak __typeof(self) weakSelf = self;
    
    secHeader.backgroundColor = [UIColor clearColor];

    UILabel *titleLable1 = [UILabel lableWithText:lqLocalized(@"ID",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable1];
    [titleLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(secHeader);
        make.height.mas_equalTo(Adaptor_Value(30));
    }];
    
    UILabel *titleLable2 = [UILabel lableWithText:lqLocalized(@"邀请码",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable2];
    [titleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(titleLable1);
        make.left.mas_equalTo(titleLable1.mas_right);
    }];
    
    UILabel *titleLable3 = [UILabel lableWithText:lqLocalized(@"日期",nil) textColor:TitleWhiteColor fontSize:AdaptedFontSize(12) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLable3];
    [titleLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.top.bottom.mas_equalTo(titleLable1);
        make.left.mas_equalTo(titleLable2.mas_right);
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
        
        [_customTableView registerClass:[MyShareDetailCell class] forCellReuseIdentifier:NSStringFromClass([MyShareDetailCell class])];

        
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
