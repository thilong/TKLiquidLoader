//
//  CGPoint+LiquidLoading.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

CGPoint CGPointPlus(CGPoint,CGPoint);

CGPoint CGPointMul(CGPoint,CGFloat);

CGPoint CGPointNormalized(CGPoint);

CGFloat CGPointDot(CGPoint, CGPoint);

CGPoint CGPointMinus(CGPoint,CGPoint);

CGPoint CGPointMid(CGPoint,CGPoint);

CGPoint CGPointDiv(CGPoint,CGFloat);

CGFloat CGPointLength(CGPoint);

CGPoint CGPointSplit(CGPoint,CGPoint,CGFloat);


CGFloat CGPointCross(CGPoint,CGPoint);

/* NSValue<CGPoint> */
NSValue* CGPointIntersection(CGPoint from, CGPoint to, CGPoint from2, CGPoint to2);
