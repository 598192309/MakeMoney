//
//  CityRechargeViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/4/15.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "CityRechargeViewController.h"
#import "RechargeCenterCell.h"
#import "RechargeCenterCustomView.h"
#import "MineApi.h"
#import "MineItem.h"
#import "PopPayWayViewController.h"
#import "BaseWebViewController.h"
#import "SaoMaViewController.h"
#import "RechargeDetailViewController.h"
#import "WebViewViewController.h"


@interface CityRechargeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)NSInteger selectedIndex;


@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomTitleLable;
@property (nonatomic,strong)UILabel *bottomTipLable1;
@property (nonatomic,strong)UILabel *bottomTipLable2;
@property (nonatomic,strong)UILabel *bottomTipLable3;
@property (nonatomic,strong)CommonAlertView *commonAlertView;
@property (nonatomic,strong)CommonAlertView *tipAlertView;

@property (nonatomic,strong)NSString *goodID;

@property (nonatomic,assign)BOOL clickPayed;

@end

@implementation CityRechargeViewController
#pragma mark - 重写
- (void)navigationRightBtnClick:(UIButton *)button{
    RechargeDetailViewController *vc = [[RechargeDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - life
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.notFirstAppear && self.clickPayed) {
        self.clickPayed = NO;
        [self showTipMsg:lqStrings(@"查询支付结果") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:lqStrings(@"若支付成功后，未能激活VIP，且订单状态为未支付，请在上方输入订单号手动激活") subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:@"好的"];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self configUI];
    
    if (@available(iOS 11.0, *)) {
           _customTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
       // Fallback on earlier versions
       self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notify:) name:KNotification_PayClick object:nil];

}
- (void)dealloc{
    LQLog(@"dealloc -------%@",NSStringFromClass([self class]));
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - ui
- (void)configUI{
    __weak __typeof(self) weakSelf = self;


    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(weakSelf.view);
    }];

    
    //footer
    UIView *tableFooterView = [[UIView alloc] init];
    [tableFooterView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableFooterView);
    }];
    CGFloat footerH = [tableFooterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableFooterView.lq_height = footerH;
    self.customTableView.tableFooterView = tableFooterView;
    self.customTableView.tableFooterView.lq_height = footerH;
    
    
}


- (void)showMsg:(NSString *)msg msgFont:(UIFont *)msgFont msgColor:(UIColor *)msgColor subTitle:(NSString *)subTitle subFont:(UIFont *)subFont subColor:(UIColor *)subColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.commonAlertView refreshUIWithTitle:msg titlefont:msgFont titleColor:msgColor subtitle:subTitle subTitleFont:subFont subtitleColor:subColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.commonAlertView];
    [self.commonAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}
- (void)showTipMsg:(NSString *)msg msgFont:(UIFont *)msgFont msgColor:(UIColor *)msgColor subTitle:(NSString *)subTitle subFont:(UIFont *)subFont subColor:(UIColor *)subColor firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singleBtnTitle:(NSString *)singleBtnTitle{
    [self.tipAlertView refreshUIWithTitle:msg titlefont:msgFont titleColor:msgColor subtitle:subTitle subTitleFont:subFont subtitleColor:subColor firstBtnTitle:firstBtnTitle secBtnTitle:secBtnTitle singleBtnTitle:singleBtnTitle];
    [[UIApplication sharedApplication].keyWindow addSubview:self.tipAlertView];
    [self.tipAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}

#pragma mark - notify
//点击了支付方式
- (void)notify:(NSNotification *)noti{
    NSDictionary *dict = noti.userInfo;
    PayWayItem *item = [dict safeObjectForKey:@"info"];
    PayCenterInfotem *infoItem = [self.dataArr safeObjectAtIndex:self.selectedIndex];
    [self goPayWithInviteChannelId:item.channel_id goods_id:self.goodID sex_id:RI.infoInitItem.sex_id pay_type:IntTranslateStr(infoItem.tag) payName:item.name tiaoZhuanType:item.type];
}
#pragma mark - act

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    //tag : 0 视频 1同城2写真
    [MineApi requestPayCenterInfoWithTag:@"1" Success:^(NSArray * _Nonnull payCenterInfotemArr, NSString * _Nonnull msg) {
        weakSelf.dataArr = [NSMutableArray arrayWithArray:payCenterInfotemArr];
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
    }];

    
}
//获取支付方式
- (void)requestPayWays:(UIButton *)sender{
    [LSVProgressHUD show];
    sender.userInteractionEnabled = NO;
    __weak __typeof(self) weakSelf = self;
    [MineApi requestPayWaysSuccess:^(NSInteger status, NSString * _Nonnull msg, NSArray * _Nonnull payWayItemArr) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD dismiss];
        PopPayWayViewController *vc = [[PopPayWayViewController alloc] init];
        vc.dataArr = payWayItemArr;
        [weakSelf yc_bottomPresentController:vc presentedHeight:Adaptor_Value(50) * (payWayItemArr.count + 1) completeHandle:^(BOOL presented) {
            if (presented) {
                NSLog(@"弹出了");
            }else{
                NSLog(@"消失了");
            }
        }];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        sender.userInteractionEnabled = YES;

    }];
}

