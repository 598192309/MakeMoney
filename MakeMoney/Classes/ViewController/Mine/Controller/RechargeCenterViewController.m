//
//  RechargeCenterViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  充值中心


#import "RechargeCenterViewController.h"
#import "RechargeCenterCustomView.h"
#import "MineApi.h"
#import "MineItem.h"
#import "RechargeDetailViewController.h"
#import "GroupCoinSegmentrol.h"

#import "VideoRechargeViewController.h"
#import "CityRechargeViewController.h"
#import "AblumRechargeViewController.h"
#import "BindMobileFirstStepViewController.h"

@interface RechargeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)RechargeCenterCustomView *rechargeCenterCustomView;
@property (nonatomic,strong)CommonAlertView *tipAlertView;
@property(nonatomic,strong)UIView *headerView;

@property (nonatomic,strong)GroupCoinSegmentrol *groupCoinSegmentrol;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)VideoRechargeViewController *videoVC;
@property (nonatomic,strong)CityRechargeViewController *cityVC;
@property (nonatomic,strong)AblumRechargeViewController *ablumVC;
@property (nonatomic,assign)BOOL showWenxin;//显示过温馨提示 请注意选择VIP类型哦~

@end

@implementation RechargeCenterViewController
#pragma mark - 重写
- (void)navigationRightBtnClick:(UIButton *)button{
    RechargeDetailViewController *vc = [[RechargeDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - life
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.notFirstAppear) {

        if (RI.infoInitItem.mobile.length == 0) {//没绑定
            [self showTipMsg:lqStrings(@"购买VIP需要先绑定手机号喔~") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:@"" subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:@"去绑定"];
        }else{
            if (!self.showWenxin) {
                [self showTipMsg:lqStrings(@"温馨提示") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:lqStrings(@"请注意选择VIP类型哦~") subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:@"好的"];
                self.showWenxin = YES;
            }

            
        }
    }

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    if (@available(iOS 11.0, *)) {
           _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
       // Fallback on earlier versions
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    if (RI.infoInitItem.mobile.length == 0) {//没绑定
        [self showTipMsg:lqStrings(@"购买VIP需要先绑定手机号喔~") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:@"" subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"再看看" secBtnTitle:@"去绑定" singleBtnTitle:@""];

    }else{
        [self showTipMsg:lqStrings(@"温馨提示") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:lqStrings(@"请注意选择VIP类型哦~") subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:@"好的"];
        self.showWenxin = YES;

    }
    [self configUI];
    [self setUpNav];

    [self setupScrollView];
    [self setupAllChildVc];
}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self.view addSubview:self.backImageV];
    [self.backImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf.view);
    }];

    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    _headerView = tableHeaderView;
    [tableHeaderView addSubview:self.rechargeCenterCustomView];
    [self.rechargeCenterCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(tableHeaderView);
    }];
    
    [tableHeaderView addSubview:self.groupCoinSegmentrol];
    [self.groupCoinSegmentrol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(tableHeaderView);
        make.top.mas_equalTo(weakSelf.rechargeCenterCustomView.mas_bottom);
        make.height.mas_equalTo(Adaptor_Value(50));
    }];
    [self.groupCoinSegmentrol layoutIfNeeded];

    _groupCoinSegmentrol.selectedIndexBlock = ^(NSInteger originIndex, NSInteger newIndex) {
        [UIView animateWithDuration:0.25 animations:^{
            // 滚动scrollView
            CGFloat offsetX = newIndex * weakSelf.scrollView.lq_width;
            weakSelf.scrollView.contentOffset = CGPointMake(offsetX, weakSelf.scrollView.contentOffset.y);
        } completion:^(BOOL finished) {
            //        // 添加子控制器的view到scrollView中
            [weakSelf addChildVcViewIntoScrollView:newIndex];
        }];

    };
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    [self.view addSubview:tableHeaderView];
    [tableHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];

    [self rechargeCenterCustomViewAct];
    

    
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"充值中心");
    [self.navigationRightBtn setTitle:lqStrings(@"充值记录") forState:UIControlStateNormal];
}


- (void)showTipMsg:(NSString *)msg msgFont:(UIFont *)msgFont msgColor:(UIColor *)msgColor subTitle:(NSString *)subTitle subFont:(UIFont *)subFont subColor:(UIColor *)subColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.tipAlertView refreshUIWithTitle:msg titlefont:msgFont titleColor:msgColor subtitle:subTitle subTitleFont:subFont subtitleColor:subColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tipAlertView];
    [self.tipAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
//scrollview
- (void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake(0, 0, LQScreemW, LQScreemH);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    __weak __typeof(self) weakSelf = self;
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(weakSelf.headerView.mas_bottom);
    }];

    //不让它滚
    self.scrollView.scrollEnabled = NO;
}
- (void)setupAllChildVc{
    
    [self addChildViewController:self.videoVC];
    [self addChildViewController:self.cityVC];
    [self addChildViewController:self.ablumVC];

    NSUInteger count = self.childViewControllers.count;
    
    // 设置scrollView
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.lq_width, 0);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // 不要自动调整内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 默认加载最前面子控制器的view
    [self addChildVcViewIntoScrollView:0];
    
}

