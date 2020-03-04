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

@property (nonatomic,strong)NSString *video_type;//区分人气热榜 请求的API不同  video_type     1001 最新视频    1002 最多播放     1003 最多点赞




@end

NS_ASSUME_NONNULL_END