//支付 tiaoZhuanType 1     跳转到webview加载 data pay_type： 3或4    跳转到新的扫码支付界面

- (void)goPayWithInviteChannelId:(NSString *)channel_id goods_id:(NSString *)goods_id sex_id:(NSString *)sex_id pay_type:(NSString *)pay_type payName:(NSString *)payName tiaoZhuanType:(NSString *)tiaoZhuanType{

    [self showMsg:lqStrings(@"准备支付，情稍后...") msgFont:AdaptedBoldFontSize(15) msgColor:ThemeBlackColor subTitle:lqStrings(@"支付成功后，请返回当前界面，或手动输入订单号查询支付状态") subFont:AdaptedFontSize(14) subColor:TitleBlackColor firstBtnTitle:@"" secBtnTitle:@"" singleBtnTitle:@""];
    [LSVProgressHUD show];
    __weak __typeof(self) weakSelf = self;
    [MineApi goPayWithInviteChannelId:channel_id goods_id:goods_id sex_id:sex_id pay_type:pay_type Success:^(NSInteger status, NSString * _Nonnull msg, PayDetailItem* _Nonnull payDetailItem) {
        [weakSelf.commonAlertView removeFromSuperview];
        weakSelf.commonAlertView = nil;
        weakSelf.clickPayed = YES;
        
        if ([tiaoZhuanType isEqualToString:@"1"]) {//跳转到webview加载
//            BaseWebViewController *vc = [[BaseWebViewController alloc] init];
            WebViewViewController *vc = [[WebViewViewController alloc] init];
            NSString *html = payDetailItem.data;
            //去掉转义符
//            NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)html, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
            vc.htmlStr = html;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }else{//3或4    跳转到新的扫码支付界面
            SaoMaViewController *vc = [[SaoMaViewController alloc] init];

            vc.navTitle =[NSString stringWithFormat:lqLocalized(@"%@支付", nil),payName];
            vc.urlStr = payDetailItem.data;
            
            [weakSelf.navigationController pushViewController:vc animated:YES];

        }
        [LSVProgressHUD dismiss];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.commonAlertView removeFromSuperview];
        weakSelf.commonAlertView = nil;
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
    RechargeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RechargeCenterCell class]) forIndexPath:indexPath];
    PayCenterInfotem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshUIWithItem:item];
    __weak __typeof(self) weakSelf = self;
    cell.rechargeCenterBuyBtnClickBlock = ^(UIButton * _Nonnull sender) {
//        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
        weakSelf.selectedIndex = indexPath.row;
        weakSelf.goodID = item.goods_id;
        //支付方式弹框
        [weakSelf requestPayWays:sender];
    };
    return cell;


}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
    return 0.01;
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
        
        [_customTableView registerClass:[RechargeCenterCell class] forCellReuseIdentifier:NSStringFromClass([RechargeCenterCell class])];
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(100);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        

    }
    return _customTableView;
}

