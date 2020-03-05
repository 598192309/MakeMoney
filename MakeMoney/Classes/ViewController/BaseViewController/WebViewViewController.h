//
//  WebViewViewController.h
//  MakeMoney
//
//  Created by JS on 2020/3/5.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewViewController : BaseViewController
@property(nonatomic,strong)NSString *urlString;
@property(nonatomic,strong)NSString *htmlStr;
@property(nonatomic,strong)NSString *titleStr;
@property (nonatomic,strong)UIColor *backColor;
@end

NS_ASSUME_NONNULL_END
