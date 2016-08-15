//
//  CampusBus.h
//  BoBanTang
//
//  Created by Authority on 16/8/14.
//  Copyright © 2016年 Authority. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface CampusBus : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic,strong) NSString* stop;
@property (nonatomic,strong) NSString* fly;
@property (nonatomic,strong) NSString* headingSouth;
@property (nonatomic,strong) NSString* latitude;
@property (nonatomic,strong) NSString* longitude;

- (instancetype) initWithAttributes:(NSDictionary *)attributes;



@end
