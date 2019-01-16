//
//  LiquidUtil.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiquidUtil : NSObject

+(UIBezierPath*)withBezier:(void(^)(UIBezierPath*))f;

+(void)withStroke:(void(^)(void))f bezierPath:(UIBezierPath*)bezierPath color:(UIColor *)color;

+(void)withFill:(void(^)(void))f bezierPath:(UIBezierPath*)bezierPath color:(UIColor *)color;


@end

@interface CGMath : NSObject

+(CGFloat)radToDeg:(CGFloat)rad;
+(CGFloat)degToRad:(CGFloat)deg;
+(CGPoint)circlePointWithCenter:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad;
+(NSArray<NSNumber *>*)linSpace:(CGFloat)from to:(CGFloat)to number:(NSInteger)number;


@end
