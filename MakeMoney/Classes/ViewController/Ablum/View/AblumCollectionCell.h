//
//  AblumCollectionCell.h
//  MakeMoney
//
//  Created by JS on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AblumItem;
NS_ASSUME_NONNULL_BEGIN

@interface AblumCollectionCell : UICollectionViewCell
- (void)refreshAblumWithItem:(AblumItem *)item;
@end

NS_ASSUME_NONNULL_END
