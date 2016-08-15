//
//  CampusBus.m
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "CampusBus.h"

@implementation CampusBus

@synthesize name;
@synthesize stop;
@synthesize fly;
@synthesize headingSouth;
@synthesize latitude;
@synthesize longitude;


- (instancetype) initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.name=[attributes valueForKey:@"Name"];
    self.headingSouth=[attributes valueForKey:@"Direction"];
    self.stop=[attributes valueForKey:@"Stop"];
    self.fly=[attributes valueForKey:@"Fly"];
    self.latitude=[attributes valueForKey:@"Latitude"];
    self.longitude=[attributes valueForKey:@"Longitude"];
    
    return self;
}

@end
