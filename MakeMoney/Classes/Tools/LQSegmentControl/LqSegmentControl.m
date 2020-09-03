//
//  LqSegmentControl.m
//  FullShareTop
//
//  Created by lqq on 17/3/21.
//  Copyright © 2017年 FSB. All rights reserved.
//

#import "LqSegmentControl.h"
#import "SafeControl.h"
@interface LqSegmentControl ()

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *buttonsWidths;
@property (nonatomic, strong) NSMutableArray *buttonTextWidths;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger originIndex;

@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIView *seperateView;//底部分割线


@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end
@implementation LqSegmentControl

#pragma mark - Setter/Getter
- (void)setFont:(UIFont *)font{
    _font = font;
}

- (void)setNormalColor:(UIColor *)normalColor{
    _normalColor = normalColor;
}
- (void)setSelectNormalColor:(UIColor *)selectNormalColor{
    _selectNormalColor = selectNormalColor;
}


- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSMutableArray *)buttonsWidths
{
    if (_buttonsWidths == nil) {
        _buttonsWidths = [NSMutableArray array];
    }
    return _buttonsWidths;
}

- (NSMutableArray *)buttonTextWidths
{
    if (_buttonTextWidths == nil) {
        _buttonTextWidths = [NSMutableArray array];
    }
    return _buttonTextWidths;
}


- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollsToTop=NO;
        [self addSubview:_scrollView];
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)seperateView
{
    if (_seperateView == nil) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = [UIColor whiteColor];
    }
    return _seperateView;
}


- (UIView *)indicatorView
{
    if (_indicatorView == nil) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = [UIColor whiteColor];
    }
    return _indicatorView;
}

- (CAGradientLayer *)gradientLayer
{
    if (_gradientLayer == nil) {
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.colors = @[(__bridge id)[UIColor colorWithWhite:1 alpha:0].CGColor,
                                 (__bridge id)[UIColor colorWithWhite:1 alpha:0.9].CGColor,
                                  (__bridge id)[UIColor whiteColor].CGColor];
        _gradientLayer.startPoint = CGPointMake(0, 0.5);
        _gradientLayer.endPoint = CGPointMake(1, 0.5);
    }
    return _gradientLayer;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _config];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _config];
    }
    return self;
}

- (void)_config
{
    _font = AdaptedBoldFontSize(16);
    _showStyle = LqSegmentShowDefaultStyle;
    _normalColor = TitleGrayColor;
    _normalHighlightedColor = TitleGrayColor;
    _selectNormalColor = [UIColor whiteColor];
    _selectHighlightedColor = [UIColor whiteColor];
    _normalAlpha = 1;
    _indicatorViewWidth = 24;
}


