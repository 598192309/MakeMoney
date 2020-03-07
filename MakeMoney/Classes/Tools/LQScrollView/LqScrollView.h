//
//  LqScrollView.h
//  BaseScrollView
//
//  Created by lqq on 16/3/28.
//  Copyright © 2016年 lq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LqScrollView : UIScrollView
/**
 *  滑动偏移量
 */
@property (nonatomic, copy) void(^scrollOffsetXRadioBlock)(CGFloat offsetXRadio);


@property (nonatomic, copy) void(^scrollViewStopScrollBlock)(CGFloat endOffsetXRadio);

/**
 *  取消滑动的偏移量
 */
@property (nonatomic, copy) BOOL(^cancelSlide)(CGFloat offsetXRadio);

/**
 *  需要滑动的viewControlls
 */
@property (nonatomic, strong) NSMutableArray *viewControllers;

/**
 *  当前展示的下表
 */
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (void)scrollToControllerAtIndex:(NSInteger)index animated:(BOOL)animated;
@end
