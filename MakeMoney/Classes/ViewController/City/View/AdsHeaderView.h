//
//  AdsHeaderView.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AdsHeaderView : UICollectionReusableView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

//获取底部视图对象
+ (instancetype)footerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

- (void)refreshUIWithImageStr:(NSString *)titleImageStr;

/**点击tipBtn*/
@property(nonatomic,copy)void(^headerViewTipBtnClickBlock)(UIButton *sender);

- (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
