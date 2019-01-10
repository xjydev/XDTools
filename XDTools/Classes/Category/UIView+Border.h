//
//  UIView+Border.h
//  JSONModel
//
//  Created by XiaoDev on 2019/1/2.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XDViewBoarderType) {
    XDViewBoarderTypeTop = 1,//上
    XDViewBoarderTypeRight,//右
    XDViewBoarderTypeBottom,//下
    XDViewBoarderTypeleft,//左
};
NS_ASSUME_NONNULL_BEGIN

@interface UIView (Border)
- (void)setBoarderWithType:(XDViewBoarderType)type boarderColor:(UIColor *)color boarderWidth:(CGFloat)width;
@end

NS_ASSUME_NONNULL_END
