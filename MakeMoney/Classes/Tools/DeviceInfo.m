//
//  DeviceInfo.m
//  supermarket
//
//  Created by jayden on 2018/1/21.
//  Copyright © 2018年 Facebook. All rights reserved.
//

#import "DeviceInfo.h"
//设备ID
#import <UIKit/UIDevice.h>
#import <AdSupport/ASIdentifierManager.h>
#define kuuid @"KUUID"
// 设备型号
#import "sys/utsname.h"
//是否越狱
#define ARRAY_SIZE(a) sizeof(a)/sizeof(a[0])
const char* jailbreak_tool_pathes[] = {
  "/Applications/Cydia.app",
  "/Library/MobileSubstrate/MobileSubstrate.dylib",
  "/bin/bash",
  "/usr/sbin/sshd",
  "/etc/apt"
};
//运营商名称
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
//获取位置
#import <CoreLocation/CoreLocation.h>

//获取相册权限
//#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

#import <foundation/foundation.h>
#import "SAMKeychain.h"
@implementation DeviceInfo
+(NSString*)getDeviceId{
  NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; 
  return deviceId;
}
// 获取设备id  卸载会变的
+(NSString*)getUUID{
    NSString *uuid = [[NSUserDefaults standardUserDefaults] objectForKey:kuuid];
    NSString *md5UUId = [uuid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if (!uuid) {
        uuid = [[NSUUID UUID] UUIDString];
        //拼接随机参数 再MD5 此行别去可删
        int salt = 100000 + arc4random() %(999999 -100000 + 1);
        uuid = [uuid stringByAppendingString:[NSString stringWithFormat:@"%d",salt]];
        //md5
        md5UUId = [uuid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if(!md5UUId){
            return @"";
        }
        [[NSUserDefaults standardUserDefaults] setObject:md5UUId forKey:kuuid];
    }
    return md5UUId;
}

// 获取设备id  卸载  不变的
+(NSString*)getNerverChangeUUID{
    NSString *uuid = [SAMKeychain passwordForService:@"com.51778Vedio" account:@"uuid"];;
    NSString *md5UUId = uuid;
    if (!uuid) {
        [LSVProgressHUD showWithStatus:lqStrings(@"uuid变了")];
        uuid = [[NSUUID UUID] UUIDString];
        //拼接随机参数 再MD5 此行别去可删
        int salt = 100000 + arc4random() %(999999 -100000 + 1);
        uuid = [uuid stringByAppendingString:[NSString stringWithFormat:@"%d",salt]];
        //md5
        md5UUId = [uuid stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        if(!md5UUId){
            return @"";
        }
        [SAMKeychain setPassword: md5UUId  forService:@"com.51778Vedio"account:@"uuid"];
        
    }
    return md5UUId;
}


//手机生产商的标识码
+(NSString*)getIDFV{
  NSString * idfv = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
  return idfv;
}
//设备名称
+(NSString*)getDeviceName{
  return [UIDevice currentDevice].name;
}
//设备型号
+(NSString*)getMachineToIdevice{
  struct utsname systemInfo;
  uname(&systemInfo);
  NSString *machineString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
  return machineString;
}
//系统版本
+(NSString*)getSystemVersion{
  return [UIDevice currentDevice].systemVersion;
}
//国家码
+(NSString*)getCountryIso{
  NSLocale *currentLocale = [NSLocale currentLocale];
  NSString *countryCode = [currentLocale objectForKey:NSLocaleCountryCode];
  return countryCode;
}
//是否越狱
+(NSString*)getJailbreak{
  for (int i=0; i<ARRAY_SIZE(jailbreak_tool_pathes); i++) {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[NSString stringWithUTF8String:jailbreak_tool_pathes[i]]]) {
      NSLog(@"The device is jail broken!");
      return @"1";
    }
  }
  NSLog(@"The device is NOT jail broken!");
  return @"0";
}
//运营商名称
+(NSString*)getcarrierName{
  CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
  CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
  NSString *currentCountry=[carrier carrierName];
  //  NSLog(@"[carrier isoCountryCode]==%@,[carrier allowsVOIP]=%d,[carrier mobileCountryCode=%@,[carrier mobileCountryCode]=%@",[carrier isoCountryCode],[carrier allowsVOIP],[carrier mobileCountryCode],[carrier mobileNetworkCode]);
  //  [carrier isoCountryCode]==cn,[carrier allowsVOIP]=1,[carrier mobileCountryCode=460,[carrier mobileCountryCode]=01
  return currentCountry ? currentCountry : @"";
}
//系统启动时间
+(NSString*)getSystemUptime{
  NSProcessInfo *info = [NSProcessInfo processInfo];
  NSDate *now = [NSDate date];
  NSTimeInterval interval = [now timeIntervalSince1970];
  NSString * systemUptime = [NSString stringWithFormat:@"%.f",interval - info.systemUptime];;
  return systemUptime;
}
//电池还剩电量
+(NSString*)getBatteryLevel{
  [UIDevice currentDevice].batteryMonitoringEnabled = YES;
  double deviceLevel = [UIDevice currentDevice].batteryLevel;
  return [NSString stringWithFormat:@"%.f%%",deviceLevel*100];
}
//App获取位置的方式
+(NSString*)getAuthorizationStatus{
  /*
   授权状态为枚举值：
   kCLAuthorizationStatusNotDetermined                  //用户尚未对该应用程序作出选择
   kCLAuthorizationStatusRestricted                     //应用程序的定位权限被限制
   kCLAuthorizationStatusDenied                         //拒绝获取定位
   kCLAuthorizationStatusAuthorizedAlways               //一直允许获取定位
   kCLAuthorizationStatusAuthorizedWhenInUse            //在使用时允许获取定位
   kCLAuthorizationStatusAuthorized                     //已废弃，相当于一直允许获取定位
   */
  CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
  switch (status) {
    case kCLAuthorizationStatusNotDetermined:
      return @"NotDetermined";
    case kCLAuthorizationStatusRestricted:
      return @"StatusRestricted";
    case kCLAuthorizationStatusDenied:
      return @"StatusDenied";
    case kCLAuthorizationStatusAuthorizedAlways:
      return @"AuthorizedAlways";
    case kCLAuthorizationStatusAuthorizedWhenInUse:
      return @"AuthorizedWhenInUse";
      //    case kCLAuthorizationStatusAuthorized:
      //      return @"Authorized";
    default:
      break;
  }
  
  return @"";
}
//GPS状态
+(NSString*)getLocationServicesEnabled{
  return @([CLLocationManager locationServicesEnabled]).stringValue;
}
// 语言
+(NSString*)getPreferredLanguage{
  NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
  NSArray * allLanguages = [defaults objectForKey:@"AppleLanguages"];
  NSString * preferredLang = [allLanguages objectAtIndex:0];
  return preferredLang;
}
//时区
+(NSString*)getSystemTimeZone{
  return [NSString stringWithFormat:@"%@",[NSTimeZone systemTimeZone]];
}
//当前时间（时间戳+毫秒）
+(NSString*)getCurrentTime{
  return [NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970] *1000];
}
//手机屏幕亮度
+(NSString*)getBrightness{
  return  [NSString stringWithFormat:@"%.f%%",[[UIScreen mainScreen] brightness] * 100];
}
//手机电池状态
+(NSString*)getBatteryStatus{
  switch ([[UIDevice currentDevice] batteryState]) {
    case UIDeviceBatteryStateCharging:{
      if ([UIDevice currentDevice].batteryLevel == 1) {
        return @"Fully charged";
      } else {
        return @"Charging";
      }
    }
    case UIDeviceBatteryStateFull:
      return @"Fully charged";
    case UIDeviceBatteryStateUnplugged:
      return @"Unplugged";
    case UIDeviceBatteryStateUnknown:
      return @"Unknown";
  }
  return @"";
}
//内核版本
+(NSString*)getKernelVersion{
  struct utsname systemInfo;
  uname(&systemInfo);
  return  [NSString stringWithCString:systemInfo.version encoding:NSUTF8StringEncoding];
}

