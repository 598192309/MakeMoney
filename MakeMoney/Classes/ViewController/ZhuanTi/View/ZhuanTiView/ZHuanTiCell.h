//
//  ZHuanTiCell.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuanTiHomeItem,HotItem;
NS_ASSUME_NONNULL_BEGIN

@interface ZHuanTiCell : UITableViewCell
- (void)refreshWithItem:(ZhuanTiHomeItem*)item downImageType:(NSString *)downImageType;

//分类
- (void)refreshCategoryWithItem:(HotItem*)item downImageType:(NSString *)downImageType;

@end

NS_ASSUME_NONNULL_END
