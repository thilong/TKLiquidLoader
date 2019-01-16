//
//  LiquidUtil.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "LiquidUtil.h"

@implementation LiquidUtil

+(UIBezierPath*)withBezier:(void(^)(UIBezierPath*))f{
    UIBezierPath *bezierPath = UIBezierPath.new;
    f(bezierPath);
    [bezierPath closePath];
    return bezierPath;
}

+(void)withStroke:(void(^)(void))f bezierPath:(UIBezierPath*)bezierPath color:(UIColor *)color{
    [color setStroke];
    f();
    [bezierPath stroke];
}

+(void)withFill:(void(^)(void))f bezierPath:(UIBezierPath*)bezierPath color:(UIColor *)color{
    [color setFill];
    f();
    [bezierPath fill];
}


@end

@implementation CGMath

+(CGFloat)radToDeg:(CGFloat)rad{
    return rad * 180.0 / 3.14159265358979;
}
+(CGFloat)degToRad:(CGFloat)deg{
    return deg * 3.14159265358979 / 180.0;
}
+(CGPoint)circlePointWithCenter:(CGPoint)center radius:(CGFloat)radius rad:(CGFloat)rad{
    CGFloat x = center.x + radius * cos(rad);
    CGFloat y = center.y + radius * sin(rad);
    return CGPointMake(x, y);
}

+(NSArray<NSNumber *>*)linSpace:(CGFloat)from to:(CGFloat)to number:(NSInteger)number{
    NSMutableArray *array = NSMutableArray.array;
    for(int idx =0; idx < number ; idx ++){
        [array addObject:@((to - from) * idx / (number - 1) + from)];
    }
    return array;
}


@end
