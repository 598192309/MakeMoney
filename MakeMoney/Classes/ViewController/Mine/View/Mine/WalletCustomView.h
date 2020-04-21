//
//  WalletCustomView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WalletCustomView : UIView
/**点击提现 */
@property(nonatomic,copy)void(^walletCustomViewCashBtnClickBlock)(UIButton * sender,NSDictionary *dict);

- (void)refreshMoney:(NSString *)money gold:(NSString*)gold;
@end

NS_ASSUME_NONNULL_END
