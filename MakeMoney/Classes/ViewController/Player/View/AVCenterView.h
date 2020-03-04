//
//  AVCenterView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AdsItem,HotItem;
NS_ASSUME_NONNULL_BEGIN

@interface AVCenterView : UIView
- (void)configUIWithItem:(HotItem *)item finishi:(void(^)(void))finishBlock;
- (void)configAds:(AdsItem *)item finishi:(void(^)(void))finishBlock;
@end

NS_ASSUME_NONNULL_END
