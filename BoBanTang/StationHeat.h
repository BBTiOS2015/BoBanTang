//
//  StationHeat.h
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationHeat : NSObject

@property (nonatomic,strong) NSString* level;
@property (nonatomic,strong) NSString* latitude;
@property (nonatomic,strong) NSString* longitude;

- (instancetype) initWithAttributes:(NSDictionary *)attributes;


@end
