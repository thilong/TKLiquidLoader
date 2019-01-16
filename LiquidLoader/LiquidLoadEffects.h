//
//  LiquidEffects.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    LiquidLoadEffectTypeLine,
    LiquidLoadEffectTypeCircle,
    LiquidLoadEffectTypeGrowLine,
    LiquidLoadEffectTypeGrowCircle
} LiquidLoadEffectType;

@class LiquidLoader;

@interface LiquidLoadEffect : NSObject
+(instancetype)loadEffectWithEffectType:(LiquidLoadEffectType)effectType
                                 loader:(LiquidLoader *)loader
                                  color:(UIColor *)color
                            circleCount:(NSInteger)circleCount
                               duration:(CGFloat)duration
                              growColor:(UIColor *)growColor;
-(void)stopTimer;
@end

@interface LiquidLoadLineEffect : LiquidLoadEffect
@end

@interface LiquidLoadCircleEffect : LiquidLoadEffect
@end
