//
//  LiquidLoader.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "LiquidLoader.h"
#import "SimpleCircleLiquidEngine.h"
#import "LiquittableCircle.h"
#import "LiquidLoadEffects.h"

@interface LiquidLoader()
@property(nonatomic,strong) LiquidLoadEffect* effectDelegate;
@end

@implementation LiquidLoader

-(instancetype)initWithFrame:(CGRect)frame
                      effect:(LiquidLoadEffectType)effect
                       color:(UIColor *)color
                 circleCount:(NSInteger)circleCount
                    duration:(CGFloat)duration
                   growColor:(UIColor *)growColor{
    self = [super initWithFrame:frame];
    self.effectDelegate = [LiquidLoadEffect loadEffectWithEffectType:effect loader:self color:color circleCount:circleCount duration:duration growColor:growColor];
    return self;
}
-(void)show{
    self.hidden = false;
}
-(void)hide{
    self.hidden = true;
}

-(void)didMoveToWindow{
    [super didMoveToWindow];
    if(self.window == nil){
        [self.effectDelegate stopTimer];
    }
}

@end


