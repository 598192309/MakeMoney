//
//  PopPayWayCell.h
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayWayItem;
NS_ASSUME_NONNULL_BEGIN

@interface PopPayWayCell : UITableViewCell
- (void)configUIWithItem:(PayWayItem *)item;
@end

NS_ASSUME_NONNULL_END
