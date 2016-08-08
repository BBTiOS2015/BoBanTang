//
//  bus.h
//  BoBanTang
//
//  Created by Authority on 16/8/6.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface bus : JSONModel

@property (strong, nonatomic, readwrite) NSString *name;
@property (strong, nonatomic, readwrite) NSDate *updateAt;   //the time stamp for the bus

/* bus state */
@property (nonatomic, getter = isStop, readwrite) BOOL stop;
@property (nonatomic, getter = isFly, readwrite) BOOL fly;   // indicate if bus is on its normal routine

/* bus running progress */
@property (strong, nonatomic, readwrite) NSString *stationName;
@property (nonatomic, readwrite) NSUInteger stationIndex;
@property (nonatomic, readwrite) double percent;
@property (nonatomic, readwrite) BOOL headingSouth;
@property (nonatomic, readwrite) double latitude;
@property (nonatomic, readwrite) double longitude;
@property (strong, nonatomic, readonly) NSDate *retrievedAt;

@end
