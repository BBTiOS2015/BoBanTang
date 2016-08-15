//
//  StationHeat.m
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "StationHeat.h"

@implementation StationHeat

@synthesize latitude;
@synthesize longitude;
@synthesize level;

- (instancetype) initWithAttributes:(NSDictionary *)attributes{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.level=[attributes valueForKey:@"level"];
    self.latitude=[attributes valueForKey:@"latitude"];
    self.longitude=[attributes valueForKey:@"longitude"];
    return self;
}

@end
