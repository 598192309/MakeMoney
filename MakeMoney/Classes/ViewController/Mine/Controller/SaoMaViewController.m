//
//  SaoMaViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//  支付扫码界面

#import "SaoMaViewController.h"
#import "SaoMaView.h"
#import<AssetsLibrary/AssetsLibrary.h>

@interface SaoMaViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)SaoMaView *saoMaView;

@end

@implementation SaoMaViewController
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
    [self.view addSubview:self.customTableView];

    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(weakSelf.view);
        make.top.mas_equalTo(NavMaxY);
    }];
    
    //header
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.saoMaView];
    [self.saoMaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self saoMaViewAct];
    
 
    
}
- (void)setUpNav{
    [self addNavigationView];
    self.navigationTextLabel.text = self.navTitle;
}
#pragma mark - act
- (void)saoMaViewAct{
    __weak __typeof(self) weakSelf = self;
    self.saoMaView.saveBtnClickBlock = ^(UIButton * _Nonnull sender, UIImageView * _Nonnull erweimaImageV) {
        [weakSelf saveImageToDiskWithImage:erweimaImageV.image];

    };
    
    self.saoMaView.copyBtnClickBlock = ^(UIButton * _Nonnull sender) {
        NSString *erweimaStr = weakSelf.urlStr;
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = erweimaStr;
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"复制成功", nil)];
    };
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
        
        

    }
    return _customTableView;
}

- (SaoMaView *)saoMaView{
    if (!_saoMaView) {
        _saoMaView = [SaoMaView new];
        _saoMaView.urlStr = self.urlStr;
    }
    return _saoMaView;
}
@end
