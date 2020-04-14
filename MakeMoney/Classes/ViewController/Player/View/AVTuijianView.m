//
//  AVTuijianView.m
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "AVTuijianView.h"
#import "AVTuijianCell.h"
#import "AVCenterView.h"
#import "HomeItem.h"

@interface AVTuijianView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *customTableView;
@property (nonatomic,strong)NSArray *hotItemdataArr;
//中间 广告 title部分
@property (nonatomic,strong)AVCenterView *avCenterView;
@property (nonatomic,strong)UIView *tableHeaderV;
@end
@implementation AVTuijianView
#pragma mark - 生命周期
#pragma mark - 生命周期
-(instancetype)init{
    if (self = [super init]) {
        [self configUI];

    }
    return self;
}
#pragma mark - ui
-(void)configUI{
    __weak __typeof(self) weakSelf = self;
    [self addSubview:self.customTableView];
    [self.customTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakSelf);
    }];
    UIView *tableHeaderView = [[UIView alloc] init];
    _tableHeaderV = tableHeaderView;
    [tableHeaderView addSubview:self.avCenterView];
    [self.avCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(tableHeaderView);
    }];
    CGFloat H = [tableHeaderView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    tableHeaderView.lq_height = H;
    self.customTableView.tableHeaderView = tableHeaderView;
    self.customTableView.tableHeaderView.lq_height = H;
    
    [self avCenterViewAct];
}


#pragma mark - 刷新ui
- (void)configUIWithItemArr:(NSArray *)itemArr finishi:(void(^)(void))finishBlock{
    self.hotItemdataArr = itemArr;
    [self.customTableView reloadData];
    
    finishBlock();
}
- (void)configCenterViewUIWithItem:(HotItem *)item finishi:(void(^)(void))finishBlock{
    __weak __typeof(self) weakSelf = self;
    [self.avCenterView configUIWithItem:item finishi:^{
        CGFloat H = [weakSelf.avCenterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        weakSelf.tableHeaderV.lq_height = H;
        weakSelf.customTableView.tableHeaderView = weakSelf.tableHeaderV;
        weakSelf.customTableView.tableHeaderView.lq_height = H;
    }];
    
}

- (void)configAds:(AdsItem *)item finishi:(void(^)(void))finishBlock{
    __weak __typeof(self) weakSelf = self;
    [weakSelf.avCenterView configAds:item finishi:^{
        CGFloat H = [weakSelf.avCenterView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        weakSelf.tableHeaderV.lq_height = H;
        weakSelf.customTableView.tableHeaderView = weakSelf.tableHeaderV;
        weakSelf.customTableView.tableHeaderView.lq_height = H;
    }];
}

#pragma mark - act
- (void)avCenterViewAct{
    __weak __typeof(self) weakSelf = self;
    self.avCenterView.loveBlock = ^(EnlargeTouchSizeButton * _Nonnull sender) {
        if (weakSelf.loveBlock) {
            weakSelf.loveBlock(sender);
        }
    };
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return self.hotItemdataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AVTuijianCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AVTuijianCell class]) forIndexPath:indexPath];
    HotItem *item = [self.hotItemdataArr safeObjectAtIndex:indexPath.row];
    [cell refreshWithItem:item];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.cellClickBlock) {
        self.cellClickBlock(indexPath);
    }
}

#pragma mark - lazy
- (UITableView *)customTableView{
    if (!_customTableView) {
        _customTableView = [[UITableView alloc] init];
        _customTableView.backgroundColor = TitleWhiteColor;
        _customTableView.dataSource = self;
        _customTableView.delegate = self;
        _customTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _customTableView.showsVerticalScrollIndicator = NO;
        _customTableView.showsHorizontalScrollIndicator = NO;
        
        [_customTableView registerClass:[AVTuijianCell class] forCellReuseIdentifier:NSStringFromClass([AVTuijianCell class])];
        //高度自适应
        _customTableView.estimatedRowHeight=Adaptor_Value(110);
        _customTableView.rowHeight=UITableViewAutomaticDimension;
        

    }
    return _customTableView;
}

- (AVCenterView *)avCenterView{
    if (!_avCenterView) {
        _avCenterView = [AVCenterView new];
    }
    return _avCenterView;
}
@end
