//
//  AVViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVViewController.h"
#import "AVCell.h"
#import "AVItem.h"
#import "AVApi.h"
#import "HomeItem.h"
#import "AVPlayerController.h"
@interface AVViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,strong)AdsItem *adsItem;
@end

@implementation AVViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    [self reqestTopAds];
    
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
        make.top.mas_equalTo(TopAdaptor_Value(25));
    }];
    
    
}


#pragma mark - act
-(void)adsTap:(UITapGestureRecognizer *)gest{
    if ([self.adsItem.url hasPrefix:@"http"]) {
        UIApplication *application = [UIApplication sharedApplication];
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:[NSURL URLWithString:self.adsItem.url] options:@{} completionHandler:nil];
            } else {
                [application openURL:[NSURL URLWithString:self.adsItem.url]];
            }
        }else{
            [application openURL:[NSURL URLWithString:self.adsItem.url]];

        }

    }
}

#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    //AV 这里有3中状态，通过tag判断   0  VIP   1 限免    2 收费
    [AVApi requestAVExtendwithPageIndex:@"0" page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
            weakSelf.pageIndex = hotItemArr.count;
            weakSelf.dataArr = [NSMutableArray arrayWithArray:hotItemArr];
            if (hotItemArr.count >= 25 ) {
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
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];
}


-(void)requestMoreData{
    __weak __typeof(self) weakSelf = self;

    [AVApi requestAVExtendwithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"25" Success:^(NSArray * _Nonnull hotItemArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:hotItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (hotItemArr.count < 25) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex = weakSelf.dataArr.count ;
            
        }
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];
}

//获取顶部广告
- (void)reqestTopAds{
    __weak __typeof(self) weakSelf = self;
    [HomeApi requestAdWithType:@"3" Success:^(NSArray * _Nonnull adsItemArr, NSString * _Nonnull msg) {
        AdsItem *item = adsItemArr.firstObject;
        weakSelf.adsItem = item;
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        
    }];
}

//收藏与取消
- (void)loveWithId:(NSString *)ID sender:(UIButton *)sender{
    __weak __typeof(self) weakSelf = self;
    sender.userInteractionEnabled = NO;
    [AVApi loveAVWithVedioId:ID Success:^(NSInteger status, NSString * _Nonnull msg) {
        sender.userInteractionEnabled = YES;
        [LSVProgressHUD showInfoWithStatus:msg];
    } error:^(NSError *error, id resultObject) {
        sender.userInteractionEnabled = YES;

    }];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AVCell class]) ];
    HotItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshWithItem: item];
    __weak __typeof(self) weakSelf = self;
    cell.loveBlock = ^(UIButton * _Nonnull sender) {
        [weakSelf loveWithId:item.ID sender:sender];

    };
    return cell;


}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [LSVProgressHUD showInfoWithStatus:@"点击"];
    HotItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];

    AVPlayerController *vc = [AVPlayerController controllerWith:item];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LQScreemW, Adaptor_Value(80))];
    [imageV sd_setImageWithURL:[NSURL URLWithString:self.adsItem.img]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adsTap:)];
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:tap];
    return imageV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.adsItem.img.length > 0) {
//        return Adaptor_Value(80);
        //根据url 获取图片尺寸
        CGSize size = [UIImage getImageSizeWithURL:self.adsItem.img];
        
        CGFloat h = LQScreemW / size.width * size.height;
        return h;
    }
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
        _customTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LQScreemW, LQScreemH) style:UITableViewStyleGrouped];
        _customTableView.backgroundColor = ThemeBlackColor;
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        [_customTableView registerClass:[AVCell class] forCellReuseIdentifier:NSStringFromClass([AVCell class])];
        
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];
        
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(250);
        _customTableView.rowHeight=UITableViewAutomaticDimension;

    }
    return _customTableView;
}

@end
