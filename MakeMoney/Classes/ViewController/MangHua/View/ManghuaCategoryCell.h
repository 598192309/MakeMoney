//
//  ManghuaCategoryCell.h
//  MakeMoney
//
//  Created by rabi on 2020/9/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MangHuaDetailItem;
NS_ASSUME_NONNULL_BEGIN

@interface ManghuaCategoryCell : UITableViewCell
- (void)refreshWithItem:(MangHuaDetailItem*)item;

@end

NS_ASSUME_NONNULL_END
