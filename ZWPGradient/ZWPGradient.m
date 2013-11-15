#import "ZWPGradient.h"

@interface ZWPGradient()

@property (nonatomic, strong) NSArray *colors;
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, assign) CGGradientRef gradient;

@end
@implementation ZWPGradient

#pragma mark - Initialization

- (instancetype)initWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor {
    return [self initWithColors:@[startingColor, endingColor]];
}
- (instancetype)initWithColors:(NSArray *)colors {
    NSMutableArray *locations = [NSMutableArray arrayWithCapacity:colors.count];
    CGFloat increment = 1.0 / (CGFloat)([colors count] - 1);
    [colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [locations addObject:@(idx * increment)];
    }];
    return [self initWithColors:colors locations:locations];
}
- (instancetype)initWithColors:(NSArray *)colors locations:(NSArray *)locations {
    if((self = [super init])) {
        _colors = [colors copy];
        CFMutableArrayRef primitiveColors = CFArrayCreateMutable(kCFAllocatorDefault, [colors count], &kCFTypeArrayCallBacks);
        [_colors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            CFArrayAppendValue(primitiveColors, (const void *)[obj CGColor]);
        }];
        
        _locations = [locations copy];
        CGFloat *primitiveLocations = malloc(sizeof(CGFloat) * [locations count]);
        [_locations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            primitiveLocations[idx] = (CGFloat)[obj doubleValue];
        }];
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        _gradient = CGGradientCreateWithColors(colorSpace, primitiveColors, primitiveLocations);
        CGColorSpaceRelease(colorSpace);
        CFRelease(primitiveColors);
        free(primitiveLocations);
    }
    return self;
}

#pragma mark - Primitive Drawing

- (void)drawFromPoint:(CGPoint)startPoint
              toPoint:(CGPoint)endPoint
              options:(ZWPGradientDrawingOptions)options {
    CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(),
                                self.gradient,
                                startPoint,
                                endPoint,
                                options);
}
- (void)drawFromCenter:(CGPoint)startCenter
                radius:(CGFloat)startRadius
              toCenter:(CGPoint)endCenter
                radius:(CGFloat)endRadius
               options:(ZWPGradientDrawingOptions)options {
    CGContextDrawRadialGradient(UIGraphicsGetCurrentContext(),
                                self.gradient,
                                startCenter,
                                startRadius,
                                endCenter,
                                endRadius,
                                options);
}

#pragma mark - Properties

- (NSInteger)numberOfColorStops {
    return [self.colors count];
}
- (void)getColor:(__autoreleasing UIColor **)color location:(CGFloat *)location atIndex:(NSInteger)index {
    UIColor *c = [self.colors objectAtIndex:index];
    NSNumber *l = [self.locations objectAtIndex:index];
    
    if(color) {
        *color = c;
    }
    if(location) {
        *location = l.doubleValue;
    }
}

#pragma mark - Dealloc

- (void)dealloc {
    if(_gradient) {
        CGGradientRelease(_gradient);
        _gradient = nil;
    }
}

@end
