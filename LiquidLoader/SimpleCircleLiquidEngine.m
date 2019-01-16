//
//  SimpleCircleLiquidEngine.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "SimpleCircleLiquidEngine.h"
#import "LiquittableCircle.h"
#import "CGPoint+LiquidLoading.h"
#import "LiquidUtil.h"

@interface SimpleCircleLiquidEngine()

@property(nonatomic,strong) CALayer *layer;

@end

@implementation SimpleCircleLiquidEngine

-(CALayer *)layer{
    if(_layer == nil){
        _layer = CAShapeLayer.new;
    }
    return _layer;
}

-(instancetype)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh{
    self = [super init];
    self.radiusThresh = radiusThresh;
    self.angleThresh = angleThresh;
    self.connectThresh = 0.3;
    return self;
}

-(NSArray<LiquittableCircle *>*)push:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    NSArray<UIBezierPath *> *paths = [self generateConnectedPath:circle other:other];
    if(paths == nil){
        return NSArray.array;
    }
    NSMutableArray *layer = NSMutableArray.array;
    for(UIBezierPath * path in paths){
        CALayer *consLayer = [self constructLayer:path];
        [layer addObject:consLayer];
        [self.layer addSublayer:consLayer];
    }
    return @[circle, other];
}

-(void)draw:(UIView *)parent{
    [parent.layer addSublayer:self.layer];
}
-(void)clear{
    [_layer removeFromSuperlayer];
    NSArray *layers = [[_layer sublayers] copy];
    for(CALayer *sub in layers){
        [sub removeFromSuperlayer];
    }
    _layer = CAShapeLayer.new;
}

-(CALayer*)constructLayer:(UIBezierPath*)path{
    CGRect pathBounds = CGPathGetBoundingBox(path.CGPath);
    CAShapeLayer *shape = CAShapeLayer.new;
    shape.fillColor = self.color.CGColor;
    shape.path = path.CGPath;
    shape.frame = CGRectMake(0, 0, pathBounds.size.width, pathBounds.size.height);
    return shape;
}


#pragma mark - private

/*return NSValue<CGPoint> array */
-(NSArray *)circleConnectedPoint:(LiquittableCircle*)circle other:(LiquittableCircle*)other angle:(CGFloat)angle{
    CGPoint vec = CGPointMinus(other.center, circle.center);
    CGFloat radian = atan2(vec.y, vec.x);
    CGPoint p1 = [circle circlePoint: (radian + angle)];
    CGPoint p2 = [circle circlePoint:(radian - angle)];
    return @[ [NSValue valueWithCGPoint:p1], [NSValue valueWithCGPoint:p2]];
}


-(NSArray *)circleConnectedPoint:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    CGFloat ratio = [self circleRatio:circle other:other];
    ratio = (ratio + self.connectThresh) / (1.0 + self.connectThresh);
    CGFloat angle = (3.14159265 / 2) * ratio;
    return [self circleConnectedPoint:circle other:other angle:angle];
}

-(NSArray<UIBezierPath *> *)generateConnectedPath:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    if(![self isConnected:circle other:other])
        return nil;
    CGFloat ratio = [self circleRatio:circle other:other];
    if(ratio <= 1 && ratio >= self.angleThresh){
        UIBezierPath *path = [self normalPath:circle other:other];
        if(path)
            return @[ path ];
        return nil;
    }
    else if (ratio >= 0 && ratio < self.angleThresh){
        return [self splitPath:circle other:other ratio:ratio];
    }
    return nil;
}

-(UIBezierPath *)normalPath:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    NSArray *p12 = [self circleConnectedPoint:circle other:other];
    NSArray *p34 = [self circleConnectedPoint:other other:circle];
    CGPoint p1 = [(NSValue *)p12[0] CGPointValue];
    CGPoint p2 = [(NSValue *)p12[1] CGPointValue];
    CGPoint p3 = [(NSValue *)p34[0] CGPointValue];
    CGPoint p4 = [(NSValue *)p34[1] CGPointValue];
    
    NSValue *crossedValue = CGPointIntersection(p1, p3, p2, p4);
    if(crossedValue == nil) return nil;
    UIBezierPath *path = UIBezierPath.new;
    /*begin*/
    CGFloat ration = [self circleRatio:circle other:other];
    [path moveToPoint:p1];
    CGPoint mul = CGPointPlus(p1, p4);
    mul = CGPointDiv(mul, 2);
    mul = CGPointSplit(mul, [crossedValue CGPointValue], ration * 1.25 - 0.25);
    [path addQuadCurveToPoint:p4 controlPoint:mul];
    [path addLineToPoint:p3];
    
    CGPoint mul2 = CGPointPlus(p2, p3);
    mul2 = CGPointDiv(mul2, 2);
    mul2 = CGPointSplit(mul2, [crossedValue CGPointValue], ration * 1.25 - 0.25);
    [path addQuadCurveToPoint:p2 controlPoint:mul2];
    /*end*/
    [path closePath];
    return path;
}

-(NSArray<UIBezierPath *> *)splitPath:(LiquittableCircle*)circle other:(LiquittableCircle*)other ratio:(CGFloat)ratio{
    NSArray *p12 = [self circleConnectedPoint:circle other:other angle:[CGMath degToRad:40]];
    NSArray *p34 = [self circleConnectedPoint:other other:circle angle:[CGMath degToRad:40]];
    CGPoint p1 = [(NSValue *)p12[0] CGPointValue];
    CGPoint p2 = [(NSValue *)p12[1] CGPointValue];
    CGPoint p3 = [(NSValue *)p34[0] CGPointValue];
    CGPoint p4 = [(NSValue *)p34[1] CGPointValue];
    
    NSValue *crossedValue = CGPointIntersection(p1, p3, p2, p4);
    if(crossedValue == nil) return NSArray.array;
    
    NSArray* d1_ =  [self circleConnectedPoint:circle other:other angle:0];
    NSArray* d2_ =  [self circleConnectedPoint:other other:circle angle:0];
    CGPoint d1 = [(NSValue *)d1_[0] CGPointValue];
    CGPoint d2 = [(NSValue *)d2_[0] CGPointValue];
    CGPoint crossed = [crossedValue CGPointValue];
    CGFloat r = (ratio - self.connectThresh) / (self.angleThresh - self.connectThresh);
    
    CGPoint a1 = CGPointSplit(d1, CGPointMid(crossed, d2), 1 - r);
    
    UIBezierPath *part = UIBezierPath.new;
    [part moveToPoint:p1];
    [part addQuadCurveToPoint:p2 controlPoint:a1];
    [part closePath];
    
    CGPoint a2 = CGPointSplit(d2, CGPointMid(crossed, d1), 1 - r);
    UIBezierPath *part2 = UIBezierPath.new;
    [part2 moveToPoint:p3];
    [part2 addQuadCurveToPoint:p4 controlPoint:a2];
    [part2 closePath];
    
    return @[part , part2];
}

-(CGFloat)circleRatio:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    CGFloat distance = CGPointLength(CGPointMinus(other.center, circle.center));
    CGFloat ratio = 1.0 - (distance - self.radiusThresh) / (circle.radius + other.radius + self.radiusThresh);
    return MIN(MAX(ratio, 0), 1);
}

-(BOOL)isConnected:(LiquittableCircle*)circle other:(LiquittableCircle*)other{
    CGFloat distance = CGPointLength(CGPointMinus(circle.center, other.center));
    return (distance - circle.radius - other.radius ) < self.radiusThresh;
}

@end
