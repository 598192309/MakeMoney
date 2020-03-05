//
//  PopPayWayViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//  支付方式 

#import "PopPayWayViewController.h"
#import "PopPayWayCell.h"
#import "MineItem.h"
#import "MineApi.h"
@interface PopPayWayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;

@end

@implementation PopPayWayViewController
#pragma mark - life
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
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];
 
    
    
}

#pragma mark - act

#pragma mark -  net
//支付
- (void)goPayWithInviteChannelId:(NSString *)channel_id goods_id:(NSString *)goods_id sex_id:(NSString *)sex_id pay_type:(NSString *)pay_type {
    [LSVProgressHUD show];
    [MineApi goPayWithInviteChannelId:channel_id goods_id:goods_id sex_id:sex_id pay_type:pay_type Success:^(NSInteger status, NSString * _Nonnull msg, PayDetailItem * _Nonnull payDetailItem) {
        
    } error:^(NSError *error, id resultObject) {
        
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
    PopPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PopPayWayCell class]) forIndexPath:indexPath];
    PayWayItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell configUIWithItem:item];
    return cell;


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(50);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [UIView new];
    secHeader.backgroundColor = TitleWhiteColor;
    UILabel *titleLabel = [UILabel lableWithText:lqLocalized(@"请选择支付方式",nil) textColor:ThemeBlackColor fontSize:AdaptedBoldFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentCenter numberofLines:0];
    [secHeader addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(secHeader);
    }];
    
    return secHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return Adaptor_Value(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //支付
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
        

        
        [_customTableView registerClass:[PopPayWayCell class] forCellReuseIdentifier:NSStringFromClass([PopPayWayCell class])];

    }
    return _customTableView;
}

@end
