//
//  IncomeDetailCell.h
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExtendDetailItem;
NS_ASSUME_NONNULL_BEGIN

@interface IncomeDetailCell : UITableViewCell
- (void)configUIWithItem:(ExtendDetailItem *)item;

@end

NS_ASSUME_NONNULL_END
