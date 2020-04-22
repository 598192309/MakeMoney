//
//  CityDetailCustomView.h
//  MakeMoney
//
//  Created by JS on 2020/4/22.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityListItem;
NS_ASSUME_NONNULL_BEGIN

@interface CityDetailCustomView : UIView
- (void)configUIWithItem:(CityListItem *)item finishi:(void(^)(void))finishBlock;
/**点击联系方式*/
@property(nonatomic,copy)void(^contactBtnClickBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
