//
//  ShareView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotItem;
NS_ASSUME_NONNULL_BEGIN

@interface ShareView : UIView
-(void)refreshUIWithItme:(HotItem *)item;

/**点击保存*/
@property(nonatomic,copy)void(^saveBtnClickBlock)(UIButton * sender,UIImageView *erweimaImageV);

/**点击copy*/
@property(nonatomic,copy)void(^copyBtnClickBlock)(UIButton * sender,UIImageView *erweimaImageV);

/**tap*/
@property(nonatomic,copy)void(^tapClickBlock)(void);
@end

NS_ASSUME_NONNULL_END
