//
//  LQTabBar.h
//  MakeMoney
//
//  Created by rabi on 2020/4/23.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LXTabBarItem;
@protocol LQTabBarDelegate;
@interface LQTabBar : UITabBar

@property (nonatomic, strong)NSArray<LXTabBarItem *> *lzItems;
@property (nonatomic, assign)id <LQTabBarDelegate> lzDelegate;
@end

@protocol LQTabBarDelegate <NSObject>

- (void)tabBar:(LQTabBar *)tab didSelectItem:(LXTabBarItem *)item atIndex:(NSInteger)index ;

@end


@protocol LXTabBarItemDelegate;
@interface LXTabBarItem : UIView

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) id <LXTabBarItemDelegate> delegate;
@end

@protocol LXTabBarItemDelegate <NSObject>

- (void)tabBarItem:(LXTabBarItem *)item didSelectIndex:(NSInteger)index;
@end
NS_ASSUME_NONNULL_END
