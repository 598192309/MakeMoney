//
//  SearchViewController.h
//  MakeMoney
//
//  Created by rabi on 2020/8/11.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "BaseViewController.h"
//视频类型
typedef NS_ENUM(NSInteger, SearchType) {
    SearchType_vedio = 0,//短视频
    SearchType_AV,//av
    SearchType_cartoon,//漫画

};
NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : BaseViewController
@property (nonatomic,assign)SearchType searchType;
@end

NS_ASSUME_NONNULL_END