/**
 *  添加index位置对应的子控制器view到scrollView
 */
- (void)addChildVcViewIntoScrollView:(NSInteger)index
{
    UIViewController *childVc = [self.childViewControllers safeObjectAtIndex:index];
    //点击切换的时候 刷新数据
    if ([childVc respondsToSelector:@selector(requestData)]) {
        [childVc performSelector:@selector(requestData)];
    }
    if (childVc.isViewLoaded) return;
    [self.scrollView addSubview:childVc.view];
    childVc.view.lq_x = index * self.scrollView.lq_width;
    childVc.view.lq_y = 0;
}
#pragma mark - <UIScrollViewDelegate>

/**
 *  当scrollView减速完毕的时候调用这个方法（当scrollView停止滚动的时候调用这个方法）
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 按钮索引
    NSInteger index = scrollView.contentOffset.x / scrollView.lq_width;
    // 找到按钮
    [self scrollToVC:index];

    
}

- (void)scrollToVC:(NSInteger)index{
    self.groupCoinSegmentrol.selectedIndex = index;
    __weak __typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        // 滚动scrollView
        CGFloat offsetX = index * weakSelf.scrollView.lq_width;
        weakSelf.scrollView.contentOffset = CGPointMake(offsetX, weakSelf.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //        // 添加子控制器的view到scrollView中
        [weakSelf addChildVcViewIntoScrollView:index];
    }];
    
}

#pragma mark - act
- (void)rechargeCenterCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    self.rechargeCenterCustomView.rechargeCenterViewCheckBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
        [weakSelf requestOrder:tf.text];
    };
}
#pragma mark -  net
- (void)requestOrder:(NSString *)orderNum{
    if (orderNum.length == 0) {
        return;
    }
    [LSVProgressHUD show];
    [MineApi requestPayResultWithTradeNo:orderNum Success:^(NSInteger status, NSString * _Nonnull msg, NSString * _Nonnull secret) {
        InitItem *item = [InitItem mj_objectWithKeyValues:[RI.infoInitItemJasonStr mj_JSONObject]] ;
        //兑换卡密
        [MineApi autobuyVipWithCard_pwd:secret sex_id:item.sex_id invite_code:item.invite_code Success:^(NSInteger status, NSString * _Nonnull msg) {
            RI.tradeNo = @"";
            [LSVProgressHUD showInfoWithStatus:msg];
        } error:^(NSError *error, id resultObject) {
            [LSVProgressHUD showError:error];
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];

    }];
}
#pragma mark - UITableViewDataSource


#pragma mark - lazy


- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (RechargeCenterCustomView *)rechargeCenterCustomView{
    if (!_rechargeCenterCustomView) {
        _rechargeCenterCustomView = [RechargeCenterCustomView new];
    }
    return _rechargeCenterCustomView;
}


- (GroupCoinSegmentrol *)groupCoinSegmentrol{
    if (!_groupCoinSegmentrol) {
        _groupCoinSegmentrol = [[GroupCoinSegmentrol alloc] initWithTitleItems:@[lqStrings(@"视频"),lqStrings(@"同城"),lqStrings(@"写真")]];
        _groupCoinSegmentrol.indicateViewWidth = Adaptor_Value(80);
        _groupCoinSegmentrol.titleNormalColor = TitleGrayColor;
    }
    return _groupCoinSegmentrol;
}

- (CommonAlertView *)tipAlertView{
    if (!_tipAlertView) {
        _tipAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _tipAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {
            if (index == 1) {
                //再看看
                [weakSelf.navigationController popViewControllerAnimated:YES];
                [weakSelf.tipAlertView removeFromSuperview];
                weakSelf.tipAlertView = nil;
            }else if (index == 2) {
                BindMobileFirstStepViewController *vc = [[BindMobileFirstStepViewController alloc] init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
                [weakSelf.tipAlertView removeFromSuperview];
                weakSelf.tipAlertView = nil;
            }
            if (index == 3) {
            
                [weakSelf.tipAlertView removeFromSuperview];
                weakSelf.tipAlertView = nil;
            }

        };
    }
    return _tipAlertView;
}

- (VideoRechargeViewController *)videoVC{
    if (!_videoVC) {
        _videoVC = [[VideoRechargeViewController alloc] init];
    }
    return _videoVC;
}

- (CityRechargeViewController *)cityVC{
    if (!_cityVC) {
        _cityVC = [[CityRechargeViewController alloc] init];
    }
    return _cityVC;
}

- (AblumRechargeViewController *)ablumVC{
    if (!_ablumVC) {
        _ablumVC = [[AblumRechargeViewController alloc] init];
    }
    return _ablumVC;
}
@end
