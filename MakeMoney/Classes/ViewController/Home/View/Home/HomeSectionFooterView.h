//
//  HomeSectionFooterView.h
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeSectionFooterView : UICollectionReusableView
- (void)refreshViewWith:(AdsItem *)item;
@property (nonatomic, copy) void(^imageLoadSuccess)();
@end

NS_ASSUME_NONNULL_END
