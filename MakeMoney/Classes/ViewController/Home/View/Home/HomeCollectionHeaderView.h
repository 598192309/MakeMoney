//
//  HomeCollectionHeaderView.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionHeaderView : UICollectionReusableView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;

- (void)refreshUIWithTitle:(NSString *)title tipBtnTitle:(NSString *)tipBtnTitle;

/**点击tipBtn*/
@property(nonatomic,copy)void(^headerViewTipBtnClickBlock)(UIButton *sender);
@end

NS_ASSUME_NONNULL_END
