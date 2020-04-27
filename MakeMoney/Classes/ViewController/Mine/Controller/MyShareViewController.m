//
//  MyShareViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//  我的邀请码

#import "MyShareViewController.h"
#import "MyShareCustomView.h"
#import <CoreImage/CoreImage.h>

#import<AssetsLibrary/AssetsLibrary.h>
#import "MyShareDetailViewController.h"


@interface MyShareViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)MyShareCustomView *myShareCustomView;
@property (nonatomic,strong)UIImageView *backImageV;

@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *bottomTitleLable1;
@property (nonatomic,strong)UILabel *bottomTipLable1;
@property (nonatomic,strong)UILabel *bottomTipLable2;

@property (nonatomic,strong)UILabel *bottomTitleLable2;
@property (nonatomic,strong)UILabel *bottomTipLable3;
@property (nonatomic,strong)UILabel *bottomTipLable4;
@property (nonatomic,strong)UILabel *bottomTipLable5;


@end

@implementation MyShareViewController
#pragma mark - 重写
- (void)navigationRightBtnClick:(UIButton *)button{
//    [LSVProgressHUD showInfoWithStatus:[button titleForState:UIControlStateNormal]];
    MyShareDetailViewController *vc = [[MyShareDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
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
    [tableHeaderView addSubview:self.myShareCustomView];
    [self.myShareCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self myShareCustomViewAct];
    
    
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
    self.navigationTextLabel.text = lqStrings(@"我的邀请码");
    [self.navigationRightBtn setTitle:lqStrings(@"邀请记录") forState:UIControlStateNormal];
}

#pragma mark - act

- (void)myShareCustomViewAct{
    __weak __typeof(self) weakSelf = self;
    //换个样式
    self.myShareCustomView.myshareCustomHeaderViewChangeBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
        
    };
    
    //保存分享二维码
    self.myShareCustomView.myshareCustomHeaderViewSaveBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, UIImageView * _Nonnull erweimaImageV) {
        [weakSelf saveImageToDiskWithImage:erweimaImageV.image];
    };
    
    //copy分享链接
    self.myShareCustomView.myshareCustomHeaderViewCopyBtnClickBlock = ^(EnlargeTouchSizeButton * _Nonnull sender, NSDictionary * _Nonnull dict) {
        NSString *erweimaStr = [NSString stringWithFormat:@"%@%@/share5.html?appkey=%@&code=%@",RI.basicItem.share_text,RI.basicItem.share_url,ErweimaShareKey,RI.infoInitItem.invite_code];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = erweimaStr;
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"复制成功", nil)];
    };
}

#pragma mark - net
//获取分享
- (void)requestData{
    __weak __typeof(self) weakSelf = self;
    
}
#pragma mark - 保存图片
- (void)saveImageToDiskWithImage:(UIImage *)image
{
    __weak __typeof(self) weakSelf = self;
    UIImageWriteToSavedPhotosAlbum(image, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:), NULL);

    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if(author == ALAuthorizationStatusDenied ){
        //无权限
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"图片保存失败,请前往设置开启相册权限", nil)];
        return;
    }
    
    if (error) {
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"保存失败，请查看你的相册权限是否开启", nil)];
    }else{
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"图片已经保存至相册", nil)];
 
    }
}
#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return nil;
    
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
//        [_customTableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];

        
    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}
- (MyShareCustomView *)myShareCustomView{
    if (!_myShareCustomView) {
        _myShareCustomView = [MyShareCustomView new];
    }
    return _myShareCustomView;
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
        
        _bottomTitleLable1 = [UILabel lableWithText:lqLocalized(@"邀请福利",nil) textColor:[UIColor whiteColor] fontSize:AdaptedBoldFontSize(20) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTitleLable1];
        [_bottomTitleLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(Adaptor_Value(15));
            make.top.mas_equalTo(Adaptor_Value(25));
        }];
        
        _bottomTipLable1 = [UILabel lableWithText:[NSString stringWithFormat:lqLocalized(@"-成功邀请1人,送%d天VIP不限时观看,可无限叠加～",nil),RI.basicItem.vip_day] textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable1];
        [_bottomTipLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTitleLable1);
            make.top.mas_equalTo(weakSelf.bottomTitleLable1.mas_bottom).offset(Adaptor_Value(20));
            make.width.mas_equalTo(LQScreemW - Adaptor_Value(15) *2);
        }];
        
        NSString *str2 = lqLocalized(@"-成功邀请10人,加30天VIP会员时长,可无限叠加～",nil);
        //字体局部变色
        NSMutableAttributedString *attr2 = [[NSMutableAttributedString alloc]initWithString:str2];
        if (str2.length > 0) {
            NSRange start1  = [str2 rangeOfString:lqStrings(@"10")];
            NSRange start2  = [str2 rangeOfString:lqStrings(@"30")];
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
        

        _bottomTitleLable2 = [UILabel lableWithText:@"" textColor:[UIColor whiteColor] fontSize:AdaptedFontSize(16) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTitleLable2];
        [_bottomTitleLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.bottomTitleLable1);
            make.top.mas_equalTo(weakSelf.bottomTipLable2.mas_bottom).offset(Adaptor_Value(20));
        }];
        NSString *titlestr2 = lqLocalized(@"邀请攻略(最强邀请攻略，3步助你轻松白嫖)",nil);
        //字体局部变色
        NSMutableAttributedString *titlestr2Att = [[NSMutableAttributedString alloc]initWithString:titlestr2];
        if (titlestr2.length > 0) {
            NSRange start1  = [titlestr2 rangeOfString:lqStrings(@"邀请攻略")];
            if (start1.length > 0 ) {
                NSRange rangel = NSMakeRange(start1.location , start1.length );
                [titlestr2Att addAttribute:NSFontAttributeName value:AdaptedBoldFontSize(20) range:rangel];
            }
        };
        _bottomTitleLable2.attributedText = titlestr2Att;
        
        
        _bottomTipLable3 = [UILabel lableWithText:lqLocalized(@"1.复制链接或保存图片",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable3];
        [_bottomTipLable3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable2);
            make.top.mas_equalTo(weakSelf.bottomTitleLable2.mas_bottom).offset(Adaptor_Value(5));
        }];
        
        _bottomTipLable4 = [UILabel lableWithText:lqLocalized(@"2.将保存的图片或链接发送到以下渠道：\n微信群.QQ群.TG群.百度贴吧.微博.陌陌.知乎或者各类手游的世界频道等",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable4];
        [_bottomTipLable4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable3);
            make.top.mas_equalTo(weakSelf.bottomTipLable3.mas_bottom).offset(Adaptor_Value(5));
        }];
        
        _bottomTipLable5 = [UILabel lableWithText:lqLocalized(@"3.被邀请用户下载进入APP既生效",nil) textColor:TitleGrayColor fontSize:AdaptedFontSize(15) lableSize:CGRectZero textAliment:NSTextAlignmentLeft numberofLines:0];
        [contentV addSubview:_bottomTipLable5];
        [_bottomTipLable5 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(weakSelf.bottomTipLable3);
            make.top.mas_equalTo(weakSelf.bottomTipLable4.mas_bottom).offset(Adaptor_Value(5));
            make.bottom.mas_equalTo(contentV).offset(-Adaptor_Value(20));
        }];

    }
    return _bottomView;
}
@end
