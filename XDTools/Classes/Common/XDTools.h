//
//  XDTools.h
//  Pods-XDTools_Example
//
//  Created by XiaoDev on 2018/11/30.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XDMacros.h"
NS_ASSUME_NONNULL_BEGIN
#define XDTOOLS [XDTools shareXTools]
#define kDeviceIsiPhoneX [XDTools shareXTools].isiPhoneX
#define kStatusBarHeight [XDTools shareXTools].statusBarHeight
#define kBottomBarHeight [XDTools shareXTools].bottomBarHeight
@interface XDTools : NSObject
+ (instancetype)shareXTools;
@property (nonatomic, assign)BOOL isiPhoneX;//是否是iPhone X系列。
@property (nonatomic, assign)CGFloat statusBarHeight;//状态栏高度
@property (nonatomic, assign)CGFloat bottomBarHeight; //底部栏高度
#pragma mark - 时间

/**
 整个程序的时间formater
 */
@property (nonatomic, strong)NSDateFormatter *dateFormatter;

/**
 单钱时间的日期戳
 */
@property (nonatomic, strong)NSString *dateStr;

/**
 当前时间的时间戳
 */
@property (nonatomic, strong)NSString *timeStr;
- (NSString *)latelyTimeStrFromDate:(NSDate *)date;
- (NSString *)timeStrFromDate:(NSDate *)date withFormat:(NSString *)formatter;
//时间和秒之间字符串的转换
- (double)timeStrToSecWithStr:(NSString *)str;
- (NSString *)timeSecToStrWithSec:(double)sec;
#pragma mark - 提示
- (void)showMessage:(NSString *)title;
- (void)showLoading:(NSString *)title;
- (void)hideLoading;

- (void)showAlertTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles completionHandler:(void (^)(NSInteger num))completionHandler;

#pragma mark - 文件计算
//获取单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath;
//文件夹的大小
- (float )folderSizeAtPath:(NSString*) folderPath;
//获取手机存储空间信息
- (float)allStorageSpace;
- (float)freeStorageSpace;
- (NSString *)storageSpaceStringWith:(float)space;
#pragma mark -- 加密md5
- (NSString *)md5Fromstr:(NSString *)str;
#pragma mark -- 设备
- (NSString *)currentDeviceModel;

@end

NS_ASSUME_NONNULL_END
