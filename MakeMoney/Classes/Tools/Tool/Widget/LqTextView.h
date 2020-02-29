//
//  LqTextView.h
//  LqTool
//
//  Created by lqq on 2019/12/21.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LqTextView : UITextView
@property(nonatomic,copy) NSString *myPlaceholder;  //文字

@property(nonatomic,strong) UIColor *myPlaceholderColor; //文字颜色
@end

NS_ASSUME_NONNULL_END
