//
//  UIStoryboard+LqExtension.h
//  LqTool
//
//  Created by lqq on 2019/12/20.
//  Copyright © 2019 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIStoryboard (LqExtension)
/**
 根据 storyBoardName 和 storyBoard里控制器的storyBoardIdentify 获取对应的控制器
 */
+ (id)lq_controllerWithStoryBoardIdentify:(NSString *)storyBoardIdentify inStoryBoard:(NSString *)storyBoardName;
@end

NS_ASSUME_NONNULL_END
