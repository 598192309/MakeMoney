//
//  GroupCoinSegmentrol.h
//  Encropy
//
//  Created by Lqq on 2019/8/20.
//  Copyright © 2019 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GroupCoinSegmentrol : UIView
- (instancetype)initWithTitleItems:(NSArray *)items;

@property (nonatomic, copy) void(^selectedIndexBlock)(NSInteger originIndex,NSInteger newIndex);

@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong)UIColor *titleSelectedColor;
@property (nonatomic, strong)UIColor *titleNormalColor;


@property (nonatomic, assign) CGFloat indicateViewWidth;

@end

NS_ASSUME_NONNULL_END
