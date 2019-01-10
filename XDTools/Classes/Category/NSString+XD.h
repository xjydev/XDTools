//
//  NSString+XD.h
//  Pods-XDTools_Example
//
//  Created by XiaoDev on 2018/12/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (XD)

//汉字转换为拼音
- (NSString *)ora_pinyinOfName;

//汉字转换为拼音后，返回大写的首字母
- (NSString *)ora_firstCharacterOfName;

// 是否包含中文字符
- (BOOL)ora_containChinese;
/**
 *  @brief  转换成MD5字符串
 *
 *  @return MD5字符串
 */
- (NSString *)ora_MD5;

/**
 是否为空字符串

 @return YES/NO
 */
- (BOOL)ora_isBlankString;

/**
 获取要显示该文本的所需要的size

 @param size 限定大小，即返回的size不会超过这个所限定的大小
 @param font 字体
 @return 要显示文本所需size
 */
- (CGSize)ora_sizeWithLimitSize:(CGSize)size font:(UIFont *)font;
/**
 *  @brief  获取要显示文本的所需的高度
 *
 *  @param width 限定的宽度
 *  @param font  字体
 *
 *  @return 文本所需高度
 */
- (CGFloat)ora_heightWithWidth:(CGFloat)width font:(UIFont *)font;
/**
 *  获取string的utf8编码的nsdata
 *
 *  @return data
 */
- (NSData *)ora_UTF8Data;
@end

NS_ASSUME_NONNULL_END