//- (UIImageView *)backImageV{
//    if(!_backImageV ){
//        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
//    }
//    return _backImageV;
//}
//- (RechargeCenterCustomView *)rechargeCenterCustomView{
//    if (!_rechargeCenterCustomView) {
//        _rechargeCenterCustomView = [RechargeCenterCustomView new];
//    }
//    return _rechargeCenterCustomView;
//}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView new];
        _bottomView.backgroundColor = [UIColor clearColor];
        __weak __typeof(self) weakSelf = self;
        UIView *contentV = [UIView new];
        contentV.backgroundColor = [UIColor clearColor];
        [_bottomView addSubview:contentV];
            
        [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.bottomView);
        }];
        
        _bottomTitleLable = [UILabel lableWithText:lqLocalized(@"如何激活卡密",nil) textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(30) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTitleLable];
        [_bottomTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(15));
        }];
        
        _bottomTipLable1 = [UILabel lableWithText:lqLocalized(@"1.点击购买，跳转支付界面填写资讯并支付",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable1];
        [_bottomTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTitleLable);
            make.top.mas_equalTo(weakSelf.bottomTitleLable.mas_bottom).offset(Adaptor_Value(20));
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(15) *2);
        }];
        
        NSString *str2 = lqLocalized(@"2.完成支付获得卡号和卡密",nil);
        //字体局部变色
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc]initWithString:str2];
        if (str2.length > 0) {
            NSRange start1  = [str2 rangeOfString:lqStrings(@"卡号")];
            NSRange start2  = [str2 rangeOfString:lqStrings(@"卡密")];
            if (start1.length > 0 ) {
                NSRange rangel = NSMakeRange(start1.location , start1.length );
                [attr2 addAttribute:NSForegroundColorAttributeName value:CustomRedColor range:rangel];
            }
            if (start2.length > 0 ) {
                NSRange rangel = NSMakeRange(start2.location , start2.length );
                [attr2 addAttribute:NSForegroundColorAttributeName value:CustomRedColor range:rangel];
            }
        }
        _bottomTipLable2 = [UILabel lableWithText:@"" textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable2];
        [_bottomTipLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable1);
            make.top.mas_equalTo(weakSelf.bottomTipLable1.mas_bottom).offset(Adaptor_Value(5));
        }];
        _bottomTipLable2.attributedText =attr2;
        
        _bottomTipLable3 = [UILabel lableWithText:@"" textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable3];
        [_bottomTipLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable2);
            make.top.mas_equalTo(weakSelf.bottomTipLable2.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(40));
        }];
        NSString *str3 = lqLocalized(@"3.在我的界面-点击VIP兑换，填写卡密进行VIP会员兑换",nil);
        //字体局部变色
        NSMutableAttributedString *attr3 = [[NSMutableAttributedString alloc]initWithString:str3];
        if (str3.length > 0) {
            NSRange start3 = [str3 rangeOfString:lqStrings(@"卡密")];
            if (start3.length > 0 ) {
                NSRange rangel = NSMakeRange(start3.location , start3.length );
                [attr3 addAttribute:NSForegroundColorAttributeName value:CustomRedColor range:rangel];
            }
        }
        _bottomTipLable3.attributedText = attr3;
    }
    return _bottomView;
}

- (CommonAlertView *)commonAlertView{
    if (!_commonAlertView) {
        _commonAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _commonAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {

        };
    }
    return _commonAlertView;
}

- (CommonAlertView *)tipAlertView{
    if (!_tipAlertView) {
        _tipAlertView = [CommonAlertView new];
        __weak __typeof(self) weakSelf = self;
        _tipAlertView.commonAlertViewBlock = ^(NSInteger index, NSString * _Nonnull str) {
            [weakSelf.tipAlertView removeFromSuperview];
            weakSelf.tipAlertView = nil;
        };
    }
    return _tipAlertView;
}
@end
