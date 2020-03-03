//
//  MyShareCustomView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyShareCustomView : UIView
/**点击切换样式*/
@property(nonatomic,copy)void(^myshareCustomHeaderViewChangeBtnClickBlock)(EnlargeTouchSizeButton * sender,NSDictionary *dict);

/**点击保存*/
@property(nonatomic,copy)void(^myshareCustomHeaderViewSaveBtnClickBlock)(EnlargeTouchSizeButton * sender,NSDictionary *dict);

/**点击copy*/
@property(nonatomic,copy)void(^myshareCustomHeaderViewCopyBtnClickBlock)(EnlargeTouchSizeButton * sender,NSDictionary *dict);
@end

NS_ASSUME_NONNULL_END
