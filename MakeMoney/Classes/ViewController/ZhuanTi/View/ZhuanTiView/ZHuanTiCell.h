//
//  ZHuanTiCell.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZhuanTiHomeItem;
NS_ASSUME_NONNULL_BEGIN

@interface ZHuanTiCell : UITableViewCell
- (void)refreshWithItem:(ZhuanTiHomeItem*)item;
@end

NS_ASSUME_NONNULL_END
