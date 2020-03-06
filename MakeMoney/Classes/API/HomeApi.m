//
//  HomeApi.m
//  MakeMoney
//
//  Created by rabi on 2020/2/26.
//  Copyright © 2020 lqq. All rights reserved.
//

#import "HomeApi.h"
#import "HomeItem.h"
@implementation HomeApi

/******************热门页视频列表  就是首页

 *********************/
+ (NetworkTask *)requestHotListSuccess:(void(^)(HomeInfoItem * homeInfoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/hot/data" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        HomeInfoItem *homeInfoItem = [HomeInfoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(homeInfoItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/********************公告*********************/
+ (NetworkTask *)requestGongGaoSuccess:(void(^)(GongGaoItem *gongGaoItem,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/notice/find" parameters:nil criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        GongGaoItem *gongGaoItem = [GongGaoItem mj_objectWithKeyValues:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(gongGaoItem,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/********************广告
 type：
  
 0;   //热门页banner
 1;    //同城banner
 2;  //短视频列表
 3;  //av列表
 4;  //av详情页
 5;  //同城底部
 6;   //同城详情
 7;   //热门页列表
 8;  //video详情播放
 9;  //av详情播放
 100;   //启动页
 
 *********************/
+ (NetworkTask *)requestAdWithType:(NSString *)type Success:(void(^)(NSArray *adsItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/ads/find" parameters:@{@"type":SAFE_NIL_STRING(type)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *adsItemArr = [AdsItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(adsItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


/*******************分类视频列表
 type_id        热门页全部分类 获取的tag
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestHotCategoryListwithType_id:(NSString *)type_id pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/video/tag" parameters:@{@"type_id":SAFE_NIL_STRING(type_id),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************热门视频列表更多
 tag        默认传 0           热门页视频列表 获取
 text       默认传 51778       热门页视频列表 获取
 type       0 短视频   1 AV    热门页视频列表 获取
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestHotListMorewithTag:(NSString *)tag text:(NSString *)text type:(NSString *)type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/hot_list/video" parameters:@{@"tag":SAFE_NIL_STRING(tag),@"text":SAFE_NIL_STRING(text),@"type":SAFE_NIL_STRING(type),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}
/*******************热门页全部分类
 {
     "create_time": 1582362067,
     "id": 1,
     "img": "",
     "sort": 1,
     "status": 0,
     "tag": 1,
     "text": "",
     "title": "成人自拍",
     "type": 0
 }
 *********************/
+ (NetworkTask *)requestAllHotListwithPageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/v_type/find" parameters:@{@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}



/*******************人气榜详情列表
 video_type     1001 最新视频    1002 最多播放     1003 最多点赞
 page_index
 page_size
 *********************/
+ (NetworkTask *)requestPopularityListwithVideoType:(NSString *)video_type pageIndex:(NSString *)page_index page_size:(NSString *)page_size Success:(void(^)(NSArray *hotItemArr,NSString *msg))successBlock error:(ErrorBlock)errorBlock{
    return [NET POST:@"/api/video/more_hot" parameters:@{@"video_type":SAFE_NIL_STRING(video_type),@"page_index":SAFE_NIL_STRING(page_index),@"page_size":SAFE_NIL_STRING(page_size)} criticalValue:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSArray *hotItemArr = [HotItem mj_objectArrayWithKeyValuesArray:[resultObject safeObjectForKey:@"data"]];
        NSString *msg = [resultObject safeObjectForKey:@"msg"];
        if (successBlock) {
            successBlock(hotItemArr,msg);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}

/*******************下载图片
 video_type: 是拼接在后的host 有v_imgs a_imgs
 *********************/
+ (NetworkTask *)downImageWithType:(NSString *)video_type paramTitle:(NSString *)paramTitle ID:(NSString *)ID key:(NSString *)key Success:(void(^)(UIImage *img,NSString *ID))successBlock error:(ErrorBlock)errorBlock{
    NSString *apistr = [NSString stringWithFormat:@"/api/%@",video_type];
    NSString *imageKey = [RSAEncryptor MD5WithString:[NSString stringWithFormat:@"%@-%@-%@-%@",video_type,paramTitle,ID,key]];
    NSString *imageDir = [LqSandBox docDownloadImagePath];
    NSString *imagePath = [imageDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",imageKey]];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        successBlock([UIImage imageWithContentsOfFile:imagePath],ID);
        return nil;
    }

    return [NET POST:apistr parameters:@{paramTitle:SAFE_NIL_STRING(ID)} criticalValue:@{@"NoEncode":@YES} success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
//        NSString *img = resultObject;
//        UIImage *downImage = [UIImage base64stringToImage:img];
//        BOOL success = [UIImagePNGRepresentation(downImage) writeToFile:imagePath atomically:YES];
//        if (successBlock) {
//            successBlock(downImage,ID);
//        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *img = resultObject;
            UIImage *downImage = [UIImage base64stringToImage:img];
            BOOL success = [UIImagePNGRepresentation(downImage) writeToFile:imagePath atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (successBlock) {
                    successBlock(downImage,ID);
                }
            });
        });
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, id _Nonnull resultObject) {
        if (errorBlock) {
            errorBlock(error,resultObject);
        }
    }];
}


@end
