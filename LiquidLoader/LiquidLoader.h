//
//  LiquidLoader.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiquidLoadEffects.h"

@interface LiquidLoader : UIView

-(instancetype)initWithFrame:(CGRect)frame
                      effect:(LiquidLoadEffectType)effect
                       color:(UIColor *)color
                 circleCount:(NSInteger)circleCount
                    duration:(CGFloat)duration
                   growColor:(UIColor *)growColor;
-(void)show;
-(void)hide;
@end
