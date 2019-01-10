//
//  UIView+Border.m
//  JSONModel
//
//  Created by XiaoDev on 2019/1/2.
//

#import "UIView+Border.h"

@implementation UIView (Border)
- (void)setBoarderWithType:(XDViewBoarderType)type boarderColor:(UIColor *)color boarderWidth:(CGFloat)width {
    CALayer *layer = [CALayer layer];
    switch (type) {
        case XDViewBoarderTypeTop:
            {
               layer.frame = CGRectMake(0, 0, self.frame.size.width, width);
            }
            break;
        case XDViewBoarderTypeRight:
        {
           layer.frame = CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height);
        }
            break;
        case XDViewBoarderTypeBottom:
        {
            layer.frame = CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width);
        }
            break;
        case XDViewBoarderTypeleft:
        {
           layer.frame = CGRectMake(0, 0, width, self.frame.size.height);
        }
            break;
            
            
        default:
            break;
    }
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
}
@end
