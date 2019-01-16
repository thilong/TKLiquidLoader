//
//  SimpleCircleLiquidEngine.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiquittableCircle;
@interface SimpleCircleLiquidEngine : NSObject


@property(nonatomic,assign) CGFloat radiusThresh;
@property(nonatomic,strong) UIColor *color;
@property(nonatomic,assign) CGFloat connectThresh;
@property(nonatomic,assign) CGFloat angleThresh;

-(instancetype)initWithRadiusThresh:(CGFloat)radiusThresh angleThresh:(CGFloat)angleThresh;

-(NSArray<LiquittableCircle *>*)push:(LiquittableCircle*)circle other:(LiquittableCircle*)other;

-(void)draw:(UIView *)parent;
-(void)clear;
-(CALayer*)constructLayer:(UIBezierPath*)path;

@end
