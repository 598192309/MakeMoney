//
//  CityCell.h
//  MakeMoney
//
//  Created by rabi on 2020/2/28.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityListItem;
NS_ASSUME_NONNULL_BEGIN

@interface CityCell : UICollectionViewCell
- (void)refreshWithItem:(CityListItem*)item;
@end

NS_ASSUME_NONNULL_END
