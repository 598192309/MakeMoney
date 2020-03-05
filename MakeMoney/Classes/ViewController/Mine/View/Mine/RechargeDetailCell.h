//
//  RechargeDetailCell.h
//  MakeMoney
//
//  Created by rabi on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayRecordItem;
NS_ASSUME_NONNULL_BEGIN

@interface RechargeDetailCell : UITableViewCell
- (void)configUIWithItem:(PayRecordItem *)item;
@end

NS_ASSUME_NONNULL_END
