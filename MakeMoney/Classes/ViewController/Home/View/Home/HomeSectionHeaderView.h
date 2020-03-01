//
//  HomeSectionHeaderView.h
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionHeaderView : UICollectionReusableView

- (void)refreshViewWithVideo:(nullable HomeVideoList *)video;

@end

NS_ASSUME_NONNULL_END
