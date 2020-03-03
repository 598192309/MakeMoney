//
//  RechargeCenterViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  充值中心

#import "RechargeCenterViewController.h"
#import "RechargeCenterCell.h"
#import "RechargeCenterCustomView.h"
#import "MineApi.h"
#import "MineItem.h"
@interface RechargeCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)UIImageView *backImageV;
@property (nonatomic,strong)RechargeCenterCustomView *rechargeCenterCustomView;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomTitleLable;
@property (nonatomic,strong)UILabel *bottomTipLable1;
@property (nonatomic,strong)UILabel *bottomTipLable2;
@property (nonatomic,strong)UILabel *bottomTipLable3;

@end

@implementation RechargeCenterViewController
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
    [self requestData];
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
    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.rechargeCenterCustomView];
    [self.rechargeCenterCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self rechargeCenterCustomViewAct];
    
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
- (void)setUpNav{
    [self addNavigationView];
    self.navigationView.backgroundColor = [UIColor clearColor];
    self.navigationTextLabel.text = lqStrings(@"充值中心");
    [self.navigationRightBtn setTitle:lqStrings(@"充值记录") forState:UIControlStateNormal];
}
#pragma mark - act
- (void)rechargeCenterCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    self.rechargeCenterCustomView.rechargeCenterViewCheckBtnClickBlock = ^(UIButton * _Nonnull sender, UITextField * _Nonnull tf) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
    };
}
#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [MineApi requestPayCenterInfoSuccess:^(NSArray * _Nonnull payCenterInfotemArr, NSString * _Nonnull msg) {
        weakSelf.dataArr = [NSMutableArray arrayWithArray:payCenterInfotemArr];
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
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
    
    cell.rechargeCenterBuyBtnClickBlock = ^(UIButton * _Nonnull sender) {
        [LSVProgressHUD showInfoWithStatus:[sender titleForState:UIControlStateNormal]];
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
@end
