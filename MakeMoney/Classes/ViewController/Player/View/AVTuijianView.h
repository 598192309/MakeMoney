//
//  AVTuijianView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVTuijianView : UIView
- (void)configUIWithItemArr:(NSArray *)itemArr finishi:(void(^)(void))finishBlock;

- (void)configCenterViewUIWithItem:(HotItem *)item  finishi:(void(^)(void))finishBlock;
- (void)configAds:(AdsItem *)item finishi:(void(^)(void))finishBlock;

/**点击CELL*/
@property(nonatomic,copy)void(^cellClickBlock)(NSIndexPath *indexPath);

/**收藏 取消 */
@property (nonatomic, copy) void(^loveBlock)(EnlargeTouchSizeButton *sender);
@end

NS_ASSUME_NONNULL_END