//App获取相册授权的方式
+(NSString*)getPictureAuthorizationStatus{
     __block PHAuthorizationStatus auth = [PHPhotoLibrary authorizationStatus];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        auth = status;
    }];
    
    if (auth == PHAuthorizationStatusRestricted || auth ==PHAuthorizationStatusDenied){
        //无权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:@"请您先去设置允许APP访问您的照片 设置>隐私>照片" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        [delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        return @"NO Permission";
    } else {//做你想做的（可以去打开设置的路径）
        return @"Permission";
    }
    
    
    
}

//App获取拍照授权的方式
+(NSString*)getTakePhotoAuthorizationStatus{
    __block AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//读取设备授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        authStatus = status;
    }];

    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //无权限 做一个友好的提示
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"温馨提示", nil) message:@"请您先去设置允许APP访问您的相机 设置>隐私>相机" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        [delegate.window.rootViewController presentViewController:alertController animated:YES completion:nil];
        return @"NO Permission";
    }else{
        return @"Permission";

    }
}

#pragma mark -- 判断手机型号
+(NSString*)judgeIphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString * phoneType = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    // simulator 模拟器
    
    if ([phoneType isEqualToString:@"i386"])   return @"Simulator";
    
    if ([phoneType isEqualToString:@"x86_64"])  return @"Simulator";
    
    //  常用机型  不需要的可自行删除
    
    if([phoneType  isEqualToString:@"iPhone1,1"])  return @"iPhone 2G";
    
    if([phoneType  isEqualToString:@"iPhone1,2"])  return @"iPhone 3G";
    
    if([phoneType  isEqualToString:@"iPhone2,1"])  return @"iPhone 3GS";
    
    if([phoneType  isEqualToString:@"iPhone3,1"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,2"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone3,3"])  return @"iPhone 4";
    
    if([phoneType  isEqualToString:@"iPhone4,1"])  return @"iPhone 4S";
    
    if([phoneType  isEqualToString:@"iPhone5,1"])  return @"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,2"])  return @"iPhone 5";
    
    if([phoneType  isEqualToString:@"iPhone5,3"])  return @"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone5,4"])  return @"iPhone 5c";
    
    if([phoneType  isEqualToString:@"iPhone6,1"])  return @"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone6,2"])  return @"iPhone 5s";
    
    if([phoneType  isEqualToString:@"iPhone7,1"])  return @"iPhone 6 Plus";
    
    if([phoneType  isEqualToString:@"iPhone7,2"])  return @"iPhone 6";
    
    if([phoneType  isEqualToString:@"iPhone8,1"])  return @"iPhone 6s";
    
    if([phoneType  isEqualToString:@"iPhone8,2"])  return @"iPhone 6s Plus";
    
    if([phoneType  isEqualToString:@"iPhone8,4"])  return @"iPhone SE";
    
    if([phoneType  isEqualToString:@"iPhone9,1"])  return @"iPhone 7";
    
    if([phoneType  isEqualToString:@"iPhone9,2"])  return @"iPhone 7 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    
    if([phoneType  isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    
    if([phoneType  isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    
    if([phoneType  isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    
    if([phoneType  isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    
    if([phoneType  isEqualToString:@"iPhone11,4"]) return @"iPhone XS Max";
    
    if([phoneType  isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
 
    if([phoneType  isEqualToString:@"iPhone12,1"])  return @"iPhone 11";
    
    if ([phoneType isEqualToString:@"iPhone12,3"])  return @"iPhone 11 Pro";
    
    if ([phoneType isEqualToString:@"iPhone12,5"])   return @"iPhone 11 Pro Max";
    
    
    return phoneType;
    
}

@end
