//
//  AblumItem.h
//  MakeMoney
//
//  Created by rabi on 2020/3/6.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AblumItem : NSObject

@property (nonatomic,strong)NSString *album_id;
@property (nonatomic,strong)NSString *album_name;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *description;
@property (nonatomic,assign)NSInteger img_count;
@property (nonatomic,strong)NSArray * imgs;
@property (nonatomic,strong)NSString * keywords;
@property (nonatomic,assign)NSInteger love;
@property (nonatomic,strong)NSString * see;
@property (nonatomic,assign)NSInteger status;

@end

NS_ASSUME_NONNULL_END
