//
//  AVCell.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/2/28.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotItem;
NS_ASSUME_NONNULL_BEGIN

@interface AVCell : UITableViewCell
- (void)refreshWithItem:(HotItem*)item;

@end

NS_ASSUME_NONNULL_END
