//
//  XDTools.m
//  Pods-XDTools_Example
//
//  Created by XiaoDev on 2018/11/30.
//

#import "XDTools.h"
#include "sys/stat.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface XDTools()

@property (nonatomic, strong)UIActivityIndicatorView   *activityView;
@property (nonatomic, strong)UILabel                   *activityLabel;
@property (nonatomic, strong)UILabel                   *alertLabel;

@end

@implementation XDTools
+ (instancetype)shareXTools {
    static dispatch_once_t onceToken;
    static XDTools *tools = nil;
    dispatch_once(&onceToken, ^{
        tools = [[XDTools alloc] init];
    });
    return tools;
}
- (instancetype)init {
    self = [super init];
    [self initDeviceParameters];
    return self;
}

/**
 初始化设备的一些参数
 */
- (void)initDeviceParameters {
    if ([UIScreen mainScreen].bounds.size.width == 414 && [UIScreen mainScreen].bounds.size.height == 896) {
        self.isiPhoneX = YES;
        self.statusBarHeight = 34;
        self.bottomBarHeight = 34;
        return ;
    }
    else if ([UIScreen mainScreen].bounds.size.width == 375 && [UIScreen mainScreen].bounds.size.height == 812){
        self.isiPhoneX = YES;
        self.statusBarHeight = 34;
        self.bottomBarHeight = 34;
        return ;
    }
    else if ([UIScreen mainScreen].bounds.size.width ==896 && [UIScreen mainScreen].bounds.size.height == 414){
        self.isiPhoneX = YES;
        self.statusBarHeight = 34;
        self.bottomBarHeight = 34;
        return ;
    }
    else if ([UIScreen mainScreen].bounds.size.width == 812 && [UIScreen mainScreen].bounds.size.height == 375){
        self.isiPhoneX = YES;
        self.statusBarHeight = 34;
        self.bottomBarHeight = 34;
        return ;
    }
    else
    {
        self.isiPhoneX = NO;
        self.statusBarHeight = 20;
        self.bottomBarHeight = 0;
        return ;
    }
    
}
#pragma mark - 时间
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc]init];
        [_dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        [_dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        [_dateFormatter setLocale:[NSLocale autoupdatingCurrentLocale]];
    }
    else
        if (![_dateFormatter.dateFormat isEqualToString:@"YYYY-MM-dd HH:mm:ss"]) {
            [_dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        }
    return _dateFormatter;
}
- (NSString *)dateStr {
    
    if (![self.dateFormatter.dateFormat isEqualToString:@"YYYYMMDDHHmmss"]) {
        [self.dateFormatter setDateFormat:@"YYYYMMDDHHmmss"];
    }
    
    NSDate *date = [NSDate date];
    _dateStr = [self.dateFormatter stringFromDate:date];
    return _dateStr;
}
- (NSString *)timeStr {
    
    if (![self.dateFormatter.dateFormat isEqualToString:@"HHmmss"]) {
        [self.dateFormatter setDateFormat:@"HHmmss"];
    }
    NSDate *date = [NSDate date];
    _timeStr = [self.dateFormatter stringFromDate:date];
    return _timeStr;
}
- (NSString *)latelyTimeStrFromDate:(NSDate *)date {
    NSTimeInterval timeInter2 = [[NSDate date] timeIntervalSinceDate:date];
    if (timeInter2<60*60) {
        return @"刚刚";
    }
    else
        if (timeInter2<=24*60*60) {
            return [NSString stringWithFormat:@"%.f小时前",timeInter2/(60.0*60.0)];
        }
        else
        {
            if (![self.dateFormatter.dateFormat isEqualToString: @"MM-dd HH:mm"]) {
                [self.dateFormatter setDateFormat:@"MM-dd HH:mm"];
            }
            return [self.dateFormatter stringFromDate:date];
        }
}
- (NSString *)timeStrFromDate:(NSDate *)date withFormat:(NSString *)formatter {
    if (![self.dateFormatter.dateFormat isEqualToString: formatter]) {
        [self.dateFormatter setDateFormat:formatter];
    }
    return [self.dateFormatter stringFromDate:date];
}
- (double)timeStrToSecWithStr:(NSString *)str {
    double timeSec = 0;
    NSArray *array = [str componentsSeparatedByString:@":"];
    for (NSInteger i = 0; i<array.count; i++) {
        NSString *time = [array objectAtIndex:i];
        
        timeSec = timeSec *60 + labs([time integerValue]);
    }
    
    return timeSec;
}
- (NSString *)timeSecToStrWithSec:(double)sec {
    if (sec/3600>0) {
        return [NSString stringWithFormat:@"%d:%02d:%02d",((int)sec)/3600,(((int)sec)%3600)/60,((int)sec)%60];
    }
    return [NSString stringWithFormat:@"%02d:%02d",(((int)sec)%3600)/60,((int)sec)%60];
}
#pragma mark - 提示
- (UIActivityIndicatorView *)activityView {
    if (!_activityView) {
        UIView *asuperView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        asuperView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75];
        asuperView.center =CGPointMake([UIApplication sharedApplication].keyWindow.center.x, [UIApplication sharedApplication].keyWindow.center.y-40);
        asuperView.layer.cornerRadius = 10;
        asuperView.layer.masksToBounds = YES;
        
        _activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.frame = CGRectMake(10, 0, 80, 80);
        _activityView.color = [UIColor whiteColor];
        _activityView.hidesWhenStopped = YES;
        [asuperView addSubview:_activityView];
        [asuperView addSubview:self.activityLabel];
        
        [[UIApplication sharedApplication].keyWindow addSubview:asuperView];
        
    }
    return _activityView;
}
- (UILabel *)activityLabel {
    if (!_activityLabel) {
        _activityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, 100, 20)];
        _activityLabel.textAlignment = NSTextAlignmentCenter;
        _activityLabel.font = [UIFont systemFontOfSize:14];
        _activityLabel.textColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _activityLabel;
}
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc]init];
        _alertLabel.bounds = CGRectMake(0, 0, 100, 40);
        _alertLabel.textAlignment = NSTextAlignmentCenter;
        _alertLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.75];
        _alertLabel.textColor = [UIColor whiteColor];
        _alertLabel.layer.cornerRadius = 10;
        _alertLabel.layer.masksToBounds = YES;
        _alertLabel.hidden = YES;
        _alertLabel.center = [UIApplication sharedApplication].keyWindow.center;
        [[UIApplication sharedApplication].keyWindow addSubview:_alertLabel];
    }
    return _alertLabel;
}

