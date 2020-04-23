//
//  AblumDetailNewCell.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/3/7.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class M_AblumImage;

@interface AblumDetailNewCell : UITableViewCell
- (void)refreshUIWithAblumImage:(M_AblumImage *)ablum;

- (void)refreshTongchengDetailUIWithImage:(UIImage *)image;


@property (nonatomic, copy) void(^imageSizeSetSuccessBlock)(void);

@end

@interface M_AblumImage : NSObject
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, assign) CGSize imageSize;
@end

NS_ASSUME_NONNULL_END
