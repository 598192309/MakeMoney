//
//  AVViewController.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVViewController.h"
#import "AVCell.h"

@interface AVViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;

@end

@implementation AVViewController
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


#pragma mark -  net
-(void)requestData{
//    if (homeDataItem.lists.count >= 10 && !homeDataItem.have_follow) {
//        [weakSelf.customTableView addFooterWithRefreshingTarget:self refreshingAction:@selector(requestMoreData)];
//        [weakSelf.customTableView.mj_footer setHidden:NO];
//
//    }else{
//        [weakSelf.customTableView endHeaderRefreshing];
//        //消除尾部"没有更多数据"的状态
//        [weakSelf.customTableView.mj_footer setHidden:YES];
//
//    }
    __weak __typeof(self) weakSelf = self;
    [weakSelf.customTableView endHeaderRefreshing];
    [weakSelf.customTableView reloadData];
    
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AVCell class]) forIndexPath:indexPath];
    [cell refreshWithItem: nil];
    return cell;


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
