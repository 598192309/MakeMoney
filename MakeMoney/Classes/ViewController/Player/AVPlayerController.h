//
//  AVPlayerController.h
//  MakeMoney
//
//  Created by JS on 2020/3/2.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"
#import "HomeItem.h"
NS_ASSUME_NONNULL_BEGIN

@interface AVPlayerController : BaseViewController
+ (instancetype)controllerWith:(HotItem *)item;
@property (nonatomic,assign)BOOL isShortVideo;//针对 短视频点击查看完整视频的
@end

NS_ASSUME_NONNULL_END
