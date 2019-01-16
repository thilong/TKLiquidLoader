//
//  LiquittableCircle.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "LiquittableCircle.h"
#import "UIView+Grow.h"
#import "LiquidUtil.h"

@implementation LiquittableCircle

-(void)setIsGrow:(BOOL)isGrow{
    _isGrow = isGrow;
    [self grow:_isGrow];
}

-(void)setRadius:(CGFloat)radius{
    _radius = radius;
    [self setup];
}

-(instancetype)initWithCenter:(CGPoint)center
                       radius:(CGFloat)radius
                        color:(UIColor*)color
                    growColor:(UIColor *)growColor{
    CGRect frame = CGRectMake(center.x - radius, center.y - radius, 2 * radius, 2 * radius);
    self = [super initWithFrame:frame];
    _radius = radius;
    _color = color;
    if(growColor)
        _growColor = growColor;
    [self setup];
    return self;
}

-(void)setup{
    self.frame =  CGRectMake(self.center.x - _radius, self.center.y - _radius, 2 * _radius, 2 * _radius);
    UIBezierPath *path = [UIBezierPath  bezierPathWithOvalInRect:self.bounds];
    [self drawPath:path];
}

-(void)move:(CGPoint)dt{
    self.center = CGPointMake(self.center.x + dt.x, self.center.y + dt.y);
}

-(void)drawPath:(UIBezierPath*)path{
    for( CALayer *sub in self.layer.sublayers){
        [sub removeFromSuperlayer];
    }
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] initWithLayer:self.layer];
    shapeLayer.lineWidth = 3.0;
    shapeLayer.fillColor = self.color.CGColor;
    shapeLayer.path = path.CGPath;
    [self.layer addSublayer:shapeLayer];
    if(_isGrow)
        [self grow:true];
}

-(void)grow:(BOOL)grow{
    if(_isGrow){
        [self growBaseColor:self.growColor radius:self.radius shininess:1.6];
    }else{
        self.layer.shadowRadius = 0;
        self.layer.shadowOpacity = 0;
    }
}

-(CGPoint)circlePoint:(CGFloat)rad{
    return [CGMath circlePointWithCenter:self.center radius:self.radius rad:rad];
}

@end
