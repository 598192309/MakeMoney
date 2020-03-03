//
//  RechargeCenterCell.h
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayCenterInfotem;
NS_ASSUME_NONNULL_BEGIN

@interface RechargeCenterCell : UITableViewCell
/**点击buy */
@property(nonatomic,copy)void(^rechargeCenterBuyBtnClickBlock)(UIButton * sender);

- (void)refreshUIWithItem:(PayCenterInfotem *)item;
@end

NS_ASSUME_NONNULL_END
