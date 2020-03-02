//
//  ListViewController.h
//  MakeMoney
//
//  Created by rabi on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : BaseViewController
@property (nonatomic,strong)NSString *navTitle;
@property (nonatomic,strong)NSString *tag;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *type;

@end

NS_ASSUME_NONNULL_END
