//
//  LiquidEffects.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "LiquidLoadEffects.h"
#import "SimpleCircleLiquidEngine.h"
#import "LiquittableCircle.h"
#import "LiquidLoader.h"
#import "CGPoint+LiquidLoading.h"
#import "LiquidUtil.h"

@interface LiquidLoadEffect()
@property(nonatomic,assign) NSInteger numberOfCircles;
@property(nonatomic,assign) CGFloat duration;
@property(nonatomic,assign) CGFloat circleScale;
@property(nonatomic,assign) CGFloat moveScale;
@property(nonatomic,strong) UIColor* color;
@property(nonatomic,strong) UIColor* growColor;

@property(nonatomic, strong) SimpleCircleLiquidEngine * engine;
@property(nonatomic, strong) LiquittableCircle * moveCircle;
@property(nonatomic, strong) LiquittableCircle *shadowCircle;

@property(nonatomic, strong) CADisplayLink *timer;

@property(nonatomic, weak) LiquidLoader *loader;

@property(nonatomic, assign) BOOL isGrow;


@property(nonatomic, strong) NSMutableArray<LiquittableCircle *>* circles;
@property(nonatomic, assign) CGFloat circleRadius;

@property(nonatomic, assign) CGFloat key;

-(NSMutableArray<LiquittableCircle*>*)setupShape;
-(CGPoint)movePosition:(CGFloat)key;
-(void)update;
-(void)willSetup;
-(void)resize;
@end

@implementation LiquidLoadEffect

-(void)setIsGrow:(BOOL)isGrow{
    _isGrow = isGrow;
    [self grow:_isGrow];
}

-(void)setKey:(CGFloat)key{
    _key = key;
    [self updateKeyFrame:_key];
}

+(instancetype)loadEffectWithEffectType:(LiquidLoadEffectType)effectType
                                 loader:(LiquidLoader *)loader
                                  color:(UIColor *)color
                            circleCount:(NSInteger)circleCount
                               duration:(CGFloat)duration
                              growColor:(UIColor *)growColor{
    switch (effectType) {
        case LiquidLoadEffectTypeLine:
            return [[LiquidLoadLineEffect alloc] initWithLoader:loader color:color circleCount:circleCount duration:duration growColor:growColor];
        case LiquidLoadEffectTypeCircle:
            return [[LiquidLoadCircleEffect alloc] initWithLoader:loader color:color circleCount:circleCount duration:duration growColor:growColor];
        case LiquidLoadEffectTypeGrowLine:{
            LiquidLoadLineEffect* effect = [[LiquidLoadLineEffect alloc] initWithLoader:loader color:color circleCount:circleCount duration:duration growColor:growColor];
            effect.isGrow = true;
            return effect;
        }
        case LiquidLoadEffectTypeGrowCircle:{
            LiquidLoadCircleEffect* effect = [[LiquidLoadCircleEffect alloc] initWithLoader:loader color:color circleCount:circleCount duration:duration growColor:growColor];
            effect.isGrow = true;
            return effect;
        }
        default:
            NSLog(@"wrong LiquidLoadEffectType.");
    }
    
    return nil;
}

-(instancetype)initWithLoader:(LiquidLoader*)loader color:(UIColor *)color circleCount:(NSInteger)circleCount duration:(CGFloat)duration growColor:(UIColor *)growColor{
    self = [super init];
    self.circleScale = 1.17;
    self.moveScale = 0.80;
    self.numberOfCircles = circleCount;
    self.duration = duration;
    self.circleRadius = loader.frame.size.width * 0.05;
    self.loader = loader;
    self.color = color;
    if(growColor)
        self.growColor = growColor;
    else
        self.growColor = UIColor.redColor;
    [self setup];
    return  self;
}


-(void)resize{
    // abstract
}

