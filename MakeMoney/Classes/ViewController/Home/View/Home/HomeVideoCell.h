//
//  HomeVideoCell.h
//  MakeMoney
//
//  Created by JS on 2020/3/1.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeVideoCell : UICollectionViewCell
- (void)refreshCellWithItem:(HotItem *)item videoType:(VideoType)type;

//针对最新上传 最多播放 最多点赞 全部分类里进来 要显示
- (void)setLoveBtnAppear:(BOOL)appear;
@end

NS_ASSUME_NONNULL_END
