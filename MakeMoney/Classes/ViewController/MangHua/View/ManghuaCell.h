//
//  ManghuaCell.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MangHuaDetailItem;
NS_ASSUME_NONNULL_BEGIN

@interface ManghuaCell : UICollectionViewCell
- (void)refreshWithItem:(MangHuaDetailItem*)item;

@end

NS_ASSUME_NONNULL_END
