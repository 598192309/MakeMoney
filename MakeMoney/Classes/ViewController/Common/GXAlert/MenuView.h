//
//  MenuView.h
//  GXAlertSample
//
//  Created by Gin on 2020/3/25.
//  Copyright © 2020 gin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MenuView : UIView
/**点击*/
@property(nonatomic,copy)void(^cellClickBlock)(NSString *str,NSInteger index);
@end

NS_ASSUME_NONNULL_END
