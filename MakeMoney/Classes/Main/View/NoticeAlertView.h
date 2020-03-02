//
//  NoticeAlertView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GongGaoItem;
NS_ASSUME_NONNULL_BEGIN

@interface NoticeAlertView : UIView
-(void)refreshUIWithItme:(GongGaoItem *)item;
@property(nonatomic,copy)void(^noticeAlertViewRemoveBlock)(UIButton *sender);
@property(nonatomic,copy)void(^noticeAlertViewJumpBlock)(void);


@end

NS_ASSUME_NONNULL_END
