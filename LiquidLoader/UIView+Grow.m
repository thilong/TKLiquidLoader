//
//  UIView+Grow.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "UIView+Grow.h"
#import "LiquidUtil.h"
#import "CGPoint+LiquidLoading.h"

@interface CircularGradientLayer : CALayer
@property(nonatomic,strong) NSArray<UIColor *> *colors;
@end


@implementation CircularGradientLayer

-(instancetype)initWithColors:(NSArray*)colors{
    self = [super init];
    self.colors = colors;
    return self;
}

-(void)drawInContext:(CGContextRef)ctx{
    NSArray *locs = [CGMath linSpace:0 to:1 number:[_colors count]];
    if([_colors count] == 0 || [locs count] == 0) return;
    NSInteger locsCount = [locs count];
    CGFloat* locaitons = malloc(sizeof(CGFloat) * locsCount);
    for(int idx = 0; idx < locsCount ; idx++){
        NSNumber *loc = locs[idx];
        CGFloat value = [loc floatValue];
        value = 1.0 - value * value;
        locaitons[locsCount - idx - 1] = value;
    }
    CFMutableArrayRef colorArray = CFArrayCreateMutable(kCFAllocatorDefault, 0, &kCFTypeArrayCallBacks);
    for(UIColor *co in _colors){
        CFArrayAppendValue(colorArray, co.CGColor);
    }
    CGGradientRef gradients = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), colorArray, locaitons);
    CGRect frame = self.frame;
    CGPoint center = CGPointMake(frame.origin.x +  frame.size.width / 2, frame.origin.y + frame.size.height /2);
    CGContextDrawRadialGradient(ctx, gradients, center, 0, center, MAX(frame.size.width, frame.size.height),10);
    CFRelease(colorArray);
    CFRelease(gradients);
    free(locaitons);
    
}

@end


@implementation UIView (Grow)


-(void)growBaseColor:(UIColor *)baseColor radius:(CGFloat)radius shininess:(CGFloat)shininess{
    NSArray *layers = self.layer.sublayers;
    if(layers == nil) return;
    for(id sub in layers){
        if(![sub isKindOfClass:CAShapeLayer.class]) return;
    }
    UIColor *growColor = baseColor;
    [self growShadowRadius:radius growColor:growColor shininess:shininess];
    
    CAShapeLayer *circle = CAShapeLayer.new;
    circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, radius * 2, radius * 2)].CGPath;
    CircularGradientLayer *circleGradient = [[CircularGradientLayer alloc] initWithColors:@[growColor, [UIColor colorWithWhite:1 alpha:0]]];
    circleGradient.frame = CGRectMake(0, 0, radius * 2, radius * 2);
    circleGradient.opacity = 0.25;
    for( CAShapeLayer * sub in layers){
        sub.fillColor = UIColor.clearColor.CGColor;
    }
    circleGradient.mask = circle;
    [self.layer addSublayer:circleGradient];
}


-(void)growShadowRadius:(CGFloat)radius growColor:(UIColor *)growColor shininess:(CGFloat)shininess{
    CGPoint origin = self.center;
    origin = CGPointMinus(origin, self.frame.origin);
    origin = CGPointMinus(origin, CGPointMake(radius * shininess, radius * shininess));
    
    CGRect ovalRect;
    ovalRect.origin = origin;
    ovalRect.size = CGSizeMake(2 * radius * shininess, 2 * radius * shininess);
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithOvalInRect:ovalRect];
    self.layer.shadowColor = growColor.CGColor;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = shadowPath.CGPath;
    self.layer.shadowOpacity = 1.0;
    self.layer.shouldRasterize = true;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.masksToBounds = false;
    self.clipsToBounds = false;
    
}


@end


