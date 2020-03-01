//
//  MineViewController.m
//  IUang
////我的账户
//  Created by jayden on 2018/4/17.
//  Copyright © 2018年 jayden. All rights reserved.
//

#import "MineViewController.h"
#import "MineCustomHeaderView.h"
#import "MineCell.h"
#import "CustomAlertView.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (strong, nonatomic) UITableView  *customTableView;
@property (nonatomic,strong)MineCustomHeaderView *mineCustomHeaderView;
@property (nonatomic,strong)UIImageView *backImageV;
@property(nonatomic,strong)UIAlertController * alertController;
@property (nonatomic,strong)CustomAlertView *infoAlert;
@end

@implementation MineViewController
#pragma mark - 重写

#pragma mark - 生命周期
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    if (self.notFirstAppear) {
//        [self requestData];
//    }
    
}
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
        make.left.bottom.right.top.mas_equalTo(weakSelf.view);
    }];
    self.customTableView.contentInset = UIEdgeInsetsMake(0, 0, TabbarH, 0);
    UIView *tableHeaderView = [[UIView alloc] init];
    [tableHeaderView addSubview:self.mineCustomHeaderView];
    [self.mineCustomHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;

    [self mineCustomHeaderViewAct];
}


- (void)remindShow:(NSString *)msg msgColor:(UIColor *)msgColor msgFont:(UIFont *)msgFont subMsg:(NSString *)subMsg submsgColor:(UIColor *)submsgColor submsgFont:(UIFont *)submsgFont firstBtnTitle:(NSString *)firstBtnTitle secBtnTitle:(NSString *)secBtnTitle singeBtnTitle:(NSString *)singeBtnTitle{
    //局部变色
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:subMsg];
    if (subMsg.length > 0) {
        NSRange start  = [subMsg rangeOfString:lqStrings(@" 1 ")];
        if (start.length > 0 ) {
            [attr addAttribute:NSForegroundColorAttributeName value:TitleWhiteColor range:NSMakeRange(start.location, start.length)];
        }
    }
    
    [self.infoAlert refreshUIWithAttributeTitle:[[NSAttributedString alloc]initWithString:msg ] titleColor:msgColor titleFont:msgFont titleAliment:NSTextAlignmentCenter attributeSubTitle:attr subTitleColor:submsgColor subTitleFont:submsgFont subTitleAliment:NSTextAlignmentCenter firstBtnTitle:firstBtnTitle firstBtnTitleColor:TitleGrayColor secBtnTitle:secBtnTitle secBtnTitleColor:TitleWhiteColor singleBtnHidden:singeBtnTitle.length == 0 singleBtnTitle:singeBtnTitle singleBtnTitleColor:ThemeBlackColor removeBtnHidden:YES];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.infoAlert];
    
    [self.infoAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
}

#pragma mark - act

- (void)mineCustomHeaderViewAct{
    __weak __typeof(self) weakSelf = self;
    //点击头像
    self.mineCustomHeaderView.mineCustomHeaderViewBlock = ^(NSDictionary *dict) {
        [weakSelf presentViewController: weakSelf.alertController animated: YES completion: nil];
    };
}

#pragma mark - net
- (void)requestData{
    
}

