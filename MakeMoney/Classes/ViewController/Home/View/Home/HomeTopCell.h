//
//  HomeTopCell.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTopCell : UICollectionViewCell

- (void)refreshWithItem:(NSObject*)item hiddenTitle:(BOOL)hiddenTitle;
@end

NS_ASSUME_NONNULL_END
