//
//  UIColor+Hex.h
//  Pods-XDTools_Example
//
//  Created by XiaoDev on 2018/11/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Hex)
//根据16进制颜色值和alpha值生成UIColor
+ (UIColor *)ora_colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;

//根据16进制颜色值和alpha为1生成UIColor
+ (UIColor *)ora_colorWithHex:(UInt32)hex;

//根据16进制颜色字符串生成UIColor
// hexString 支持格式为 OxAARRGGBB / 0xRRGGBB / #AARRGGBB / #RRGGBB / AARRGGBB / RRGGBB
+ (UIColor *)ora_colorWithHexString:(NSString *)hexString;
+ (UIColor *)ora_colorWithHexString:(NSString *)hexString andAlpha:(CGFloat)alpha;

//返回当前对象的16进制颜色值
- (UInt32)ora_hexValue;

@end

NS_ASSUME_NONNULL_END
