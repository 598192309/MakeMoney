//
//  ZhuanTiViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "ZhuanTiViewController.h"
#import "ZHuanTiCell.h"
#import "ZhuanTiApi.h"
#import "ZhuanTiItem.h"
@interface ZhuanTiViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,assign)NSInteger pageIndex;
@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation ZhuanTiViewController
#pragma mark - life
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
        
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
- (void)downImage{
    //循环下载
    for (ZhuanTiHomeItem *item  in self.dataArr) {
        [self requestImagesWithType:@"s_imgs" paramTitle:@"sId" ID:item.ID];
    }
}

//刷新对应的数据
- (void)refreshImageWithID:(NSString *)ID img:(NSString *)img{
    __weak __typeof(self) weakSelf = self;
    //下载好图片 对应cell刷新数据
    __block NSInteger row = 0;
    [weakSelf.dataArr enumerateObjectsUsingBlock:^(ZhuanTiHomeItem *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                if ([obj.ID isEqualToString:ID]) {
                    *stop = YES;//手动停止遍历
                    row = idx;
                }
            }else{
                NSLog(@"结束了，但没找到");
            }
        }];
    ZhuanTiHomeItem *item = [weakSelf.dataArr safeObjectAtIndex:row];
    UIImage *downImage = [UIImage base64stringToImage:img];
    item.customImage = downImage;
    //刷新对应的cell
//        //一个section刷新
//
//        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
//
//        [tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];

    //一个cell刷新

    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:row inSection:0];

    [weakSelf.customTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
#pragma mark -  net
-(void)requestData{
    __weak __typeof(self) weakSelf = self;
    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:@"1" page_size:@"10" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
        weakSelf.pageIndex = 2;
        weakSelf.dataArr = [NSMutableArray arrayWithArray:zhuanTiHomeItemArr];
        if (zhuanTiHomeItemArr.count >= 10 ) {
            [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
            [weakSelf.customTableView.mj_footer setHidden:NO];
    
        }else{
            [weakSelf.customTableView endHeaderRefreshing];
            //消除尾部"没有更多数据"的状态
            [weakSelf.customTableView.mj_footer setHidden:YES];
        }
        [weakSelf downImage];
        [weakSelf.customTableView endHeaderRefreshing];
        [weakSelf.customTableView reloadData];
    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];

    }];

    
}


//下载图片
- (void)requestImagesWithType:(NSString *)type paramTitle:(NSString *)paramTitle ID:(NSString *)ID{
    __weak __typeof(self) weakSelf = self;
    [HomeApi downImageWithType:type paramTitle:paramTitle ID:ID Success:^(NSString * _Nonnull img) {
        [weakSelf refreshImageWithID:ID img:img];
    } error:^(NSError *error, id resultObject) {
        
    }];
}

- (void)requestMoreData{
    __weak __typeof(self) weakSelf = self;
    [ZhuanTiApi requestZhuanTiHomeInfowithPageIndex:IntTranslateStr(self.pageIndex) page_size:@"10" Success:^(NSArray * _Nonnull zhuanTiHomeItemArr, NSString * _Nonnull msg) {
        [weakSelf.dataArr addObjectsFromArray:zhuanTiHomeItemArr];
        [weakSelf.customTableView endFooterRefreshing];
        [weakSelf.customTableView reloadData];
        if (zhuanTiHomeItemArr.count < 10) {
            [weakSelf.customTableView endRefreshingWithNoMoreData];
        }else{
            weakSelf.pageIndex += 1;
            
        }
        [weakSelf downImage];

    } error:^(NSError *error, id resultObject) {
        [LSVProgressHUD showError:error];
        [weakSelf.customTableView endHeaderRefreshing];
        

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
    ZHuanTiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZHuanTiCell class]) forIndexPath:indexPath];
    ZhuanTiHomeItem *item = [self.dataArr safeObjectAtIndex:indexPath.row];
    [cell refreshWithItem: item];
    return cell;


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return Adaptor_Value(180);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [LSVProgressHUD showInfoWithStatus:@"点击"];
}

#pragma mark - lazy
- (UITableView *)customTableView{
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.backgroundColor = ThemeBlackColor;
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        [_customTableView registerClass:[ZHuanTiCell class] forCellReuseIdentifier:NSStringFromClass([ZHuanTiCell class])];
        
        //下拉刷新
        [_customTableView addHeaderWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        [_customTableView beginHeaderRefreshing];

    }
    return _customTableView;
}

@end
