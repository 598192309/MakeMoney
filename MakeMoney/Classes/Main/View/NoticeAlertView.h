//
//  NoticeAlertView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeAlertView : UIView
-(void)refreshUIWithTitle:(NSString *)title  subTitle:(NSString *)subTitle;
@property(nonatomic,copy)void(^noticeAlertViewBlock)(UIButton *sender);

@end

NS_ASSUME_NONNULL_END
