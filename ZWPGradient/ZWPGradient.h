#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ZWPGradientDrawingOptions) {
    ZWPGradientDrawsBeforeStartingLocation = kCGGradientDrawsBeforeStartLocation,
    ZWPGradientDrawsAfterEndingLocation = kCGGradientDrawsAfterEndLocation,
};

@interface ZWPGradient : NSObject

#pragma mark - Initialization

- (instancetype)initWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor;
- (instancetype)initWithColors:(NSArray *)colors;
- (instancetype)initWithColors:(NSArray *)colors locations:(NSArray *)locations;

#pragma mark - Primitive Drawing

- (void)drawFromPoint:(CGPoint)startPoint
              toPoint:(CGPoint)endPoint
              options:(ZWPGradientDrawingOptions)options;
- (void)drawFromCenter:(CGPoint)startCenter
                radius:(CGFloat)startRadius
              toCenter:(CGPoint)endCenter
                radius:(CGFloat)endRadius
               options:(ZWPGradientDrawingOptions)options;

#pragma mark - Properties

- (NSInteger)numberOfColorStops;
- (void)getColor:(__autoreleasing UIColor **)color location:(CGFloat *)location atIndex:(NSInteger)index;

@end
