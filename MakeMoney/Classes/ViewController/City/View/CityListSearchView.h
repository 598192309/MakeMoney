//
//  CityListSearchView.h
//  MakeMoney
//
//  Created by JS on 2020/4/23.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityListSearchView : UIView
/**点击关闭*/
@property(nonatomic,copy)void(^closeBlock)(void);
/**点击cell*/
@property(nonatomic,copy)void(^cellClickBlock)(NSIndexPath *indexpath);


@property (nonatomic,strong)NSMutableArray *dataArr;

@end

@interface LabelCollectionViewCell : UICollectionViewCell
- (void)configUIWithStr:(NSString *)str;
@end

NS_ASSUME_NONNULL_END
