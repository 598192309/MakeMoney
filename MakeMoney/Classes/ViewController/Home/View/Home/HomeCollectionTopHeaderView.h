//
//  HomeCollectionTopHeaderView.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionTopHeaderView : UICollectionReusableView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

- (void)refreshUIWithTitle:(NSString *)title titleImageStr:(NSString *)titleImageStr tipBtnTitle:(NSString *)tipBtnTitle bannerImageUrlArr:(NSMutableArray  *)bannerImageUrlArr;

/**点击tipBtn*/
@property(nonatomic,copy)void(^headerViewTipBtnClickBlock)(UIButton *sender);

/**点击banner*/
@property(nonatomic,copy)void(^bannerClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
