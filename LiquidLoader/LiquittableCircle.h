//
//  LiquittableCircle.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiquittableCircle : UIView

@property(nonatomic,strong) NSMutableArray* points;
@property(nonatomic,assign) BOOL isGrow;
@property(nonatomic,assign) CGFloat radius;
@property(nonatomic,strong) UIColor *color;
@property(nonatomic,strong) UIColor *growColor;


-(instancetype)initWithCenter:(CGPoint)center
                       radius:(CGFloat)radius
                        color:(UIColor*)color
                    growColor:(UIColor *)growColor;

-(void)move:(CGPoint)dt;

-(void)grow:(BOOL)grow;
-(CGPoint)circlePoint:(CGFloat)rad;

@end
