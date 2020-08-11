//
//  SearchCollectionHeaderView.h
//  MakeMoney
//
//  Created by rabi on 2020/8/11.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SearchCollectionHeaderView : UICollectionReusableView
//获取顶部视图对象
+ (instancetype)headerViewWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath;
- (void)configUIWithArr:(NSArray *)arr;

@property(nonatomic,copy)void(^hotcellClickBlock)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