#pragma mark -  UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            {
                return 1;
            }
            break;

        case 1:
            {
                return 1;
            }
            break;
        case 2:
            {
                return 3;
            }
            break;
        case 3:
            {
                return 1;
            }
            break;
        case 4:
            {
                return 4;
            }
            break;
            
        default:
            break;
    }
    return 0;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineCell class]) forIndexPath:indexPath];
    NSString *title;
    NSString *subTitle;
    if (indexPath.section == 0) {
        title = [NSString stringWithFormat:lqLocalized(@"官方邮箱:%@", nil),RI.basicItem.email];
        subTitle = lqStrings(@"复制");
    }else if (indexPath.section == 1){
        title = lqStrings(@"我的收藏");
        subTitle = nil;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            title = lqStrings(@"绑定手机号");
            subTitle = RI.infoInitItem.mobile.length > 0 ? lqStrings(@"已绑定") : lqStrings(@"未绑定");
        }else  if (indexPath.row == 1) {
            title = lqStrings(@"我的邀请人");
            subTitle = lqStrings(@"未绑定");
        }else  if (indexPath.row == 2) {
            title = lqStrings(@"安全码设置");
            subTitle = lqStrings(@"");
        }

    }else if (indexPath.section == 3){
        title = lqStrings(@"密码锁");
        subTitle = nil;
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {
            title = lqStrings(@"清理缓存");
            subTitle = [NSString stringWithFormat:@"%.2fMB",[LqSandBox folderSizeAtPath:[LqSandBox docDownloadImagePath]]];
        }else  if (indexPath.row == 1) {
            title = lqStrings(@"问题反馈");
            subTitle = lqStrings(@"");
        }else  if (indexPath.row == 2) {
            title = lqStrings(@"使用者协定");
            subTitle = lqStrings(@"");
        }else  if (indexPath.row == 3) {
            title = lqStrings(@"当前版本");
            NSString *vesion = [LqToolKit appVersionNo];
            subTitle = [NSString stringWithFormat:@"V%@",vesion];
        }
    }
    [cell refreshUIWithTitle:title rightTitle:subTitle accessoryHidden:subTitle.length > 0];
    return cell;
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return Adaptor_Value(5);
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *secHeader = [[UIView alloc] init];
    secHeader.backgroundColor = [UIColor clearColor];
    return secHeader;

}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = RI.basicItem.email;
        [LSVProgressHUD showInfoWithStatus:NSLocalizedString(@"复制成功", nil)];
    }else if (indexPath.section == 1){
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
           
        }else  if (indexPath.row == 1) {
           
        }else  if (indexPath.row == 2) {
            
        }

    }else if (indexPath.section == 3){
       
    }else if (indexPath.section == 4){
        if (indexPath.row == 0) {//清理缓存
            [self remindShow: @"" msgColor:[UIColor whiteColor] msgFont:AdaptedFontSize(15) subMsg:lqStrings(@"是否要清理缓存") submsgColor:ThemeBlackColor submsgFont:AdaptedFontSize(16) firstBtnTitle:nil secBtnTitle:nil singeBtnTitle:lqStrings(@"是")];
            
        }else  if (indexPath.row == 1) {
            
        }else  if (indexPath.row == 2) {
            
        }else  if (indexPath.row == 3) {
            
        }
    }
    
    
    
}
#pragma mark <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *editedimage = info[@"UIImagePickerControllerOriginalImage"];
    NSData *imageData = UIImageJPEGRepresentation(editedimage, 0.5);//首次进行压缩
    UIImage *image = [UIImage imageWithData:imageData];
    //    //图片限制大小不超过 1M     CGFloat  kb =   data.lenth / 1000;  计算kb方法 os 按照千进制计算
    //    while (imageData.length/1000 > 1024) {
    //        NSLog(@"图片超过1M 压缩");
    //        imageData = UIImageJPEGRepresentation(image, 0.5);
    //        image = [UIImage imageWithData:imageData];
    //    }
    
    [self.mineCustomHeaderView setAvter:image];
    

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
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
        [_customTableView registerClass:[MineCell class] forCellReuseIdentifier:NSStringFromClass([MineCell class])];

        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _customTableView.tableFooterView = [UIView new];
        
    }
    return _customTableView;
}

- (UIImageView *)backImageV{
    if(!_backImageV ){
        _backImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_bg"]];
    }
    return _backImageV;
}

- (MineCustomHeaderView *)mineCustomHeaderView{
    if (!_mineCustomHeaderView) {
        _mineCustomHeaderView = [MineCustomHeaderView new];
    }
    return _mineCustomHeaderView;
}


- (UIAlertController *)alertController{
    if (_alertController == nil) {
        __weak __typeof(self) weakSelf = self;
        _alertController = [UIAlertController alertControllerWithTitle: nil
                                                               message: nil
                                                        preferredStyle:UIAlertControllerStyleActionSheet];
        
        [_alertController addAction: [UIAlertAction actionWithTitle: lqStrings(@"拍照") style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = weakSelf;
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                picker.allowsEditing =NO; //拍照选去是否可以截取，和代理中的获取截取后的方法配合使用

                [weakSelf presentViewController:picker animated:YES completion:nil];

            }else{
                [LSVProgressHUD showInfoWithStatus:lqStrings(@"相机不可用")];
            }
        }]];
        [_alertController addAction: [UIAlertAction actionWithTitle: lqStrings(@"从相册中选择") style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *controller = [[UIImagePickerController alloc] init];
                controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                //                NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
                //                [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
                //                controller.mediaTypes = mediaTypes;
                controller.delegate = self;
                [self presentViewController:controller
                                   animated:YES
                                 completion:^(void){
                                     NSLog(@"Picker View Controller is presented");
                                 }];
            }
            
            
        }]];
        
        [_alertController addAction: [UIAlertAction actionWithTitle: NSLocalizedString(@"取消", nil) style: UIAlertActionStyleCancel handler:nil]];
    }
    return _alertController;
    
    
}


- (CustomAlertView *)infoAlert{
    if (_infoAlert == nil) {
        _infoAlert = [[CustomAlertView alloc] init];
        
        __weak __typeof(self) weakSelf = self;
        _infoAlert.CustomAlertViewBlock = ^(NSInteger index,NSString *str){
            [weakSelf.infoAlert removeFromSuperview];
            weakSelf.infoAlert = nil;

            if (index == 1) {//
                
            }else if(index == 2){
                
            }else if(index == 3){
                
            }
            
        };
    }
    
    return _infoAlert;
    
}
@end
