//
//  LqScrollView.m
//  BaseScrollView
//
//  Created by lqq on 16/3/28.
//  Copyright © 2016年 lq. All rights reserved.
//

#import "LqScrollView.h"

@interface LqScrollView ()<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger cancleBeginIndex; //


@end

@implementation LqScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCommon];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupCommon];
    }
    return self;
}

- (void)setupCommon
{
    self.pagingEnabled = YES;
    self.bounces = YES;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (NSInteger)selectedIndex
{
    return self.contentOffset.x / self.frame.size.width;
}

- (void)setViewControllers:(NSMutableArray *)viewControllers
{
    _viewControllers = viewControllers;
    self.contentSize = CGSizeMake(viewControllers.count * self.frame.size.width, 0);
    self.delegate = self;
    for (UIViewController *viewController in self.viewController.childViewControllers) {
        [viewController removeFromParentViewController];
    }
    
    for (int i = 0; i < viewControllers.count ; ++i) {
        UIViewController *vc = viewControllers[i];
        [self.viewController addChildViewController:vc];
        if (i == self.selectedIndex) {
            vc.view.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
            [self addSubview:vc.view];
        }
    }
}



#pragma mark <生命周期>


#pragma mark <Method>
- (void)scrollToControllerAtIndex:(NSInteger)index animated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(index * self.frame.size.width, 0) animated:animated];
    
}



#pragma mark <UIScrollViewDelegate>
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _cancleBeginIndex = -1;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetXRadio = scrollView.contentOffset.x / scrollView.frame.size.width;
    
    if (self.cancelSlide) {
        if (self.cancelSlide(offsetXRadio)) {
            if (_cancleBeginIndex < 0) {
                _cancleBeginIndex = offsetXRadio + 0.5;
            }
            [self scrollToControllerAtIndex:_cancleBeginIndex animated:NO]; //四射五入
            scrollView.decelerationRate = 0;
            return;
        }
    }
    
    
    NSInteger left = floor(offsetXRadio);
    NSInteger right = ceil(offsetXRadio);
    if (left < 0) {
        right = left = 0;
    }
    
    if (right > self.viewControllers.count - 1) {
        left = right = self.viewControllers.count - 1;
    }
    
    UIViewController *leftVC = [self.viewControllers objectAtIndex:left];
    UIViewController *rightVC = [self.viewControllers objectAtIndex:right];
    if (leftVC == rightVC) {
        if (leftVC.view.superview == nil || (leftVC.view.frame.origin.x != left*scrollView.frame.size.width)) {
            leftVC.view.frame = CGRectMake(left*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            [scrollView addSubview:leftVC.view];
        }
        for (UIView *subView in scrollView.subviews) {
            if (subView != leftVC.view) {
                [subView removeFromSuperview];
            }
        }
    } else {
        if (leftVC.view.superview == nil) {
            leftVC.view.frame = CGRectMake(left*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            [scrollView addSubview:leftVC.view];
        }
        if (rightVC.view.superview == nil) {
            rightVC.view.frame = CGRectMake(right*scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height);
            [scrollView addSubview:rightVC.view];
        }
    }
    
    if (self.scrollOffsetXRadioBlock) {
        self.scrollOffsetXRadioBlock(offsetXRadio);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.scrollViewStopScrollBlock) {
        self.scrollViewStopScrollBlock(scrollView.contentOffset.x / scrollView.frame.size.width);
    }
}

- (UIViewController *)viewController
{
    for (UIView *next = self.superview ; next ; next = next.superview) {
        UIResponder *nextRespond = [next nextResponder];
        if ([nextRespond isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextRespond;
        }
    }
    return nil;
}



#pragma mark 手势
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event     {
    if (point.x < 40) { // location.x为系统的某个点的x
        return nil;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

@end
