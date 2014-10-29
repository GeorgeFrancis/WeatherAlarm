//
//  WeatherReport.h
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Wind, Clouds, Coord, Main, Sys;

@interface WeatherReport : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) Wind *wind;
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) Clouds *clouds;
@property (nonatomic, strong) Coord *coord;
@property (nonatomic, assign) double internalBaseClassIdentifier;
@property (nonatomic, assign) double dt;
@property (nonatomic, assign) double cod;
@property (nonatomic, strong) NSArray *weather;
@property (nonatomic, strong) Main *main;
@property (nonatomic, strong) Sys *sys;
@property (nonatomic, strong) NSString *name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
