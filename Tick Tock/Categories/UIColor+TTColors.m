#import "UIColor+TTColors.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIColor (TTColors)

+ (UIColor *)TTDarkGreyColor {
    return UIColorFromRGB(0x212B35);
}

+ (UIColor *)TTGreyColor {
    return UIColorFromRGB(0x2A3643);
}

+ (UIColor *)TTLightGreyColor {
    return UIColorFromRGB(0xA1B3C3);
}

+ (UIColor *)TTPinkColor {
    return UIColorFromRGB(0xFD6965);
}

@end
