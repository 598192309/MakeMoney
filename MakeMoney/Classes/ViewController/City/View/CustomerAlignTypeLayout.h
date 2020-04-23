//
//  CustomerAlignTypeLayout.h
//  Encropy
//
//  Created by Lqq on 2019/8/13.
//  Copyright © 2019 Lq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,AlignType){
    AlignWithLeft,
    AlignWithCenter,
    AlignWithRight
};

//左对齐 右对齐 中心对齐
@interface CustomerAlignTypeLayout : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)AlignType cellType;

-(instancetype)initWthType :(AlignType)cellType;
@end
NS_ASSUME_NONNULL_END
