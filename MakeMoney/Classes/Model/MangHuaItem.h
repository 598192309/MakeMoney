//
//  MangHuaItem.h
//  MakeMoney
//
//  Created by 黎芹 on 2020/8/18.
//  Copyright © 2020 lqq. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface MangHuaDetailItem : NSObject
@property (nonatomic,strong)NSString *author;
@property (nonatomic,strong)NSString *chapter;
@property (nonatomic,strong)NSString *click;
@property (nonatomic,strong)NSString *cover_url;
@property (nonatomic,strong)NSString *create_time;
@property (nonatomic,strong)NSString *Description;
@property (nonatomic,strong)NSString *ext_cover_url;
@property (nonatomic,strong)NSString *folder;
@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *keywords;
@property (nonatomic,strong)NSString *love;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)NSString *tag;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *type;

@end

@interface MangHuaItem : NSObject
@property (nonatomic,strong)NSArray *hotLists;
@property (nonatomic,strong)NSArray *NewLists;
@property (nonatomic,strong)NSArray *guessLists;

@end

NS_ASSUME_NONNULL_END
