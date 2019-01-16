//
//  NSArray+LiquidLoader.m
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import "NSArray+LiquidLoader.h"

@implementation NSArray (LiquidLoader)
-(NSArray*)take:(int)count{
    if(self.count == 0) return NSArray.array;
    NSInteger size = MIN(self.count, count);
    return [self subarrayWithRange:NSMakeRange(0, size)];
}

-(void)each:(void(^)(id))block{
    for (id obj in self) {
        block(obj);
    }
}

-(void)eachWithIndex:(void(^)(NSInteger,id))block{
    for(NSInteger idx = 0; idx < self.count; idx ++){
        block(idx, self[idx]);
    }
}

@end
