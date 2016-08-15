//
//  MyAnnotation.h
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MyAnnotation : NSObject<BMKAnnotation>

@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) int kind;

-(id)initMapAnnotation:(double)latitude
          andLongitude:(double)longitude
                  Kind:(int)kind;



@end
