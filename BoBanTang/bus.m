//
//  bus.m
//  BoBanTang
//
//  Created by Authority on 16/8/6.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "bus.h"

@implementation bus


- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err
{
    self = [super initWithDictionary:dict error:err];
    if (!self) return nil;
    
    _retrievedAt = [NSDate date];
    
    return self;
}

+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"Name": @"name",
                                                       @"Direction": @"headingSouth",
                                                       @"Time": @"updateAt",
                                                       @"Stop": @"stop",
                                                       @"Station" : @"stationName",
                                                       @"StationIndex" : @"stationIndex",
                                                       @"Percent" : @"percent",
                                                       @"Fly" : @"fly",
                                                       @"Latitude" : @"latitude",
                                                       @"Longitude" : @"longitude"
                                                       }];
}
@end