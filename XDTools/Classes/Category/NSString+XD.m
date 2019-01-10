//
//  NSString+XD.m
//  Pods-XDTools_Example
//
//  Created by XiaoDev on 2018/12/4.
//
#import <CommonCrypto/CommonDigest.h>
#import "NSString+XD.h"

@implementation NSString (XD)
- (NSString *)ora_pinyinOfName {
    NSMutableString *name = [[NSMutableString alloc] initWithString:self];
    CFRange range = CFRangeMake(0, 1);
    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef)name, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)name, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    return name;
}
- (NSString *)ora_firstCharacterOfName {
    NSMutableString *first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    
    CFRange range = CFRangeMake(0, 1);
    
    // 汉字转换为拼音,并去除音调
    if (!CFStringTransform((__bridge CFMutableStringRef)first, &range, kCFStringTransformMandarinLatin, NO) ||
        !CFStringTransform((__bridge CFMutableStringRef)first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    
    NSString *result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    
    return result.uppercaseString;
}
- (BOOL)ora_containChinese {
    NSUInteger length = self.length;
    if (0 == length) {
        return NO;
    }
    for (int i = 0; i < length; i++) {
        const char *cstring = [[self substringWithRange:NSMakeRange(i, 1)] UTF8String];
        if (3 == strlen(cstring)) {
            return YES;
        }
    }
    return NO;
}
- (NSString *)ora_MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0],
            result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14],
            result[15]];
}
- (BOOL)ora_isBlankString {
    if (self == nil) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if (self == NULL) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[self ora_trim] length] == 0) {
        return YES;
    }
    
    return NO;
}
- (NSString *)ora_trim {
    NSString *result = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return result;
}

- (CGSize)ora_sizeWithLimitSize:(CGSize)size font:(UIFont *)font {
    if ([self length] == 0) {
        return CGSizeZero;
    }
    CGRect rect = [self boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{
                                               NSFontAttributeName : font
                                               }
                                     context:nil];
    return rect.size;
}

- (CGFloat)ora_heightWithWidth:(CGFloat)width font:(UIFont *)font {
    return [self ora_sizeWithLimitSize:CGSizeMake(width, MAXFLOAT) font:font].height;
}

- (NSData *)ora_UTF8Data {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
