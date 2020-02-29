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
/**收藏 取消 */
@property (nonatomic, copy) void(^loveBlock)(EnlargeTouchSizeButton *sender);
@end

NS_ASSUME_NONNULL_END
