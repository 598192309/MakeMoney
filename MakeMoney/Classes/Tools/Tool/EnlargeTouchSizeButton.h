//
//  EnlargeTouchSizeButton.h
//  Encropy
//
//  Created by Lqq on 2019/10/31.
//  Copyright © 2019 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EnlargeTouchSizeButton : UIButton
/**
 放大按钮的点击热区 响应热区
 
 touchSize为放大后的使用热区 放大规则为均匀向四周延展
 当touchisize 小于原frame时  热区值为原frame
 
 
 */
@property (nonatomic, assign)CGSize touchSize;

@end

NS_ASSUME_NONNULL_END
