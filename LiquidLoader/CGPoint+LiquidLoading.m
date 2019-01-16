//
//  CGPoint+LiquidLoading.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "CGPoint+LiquidLoading.h"

CGPoint CGPointPlus(CGPoint selfPoint,CGPoint point){
    return CGPointMake(selfPoint.x + point.x, selfPoint.y + point.y);
}


CGPoint CGPointMul(CGPoint selfPoint,CGFloat rhs){
    return CGPointMake(selfPoint.x * rhs, selfPoint.y * rhs);
}

CGPoint CGPointNormalized(CGPoint selfPoint){
    return CGPointDiv(selfPoint, CGPointLength(selfPoint));
}

CGFloat CGPointDot(CGPoint selfPoint, CGPoint point){
    return selfPoint.x * point.x + selfPoint.y * point.y;
}

CGPoint CGPointMinus(CGPoint selfPoint,CGPoint point){
    CGPoint ret ;
    ret.x = selfPoint.x - point.x;
    ret.y = selfPoint.y - point.y;
    return ret;
}

CGPoint CGPointMid(CGPoint selfPoint,CGPoint point){
    return CGPointSplit(selfPoint, point, 0.5);
}

CGPoint CGPointDiv(CGPoint selfPoint,CGFloat rhs){
    return CGPointMake(selfPoint.x / rhs, selfPoint.y / rhs);
}

CGFloat CGPointLength(CGPoint point){
    return sqrt(point.x * point.x + point.y * point.y);
}

CGPoint CGPointSplit(CGPoint selfPoint,CGPoint point,CGFloat ration){
    CGPoint ret = CGPointMul(selfPoint, ration);
    CGPoint p2 = CGPointMul(point, 1.0 - ration);
    ret = CGPointPlus(ret, p2);
    return ret;
}

CGFloat CGPointCross(CGPoint selfPoint ,CGPoint point){
    return selfPoint.x * point.y - selfPoint.y * point.x;
}

NSValue* CGPointIntersection(CGPoint from, CGPoint to, CGPoint from2, CGPoint to2){
    CGPoint ac = CGPointMake(to.x - from.x, to.y - from.y);
    CGPoint bd = CGPointMake(to2.x - from2.x, to2.y - from2.y);
    CGPoint ab = CGPointMake(from2.x - from.x, from2.y - from.y);
    CGPoint bc = CGPointMake(to.x - from2.x, to.y - from2.y);
    
    CGFloat area = CGPointCross(bd, ab);
    CGFloat area2 = CGPointCross(bd, bc);
    
    if(area+area2 >= 0.1 || (area + area2) < -0.1){
        CGFloat ratio = area / (area + area2);
        return [NSValue valueWithCGPoint:CGPointMake(from.x + ratio * ac.x, from.y + ratio *ac.y)];
    }
    return nil;
}
