//
//  ZhuanTiItem.h
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhuanTiHomeItem : NSObject
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *img;
@property (nonatomic,assign)NSInteger sort;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger tag;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,assign)NSInteger type;
@end

NS_ASSUME_NONNULL_END
