//
//  AVHeaderAdsImageView.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/8.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVHeaderAdsImageView : UIView
- (void)configUIWithItem:(AdsItem *)item finishi:(void(^)(void))finishBlock;

@end

NS_ASSUME_NONNULL_END
