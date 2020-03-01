//
//  HomeItem.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeItem.h"


@implementation GongGaoItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end

@implementation AdsItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

- (void)setImg:(NSString *)img
{
    _img = img;
    __weak __typeof(self) weakSelf = self;

   
//    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:img] options:SDWebImageDownloaderHighPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        NSLog(@"receivedSize:%zd",receivedSize);
//    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
//        if (image) {
//            weakSelf.imageSize = image.size;
//        }
//    }];
}

@end

@implementation HomeVideoList
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"lists" :[HotItem class]};
}
@end


@implementation HotItem
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"ID":@"id"
             };
}

@end


@implementation HomeInfoItem
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"most_new" :[HotItem class],
             @"most_play" :[HotItem class],
             @"most_love" :[HotItem class],
             @"ads" :[AdsItem class],
             @"video" :[HomeVideoList class],

             };
}
@end
