//
//  XDMacros.h
//  Pods
//
//  Created by XiaoDev on 2018/12/4.
//

#ifndef XDMacros_h
#define XDMacros_h

#pragma mark - 单例

// @interface
#define Singleton_Interface(className) +(className *) defaultInstance;

// @implementation
#define Singleton_Implementation(className)                   \
static className *_instance;                              \
static dispatch_once_t onceToken;                         \
+(instancetype) allocWithZone : (struct _NSZone *) zone { \
dispatch_once(&onceToken, ^{                          \
_instance = [super allocWithZone:zone];           \
});                                                   \
return _instance;                                     \
}                                                         \
+(instancetype) defaultInstance {                         \
static dispatch_once_t onceToken;                     \
dispatch_once(&onceToken, ^{                          \
_instance = [[self alloc] init];                  \
});                                                   \
return _instance;                                     \
}

#define kUSerD [NSUserDefaults standardUserDefaults]
//观察者
#define kNOtificationC [NSNotificationCenter defaultCenter]
//文件管理器
#define kFileM    [NSFileManager defaultManager]
//单例Application
#define kAPPShared [UIApplication sharedApplication]
/******************************** 目录相关 ********************************/
#pragma mark - 目录相关
//document路径
#define KDocumentP [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Library目录
#define kLibraryP [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Cache目录
#define kCachesP [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
// Temp目录
#define kTmpP NSTemporaryDirectory()

#pragma mark - 设备相关
//是ipad
#define kIsPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//系统版本号
#define kIOSSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]
//当前应用版本 版本比较用
#define kAPPCurrentVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//屏幕的宽度,支持旋转屏幕
#define kScreenWidth  (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)


//屏幕的高度,支持旋转屏幕
#define kScreenHeight                                                                                  \
(UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]) \
? [UIScreen mainScreen].bounds.size.width                                               \
: [UIScreen mainScreen].bounds.size.height)


#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n", \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], \
__LINE__, \
[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

/*弱引用宏*/
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif


#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif



#endif /* XDMacros_h */
