//
//  RechargeCenterCustomView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RechargeCenterCustomView : UIView
/**点击查询 */
@property(nonatomic,copy)void(^rechargeCenterViewCheckBtnClickBlock)(UIButton * sender,UITextField *tf);
@end

NS_ASSUME_NONNULL_END
