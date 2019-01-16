//
//  NSArray+LiquidLoader.h
//  TKLiquidLoader
//
//  Created by Aidoo.tk on 2019/1/15.
//  Copyright © 2019 Aidoo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (LiquidLoader)

-(NSArray*)take:(int)count;

-(void)each:(void(^)(id))block;

-(void)eachWithIndex:(void(^)(NSInteger,id))block;



@end

