//
//  MenuView.m
//  GXAlertSample
//
//  Created by Gin on 2020/3/25.
//  Copyright © 2020 gin. All rights reserved.
//

#import "MenuView.h"

@interface MenuView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)NSArray *dataArr;
@end

@implementation MenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArr = @[@"土豆福利分享群",
                     @"云盘回家地址",
                    @"github回家地址",
                     [NSString stringWithFormat:@"官方客服QQ:%@",RI.basicItem.qq],
                     [NSString stringWithFormat:@"官方邮箱:%@",RI.basicItem.email]
        ];
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    self.tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    self.tableView.rowHeight = 50.0;
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
    self.tableView.scrollEnabled = NO;
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dataArr safeObjectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellClickBlock) {
        self.cellClickBlock([self.dataArr safeObjectAtIndex:indexPath.row],indexPath.row);
    }
}

@end
