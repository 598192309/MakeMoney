//
//  DouYinControlView.h
//  MakeMoney
//
//  Created by JS on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface DouYinControlView : UIView <ZFPlayerMediaControl>
- (void)resetControlView;

- (void)showCoverViewWithUrl:(NSString *)coverUrl withImageMode:(UIViewContentMode)contentMode;
@end

NS_ASSUME_NONNULL_END