-(void)setup{
    [self willSetup];
    [self.engine setColor:self.color];
    self.circles = [self setupShape];
    for ( LiquittableCircle *circle in self.circles){
        [self.loader addSubview:circle];
    }
    if( self.moveCircle ){
        [self.loader addSubview:self.moveCircle];
    }
    [self resize];
    self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [self.timer addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
}

-(void)updateKeyFrame:(CGFloat)key{
    [self.engine clear];
    CGPoint movePos = [self movePosition:key];
    [self.moveCircle setCenter:movePos];
    [self.shadowCircle setCenter:movePos];
    for(LiquittableCircle *circle in self.circles){
        if(self.moveCircle){
            [self.engine push:self.moveCircle other:circle];
        }
    }
    [self resize];
    if(self.loader){
        [self.engine draw:self.loader];
    }
    if(self.shadowCircle){
        [self.loader bringSubviewToFront:self.shadowCircle];
    }
}
-(NSMutableArray<LiquittableCircle*>*)setupShape{
    // abstract
    return NSMutableArray.array;
}
-(CGPoint)movePosition:(CGFloat)key{
    // abstract
    return CGPointZero;
}
-(void)update{
    // abstract
}
-(void)willSetup{
    // abstract
}
-(void)grow:(BOOL)isGrow{
    if(isGrow){
        self.shadowCircle = [[LiquittableCircle alloc] initWithCenter:[self.moveCircle center] radius:self.moveCircle.radius color:self.color growColor:self.growColor];
        [self.shadowCircle setIsGrow:isGrow];
        [self.loader addSubview:self.shadowCircle];
    }else{
        [self.shadowCircle removeFromSuperview];
    }
}
-(void)stopTimer{
    [self.timer invalidate];
}

@end


@interface LiquidLoadLineEffect()
@property(nonatomic,assign) CGFloat circleInter;
@end

@implementation LiquidLoadLineEffect

-(NSMutableArray<LiquittableCircle *> *)setupShape{
    NSMutableArray *ret = NSMutableArray.array;
    for(NSInteger idx=0;idx<self.numberOfCircles;idx++){
        CGPoint centerPoint = CGPointMake(self.circleInter + self.circleRadius + idx * (self.circleInter + 2 * self.circleRadius), self.loader.frame.size.height * 0.5);
        LiquittableCircle *circle = [[LiquittableCircle alloc] initWithCenter:centerPoint radius:self.circleRadius color:self.color growColor:self.growColor];
        [ret addObject:circle];
    }
    return ret;
}

-(CGPoint)movePosition:(CGFloat)key{
    if(self.loader == nil){
        return CGPointZero;
    }
    CGPoint ret;
    CGRect lastFrame = [self.circles lastObject].frame;
    ret.x = (lastFrame.origin.x + lastFrame.size.width + self.circleInter) * [self sineTransform:key];
    ret.y = [self.loader frame].size.height * 0.5;
    return ret;
}

-(CGFloat)sineTransform:(CGFloat)key{
    return sin(key * 3.14159265) * 0.5 + 0.5;
}

-(void)update{
    if(self.key >=0 && self.key <= 2){
        self.key += (2.0 / (self.duration * 60));
    }else{
        self.key = 0;
    }
}

-(void)willSetup{
    self.circleInter = (self.loader.frame.size.width - 2 * self.circleRadius * self.numberOfCircles) / (self.numberOfCircles + 1);
    self.engine = [[SimpleCircleLiquidEngine alloc] initWithRadiusThresh:self.circleRadius angleThresh:0.2];
    CGFloat moveCircleRadius = self.circleRadius * self.moveScale;
    CGPoint centerPoint = CGPointMake(0, self.loader.frame.size.height * 0.5);
    self.moveCircle = [[LiquittableCircle alloc] initWithCenter:centerPoint radius:moveCircleRadius color:self.color growColor:self.growColor];
}

-(void)resize{
    for(LiquittableCircle *circle in self.circles){
        CGFloat distance = CGPointLength( CGPointMinus(circle.center, self.moveCircle.center));
        CGFloat normalized = 1.0 - distance / (self.circleRadius + self.circleInter);
        if(normalized > 0){
            circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * normalized;
        }else{
            circle.radius = self.circleRadius;
        }
    }
}

@end


@interface LiquidLoadCircleEffect()
@end
@implementation LiquidLoadCircleEffect

-(CGFloat)radius{
    return self.loader.frame.size.width * 0.5;
}

-(NSMutableArray<LiquittableCircle *> *)setupShape{
    NSMutableArray *ret = NSMutableArray.array;
    for(NSInteger idx=0;idx<self.numberOfCircles;idx++){
        CGFloat angle = 1.0 * idx * 2 * 3.141592653 / 8.0;
        CGRect frame = self.loader.frame;
        CGPoint centerPoint = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
        CGPoint center = [CGMath circlePointWithCenter:CGPointMinus(centerPoint, frame.origin) radius:(self.radius - self.circleRadius) rad:angle];
        LiquittableCircle *circle = [[LiquittableCircle alloc] initWithCenter:center radius:self.circleRadius color:self.color growColor:self.growColor];
        [ret addObject:circle];
    }
    return ret;
}

-(CGPoint)movePosition:(CGFloat)key{
    if(self.loader == nil){
        return CGPointZero;
    }
    CGRect frame = self.loader.frame;
    CGPoint centerPoint = CGPointMake(frame.origin.x + frame.size.width / 2, frame.origin.y + frame.size.height / 2);
    CGPoint framePoint = CGPointMinus(centerPoint, frame.origin);
    
    return [CGMath circlePointWithCenter:framePoint radius:(self.radius - self.circleRadius) rad:(self.key * 2.0 * 3.141592653)];
}

-(void)update{
    if(self.key >=0 && self.key <= 1){
        self.key += (1.0 / (self.duration * 60));
    }else{
        self.key = self.key - 1.0;
    }
}


-(void)willSetup{
    self.circleRadius = self.loader.frame.size.width * 0.09;
    self.circleScale = 1.10;
    
    self.engine = [[SimpleCircleLiquidEngine alloc] initWithRadiusThresh:self.circleRadius * 0.85 angleThresh:0.5];
    CGFloat moveCircleRadius = self.circleRadius * self.moveScale;
    CGPoint centerPoint = [self movePosition:0];
    self.moveCircle = [[LiquittableCircle alloc] initWithCenter:centerPoint radius:moveCircleRadius color:self.color growColor:self.growColor];
}

-(void)resize{
    if(self.moveCircle == nil) return;
    if(self.loader == nil) return;
    
    CGPoint moveVec = CGPointMinus(self.moveCircle.center, CGPointMinus(self.loader.center, self.loader.frame.origin));
    moveVec = CGPointNormalized(moveVec);
    
    for(LiquittableCircle *circle in self.circles){
        
        CGPoint dotTo = CGPointNormalized(CGPointMinus(circle.center, CGPointMinus(self.loader.center, self.loader.frame.origin)));
        CGFloat dot = CGPointDot(moveVec, dotTo);
        if(dot > 0.75 && dot <= 1.0){
            CGFloat normalized = (dot - 0.75) / 0.25;
            CGFloat scale = normalized * normalized;
            circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * scale;
        }else{
            circle.radius = self.circleRadius;
        }
    }
}



@end