- (void)reloadDataWithTitles:(NSArray *)titles selectedIndex:(NSInteger)selectIndex
{
    //清空
    [self.buttons removeAllObjects];
    [self.buttonsWidths removeAllObjects];
    [self.buttonTextWidths removeAllObjects];
    
    //移除按钮
    for (UIView *subView in self.scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    
    _titles = titles;
    //添加按钮
    for (int i = 0 ; i < _titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [self configNormalBtnStyle:btn];
        btn.titleLabel.font =_font;
        [btn addTarget:self action:@selector(butClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttons addObject:btn];
        [self.scrollView addSubview:btn];
//        btn.backgroundColor =  [UIColor colorWithRed:arc4random() % 255 / 255.0 green:arc4random() % 255 / 255.0 blue:arc4random() % 255 / 255.0 alpha:1];
        [btn sizeToFit];
        [self.buttonTextWidths addObject:@(btn.frame.size.width)];
        [self.buttonsWidths addObject:@(btn.frame.size.width + 30)];
        
    }
    
    [self.scrollView addSubview:self.seperateView];
    [self.scrollView addSubview:self.indicatorView];
    [self.layer addSublayer:self.gradientLayer];
    [self layoutSubviews];
    
    
    _selectedIndex = selectIndex;
    [self changeButtonsStatusSelectIndex:_selectedIndex originIndex:_selectedIndex];
}



- (void)layoutSubviews
{
    self.scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    CGFloat totalWidth = 0;
    for (NSNumber *value in self.buttonsWidths) {
        totalWidth += [value floatValue];
    }
    
    switch (_showStyle) {
        case LqSegmentShowDefaultStyle:
        {
            CGFloat width = 0;
            for (int i= 0 ; i < self.buttons.count; ++i) {
                UIButton *btn = self.buttons[i];
                CGFloat btnWidth = [self.buttonsWidths[i] floatValue];
                btn.frame = CGRectMake(width, 0, btnWidth, self.scrollView.frame.size.height);
                width += btnWidth;
            }
            totalWidth += 2*35 - 15;
            
            self.scrollView.contentSize = CGSizeMake(totalWidth > self.scrollView.frame.size.width ? totalWidth : self.scrollView.frame.size.width, 0);
            self.seperateView.frame = CGRectMake(0, self.scrollView.lq_height - 1/[[UIScreen mainScreen] scale], self.scrollView.contentSize.width, 1/[[UIScreen mainScreen] scale]);
            
            UIButton *selectButton = SAFE_VALUE_AT_INDEX(_buttons, _selectedIndex);
            self.indicatorView.frame = CGRectMake(0, self.lq_height - 2, _indicatorViewWidth, 2);
            self.indicatorView.lq_centerX = selectButton.lq_centerX;
            
            self.gradientLayer.frame = CGRectMake(self.lq_width - 2*34, 0, 2*34, self.lq_height);
        }
            break;
        case LqSegmentShowCenterStyle:
        {
            if (totalWidth > self.scrollView.frame.size.width) {
                CGFloat width = 0;
                for (int i= 0 ; i < self.buttons.count; ++i) {
                    UIButton *btn = self.buttons[i];
                    CGFloat btnWidth = [self.buttonsWidths[i] floatValue];
                    btn.frame = CGRectMake(width, 0, btnWidth, self.scrollView.frame.size.height);
                    width += btnWidth;
                }
            } else{
                CGFloat btnWidth = self.scrollView.frame.size.width / self.buttons.count;
                for (int i= 0 ; i < self.buttons.count; ++i) {
                    UIButton *btn = self.buttons[i];
                    btn.frame = CGRectMake(i * btnWidth, 0, btnWidth, self.scrollView.frame.size.height);
                }
            }
            
            
            self.scrollView.contentSize = CGSizeMake(totalWidth > self.scrollView.frame.size.width ? totalWidth : self.scrollView.frame.size.width, 0);
            self.seperateView.frame = CGRectMake(0, self.scrollView.lq_height - 1/[[UIScreen mainScreen] scale], self.scrollView.contentSize.width, 1/[[UIScreen mainScreen] scale]);
            
            UIButton *selectButton = SAFE_VALUE_AT_INDEX(_buttons, _selectedIndex);
            self.indicatorView.frame = CGRectMake(0, self.lq_height - 3, _indicatorViewWidth, 3);
            self.indicatorView.lq_centerX = selectButton.lq_centerX;
            
            self.gradientLayer.hidden = YES;
        }
            break;
            
        default:
            break;
    }
    
    if (totalWidth <= self.scrollView.frame.size.width) { //小于屏幕宽度
        
        
        
    } else {
    
        
    }
    
    
}

- (void)butClicked:(UIButton *)btn
{
    NSInteger newIndex = [self.buttons indexOfObject:btn];
    NSInteger originIndex = self.selectedIndex;
    if (originIndex == newIndex) {
        return;
    }
    
    [self setSelectedIndex:newIndex];
    if (self.selectedIndexBlock) {
        self.selectedIndexBlock(originIndex ,newIndex);
    }
    
}


- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex) {
        return;
    }
    [self changeButtonsStatusSelectIndex:selectedIndex originIndex:_selectedIndex];
    
    _selectedIndex = selectedIndex;
    
}




- (void)changeButtonsStatusSelectIndex:(NSInteger)selectIndex originIndex:(NSInteger)originIndex
{
    UIButton *originBtn = self.buttons[originIndex];
    UIButton *selectBtn = self.buttons[selectIndex];
    
    
    [UIView animateWithDuration:0.15 animations:^{
        [self configNormalBtnStyle:originBtn];
        [self configSelectBtnStyle:selectBtn];
        self.indicatorView.frame = CGRectMake(0, self.lq_height - 3, self->_indicatorViewWidth, 3);
        self.indicatorView.lq_centerX = selectBtn.lq_centerX;
    }];
    
    
    
    CGFloat selectBtnCenterX = selectBtn.center.x;
    CGFloat scrollViewWidth = _scrollView.frame.size.width;
    if (selectBtnCenterX <= scrollViewWidth / 2) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else if (selectBtnCenterX >= _scrollView.contentSize.width - scrollViewWidth / 2) {
        [_scrollView setContentOffset:CGPointMake(_scrollView.contentSize.width - scrollViewWidth, 0) animated:YES];
    } else {
        [_scrollView setContentOffset:CGPointMake(selectBtnCenterX - scrollViewWidth / 2, 0) animated:YES];
    }
}

- (void)exChangeButtonTransformWithoffsetXRatio:(CGFloat)offsetXRatio{
    
}


/**
 控制分割线的显示与隐藏
 */
- (void)hiddenSeprateView:(BOOL)hidden
{
    self.seperateView.hidden = hidden;
}

/**
 控制指示器的显示与隐藏
 */
- (void)hiddenIndicatorView:(BOOL)hidden
{
    self.indicatorView.hidden = hidden;
}

- (void)configSelectBtnStyle:(UIButton *)btn
{
    [btn setTitleColor:_selectNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:_selectHighlightedColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = _font;
    btn.alpha = 1;
}

- (void)configNormalBtnStyle:(UIButton *)btn
{
    [btn setTitleColor:_normalColor forState:UIControlStateNormal];
    [btn setTitleColor:_normalHighlightedColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = _font;
    btn.alpha = _normalAlpha;;
}

@end
