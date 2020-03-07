//
//  MyLoveCell.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotItem,AblumItem;
NS_ASSUME_NONNULL_BEGIN

@interface MyLoveCell : UICollectionViewCell
- (void)refreshWithItem:(HotItem *)item;

//针对写真
- (void)refreshAblumWithItem:(AblumItem *)item;

@end

NS_ASSUME_NONNULL_END
