//
//  ViewController.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "ViewController.h"

#import "LiquidLoader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:9 / 255.0 green:21 / 255.0 blue:37 / 255.0 alpha:1];
    
    UIColor *lineColor =  [UIColor colorWithRed:77 / 255.0 green:255 / 255.0 blue:182 / 255.0 alpha:1];
    UIColor *lineGrowColor = [UIColor colorWithRed:97 / 255.0 green:255 / 255.0 blue:202 / 255.0 alpha:1];
    CGRect lineFrame = CGRectMake(self.view.frame.size.width / 2 - 100, 100, 200, 40);
    LiquidLoader *lineLoader = [[LiquidLoader alloc] initWithFrame:lineFrame effect:LiquidLoadEffectTypeGrowLine color:lineColor circleCount:3 duration:10 growColor:lineGrowColor];
    [self.view addSubview:lineLoader];
    
    
    CGRect circleFrame = CGRectMake(self.view.frame.size.width / 2 - 100, 200, 200, 200);
    UIColor *circleColor =  [UIColor colorWithRed:77 / 255.0 green:182 / 255.0 blue:255 / 255.0 alpha:1];
    UIColor *circleGrowColor =  [UIColor colorWithRed:99 / 255.0 green:202 / 255.0 blue:255 / 255.0 alpha:1];
    LiquidLoader *circleLoader = [[LiquidLoader alloc] initWithFrame:circleFrame effect:LiquidLoadEffectTypeGrowCircle color:circleColor circleCount:8 duration:15 growColor:circleGrowColor];
    [self.view addSubview:circleLoader];
}


@end
