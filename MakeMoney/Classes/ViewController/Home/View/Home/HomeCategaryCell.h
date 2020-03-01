//
//  HomeCategaryCell.h
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeCategaryCell : UICollectionViewCell
- (void)refreshCellWithItem:(HotItem *)item des:(NSString *)des;
@end

NS_ASSUME_NONNULL_END
