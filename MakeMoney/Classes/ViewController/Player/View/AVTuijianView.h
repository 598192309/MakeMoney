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
@end

NS_ASSUME_NONNULL_END
