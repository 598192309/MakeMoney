//
//  LqSegmentControl.h
//  FullShareTop
//
//  Created by lqq on 17/3/21.
//  Copyright © 2017年 FSB. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LqSegmentShowStyle) {
    LqSegmentShowDefaultStyle,
    LqSegmentShowCenterStyle
};

@interface LqSegmentControl : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, assign) LqSegmentShowStyle showStyle;


@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *normalHighlightedColor;
@property (nonatomic, strong) UIColor *selectNormalColor;
@property (nonatomic, strong) UIColor *selectHighlightedColor;
@property (nonatomic, assign) CGFloat normalAlpha;
@property (nonatomic, assign) NSInteger indicatorViewWidth;//指示器的宽度

- (void)reloadDataWithTitles:(NSArray *)titles selectedIndex:(NSInteger)selectIndex;

@property (nonatomic, copy) void(^selectedIndexBlock)(NSInteger originIndex,NSInteger newIndex);


@property (nonatomic, strong) UIFont *font;

/**
 控制分割线的显示与隐藏
 */
- (void)hiddenSeprateView:(BOOL)hidden;

/**
 控制指示器的显示与隐藏
 */
- (void)hiddenIndicatorView:(BOOL)hidden;

@end
