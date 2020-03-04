//
//  VIPExchangeAlertView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/4.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VIPExchangeAlertView : UIView
/**点击确定*/
@property(nonatomic,copy)void(^vipExchangeAlertViewkConfirmBtnClickBlock)(UIButton * sender,UITextField *tf);

/**点击cover view */
@property(nonatomic,copy)void(^vipExchangeAlertViewkCoverViewClickBlock)(void);

-(void)refreshContent:(NSString *)content;
@end

NS_ASSUME_NONNULL_END
