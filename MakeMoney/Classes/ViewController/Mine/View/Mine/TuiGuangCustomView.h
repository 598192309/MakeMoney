//
//  TuiGuangCustomView.h
//  MakeMoney
//
//  Created by rabi on 2020/3/3.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ExtendDetailItem;
NS_ASSUME_NONNULL_BEGIN

@interface TuiGuangCustomView : UIView
/**查看明细*/
@property(nonatomic,copy)void(^tuiGuangCustomViewCheckBtnClickBlock)(UIButton * sender,NSDictionary *dict);
- (void)configUIWithItem:(ExtendDetailItem *)item;
@end

NS_ASSUME_NONNULL_END