- (void)showMessage:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideMessage) object:nil];
        self.alertLabel.bounds = CGRectMake(0, 0, 16*title.length+30, 40);
        self.alertLabel.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, CGRectGetHeight([UIScreen mainScreen].bounds)/2);
        self.alertLabel.hidden = NO;
        self.alertLabel.text = title;
        [self performSelector:@selector(hideMessage) withObject:nil afterDelay:title.length * 0.2];
    });
}
- (void)hideMessage {
    [UIView animateWithDuration:0.2 animations:^{
        self.alertLabel.alpha = 0;
    } completion:^(BOOL finished) {
        self.alertLabel.hidden = YES;
        self.alertLabel.alpha = 1;
    }];
}
- (void)showLoading:(NSString *)title {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activityView.superview.hidden = NO;
        self.activityLabel.text = title;
        [self.activityView startAnimating];
    });
}
- (void)hideLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.activityView.superview.hidden = YES;
        [self.activityView stopAnimating];
    });
}
- (void)showAlertTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles completionHandler:(void (^)(NSInteger num))completionHandler {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSInteger i= 0; i<buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            completionHandler(i);
        }];
        [alert addAction:action];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:^{
        
    }];
}
#pragma mark - 文件计算
//获取单个文件的大小
- (long long) fileSizeAtPath:(NSString*) filePath {
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}
- (float )folderSizeAtPath:(NSString*) folderPath {
    if (![kFileM fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[kFileM subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}
//获取手机存储空间信息
- (float)allStorageSpace {
    NSDictionary *att = [kFileM attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    float total = [[att objectForKey:NSFileSystemSize] floatValue];
    return total;
}
- (float)freeStorageSpace {
    NSDictionary *att = [kFileM attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    float total = [[att objectForKey:NSFileSystemFreeSize] floatValue];
    return total;
}
- (NSString *)storageSpaceStringWith:(float)space {
    float sizeKb = space/1000;
    float sizeMb = sizeKb/1000;
    float sizeGb = sizeMb/1000;
    if (sizeGb > 1) {
        return [NSString stringWithFormat:@"%.2fG",sizeGb];
    }
    else if (sizeMb > 1) {
        return [NSString stringWithFormat:@"%.2fM",sizeMb];
    }
    else{
        return [NSString stringWithFormat:@"%.2fKB",sizeKb];
    }
}
#pragma mark -- 加密md5
- (NSString *)md5Fromstr:(NSString *)str {
    if (str) {
        const char *cStr = [str UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        //把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了digest这个空间中
        CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];//x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
        return output;
    }
    return nil;
}
#pragma mark -- 设备
- (NSString *)currentDeviceModel {
    int mib[2];
    size_t len;
    char *machine;
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    // iPhone
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"国行、日版、港行iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"港行、国行iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"美版、台版iPhone 7";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"美版、台版iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"])   return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])   return @"美版(Global/A1905)iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])   return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,5"])   return @"美版(Global/A1897)iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"])   return @"国行(A1865)、日行(A1902)iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])   return @"美版(Global/A1901)iPhone X";
    if ([platform isEqualToString:@"iPhone11,2"])   return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,6"])   return @"iPhone XS Max";
    if ([platform isEqualToString:@"iPhone11,8"])   return @"iPhone XR";
    //iPod Touch
    if ([platform isEqualToString:@"iPod1,1"]) return @"iPodTouch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iPodTouch5G";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iPodTouch6G";
    //iPad
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad2";
    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad3";
    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad3";
    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad3";
    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad4";
    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad4";
    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad4";
    //iPad Air
    if ([platform isEqualToString:@"iPad4,1"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,2"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad4,3"]) return @"iPadAir";
    if ([platform isEqualToString:@"iPad5,3"]) return @"iPadAir2";
    if ([platform isEqualToString:@"iPad5,4"]) return @"iPadAir2";
    //iPad mini
    if ([platform isEqualToString:@"iPad2,5"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,6"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad2,7"]) return @"iPadmini1G";
    if ([platform isEqualToString:@"iPad4,4"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,5"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,6"]) return @"iPadmini2";
    if ([platform isEqualToString:@"iPad4,7"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,8"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad4,9"]) return @"iPadmini3";
    if ([platform isEqualToString:@"iPad5,1"]) return @"iPadmini4";
    if ([platform isEqualToString:@"iPad5,2"]) return @"iPadmini4";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPadPro 9.7";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPadPro 9.7";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPadPro 12.9";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPadPro 12.9";
    if ([platform isEqualToString:@"iPad6,11"])    return @"iPad 5 (WiFi)";
    if ([platform isEqualToString:@"iPad6,12"])    return @"iPad 5 (Cellular)";
    if ([platform isEqualToString:@"iPad7,1"])     return @"iPadPro 12.9 inch 2nd gen (WiFi)";
    if ([platform isEqualToString:@"iPad7,2"])     return @"iPadPro 12.9 inch 2nd gen (Cellular)";
    if ([platform isEqualToString:@"iPad7,3"])     return @"iPadPro 10.5 inch (WiFi)";
    if ([platform isEqualToString:@"iPad7,4"])     return @"iPadPro 10.5 inch (Cellular)";
    if ([platform isEqualToString:@"i386"]) return @"iPhoneSimulator";
    if ([platform isEqualToString:@"x86_64"]) return @"iPhoneSimulator";
    return platform;
}

@end
