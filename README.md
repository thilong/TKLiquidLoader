# TKLiquidLoader
TKLiquidLoader is Objective-C implementation of [LiquidLoader](https://github.com/yoavlt/LiquidLoader)

## Usage
```objective-c
    CGRect circleFrame = CGRectMake(self.view.frame.size.width / 2 - 100, 200, 200, 200);
    UIColor *circleColor =  [UIColor colorWithRed:77 / 255.0 green:182 / 255.0 blue:255 / 255.0 alpha:1];
    UIColor *circleGrowColor =  [UIColor colorWithRed:99 / 255.0 green:202 / 255.0 blue:255 / 255.0 alpha:1];
    LiquidLoader *circleLoader = [[LiquidLoader alloc] initWithFrame:circleFrame effect:LiquidLoadEffectTypeGrowCircle color:circleColor circleCount:8 duration:15 growColor:circleGrowColor];
    [self.view addSubview:circleLoader];
```


### Show/Hide

You can show and hide a loader.

```objective-c
[loader show];
[loader hide];
```

### Effect Type
You can use the following effects.
* LiquidLoadEffectTypeLine
* LiquidLoadEffectTypeCircle
* LiquidLoadEffectTypeGrowLine
* LiquidLoadEffectTypeGrowCircle

## Installation

Copy folder 'LiquidLoader' and add the files to your project.

## Thanks

* [yoavlt](https://github.com/yoavlt)
* [Spinner Loader - Gooey light Effect](http://www.materialup.com/posts/spinner-loader-gooey-light-effect)
