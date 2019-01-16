//
//  UIView+Grow.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/16.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (Grow)

-(void)growBaseColor:(UIColor *)baseColor radius:(CGFloat)radius shininess:(CGFloat)shininess;
-(void)growShadowRadius:(CGFloat)radius growColor:(UIColor *)growColor shininess:(CGFloat)shininess;

@end
