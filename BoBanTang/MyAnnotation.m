//
//  MyAnnotation.m
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation

@synthesize longitude;
@synthesize latitude;
@synthesize kind;

-(id)initMapAnnotation:(double)Latitude
          andLongitude:(double)Longitude
                  Kind:(int)Kind{
    self=[super init];
    if(!self) return nil;
    
    self.latitude=Latitude;
    self.longitude=Longitude;
    self.kind=Kind;
    return self;
}

-(CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.latitude;
    coordinate.longitude = self.longitude;
    return coordinate;
}


@end
