//
//  WeatherReport.m
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "WeatherReport.h"
#import "Wind.h"
#import "Clouds.h"
#import "Coord.h"
#import "Weather.h"
#import "Main.h"
#import "Sys.h"


NSString *const kWeatherReportWind = @"wind";
NSString *const kWeatherReportBase = @"base";
NSString *const kWeatherReportClouds = @"clouds";
NSString *const kWeatherReportCoord = @"coord";
NSString *const kWeatherReportId = @"id";
NSString *const kWeatherReportDt = @"dt";
NSString *const kWeatherReportCod = @"cod";
NSString *const kWeatherReportWeather = @"weather";
NSString *const kWeatherReportMain = @"main";
NSString *const kWeatherReportSys = @"sys";
NSString *const kWeatherReportName = @"name";


@interface WeatherReport ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation WeatherReport

@synthesize wind = _wind;
@synthesize base = _base;
@synthesize clouds = _clouds;
@synthesize coord = _coord;
@synthesize internalBaseClassIdentifier = _internalBaseClassIdentifier;
@synthesize dt = _dt;
@synthesize cod = _cod;
@synthesize weather = _weather;
@synthesize main = _main;
@synthesize sys = _sys;
@synthesize name = _name;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.wind = [Wind modelObjectWithDictionary:[dict objectForKey:kWeatherReportWind]];
            self.base = [self objectOrNilForKey:kWeatherReportBase fromDictionary:dict];
            self.clouds = [Clouds modelObjectWithDictionary:[dict objectForKey:kWeatherReportClouds]];
            self.coord = [Coord modelObjectWithDictionary:[dict objectForKey:kWeatherReportCoord]];
            self.internalBaseClassIdentifier = [[self objectOrNilForKey:kWeatherReportId fromDictionary:dict] doubleValue];
            self.dt = [[self objectOrNilForKey:kWeatherReportDt fromDictionary:dict] doubleValue];
            self.cod = [[self objectOrNilForKey:kWeatherReportCod fromDictionary:dict] doubleValue];
    NSObject *receivedWeather = [dict objectForKey:kWeatherReportWeather];
    NSMutableArray *parsedWeather = [NSMutableArray array];
    if ([receivedWeather isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedWeather) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedWeather addObject:[Weather modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedWeather isKindOfClass:[NSDictionary class]]) {
       [parsedWeather addObject:[Weather modelObjectWithDictionary:(NSDictionary *)receivedWeather]];
    }

    self.weather = [NSArray arrayWithArray:parsedWeather];
            self.main = [Main modelObjectWithDictionary:[dict objectForKey:kWeatherReportMain]];
            self.sys = [Sys modelObjectWithDictionary:[dict objectForKey:kWeatherReportSys]];
            self.name = [self objectOrNilForKey:kWeatherReportName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.wind dictionaryRepresentation] forKey:kWeatherReportWind];
    [mutableDict setValue:self.base forKey:kWeatherReportBase];
    [mutableDict setValue:[self.clouds dictionaryRepresentation] forKey:kWeatherReportClouds];
    [mutableDict setValue:[self.coord dictionaryRepresentation] forKey:kWeatherReportCoord];
    [mutableDict setValue:[NSNumber numberWithDouble:self.internalBaseClassIdentifier] forKey:kWeatherReportId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dt] forKey:kWeatherReportDt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.cod] forKey:kWeatherReportCod];
    NSMutableArray *tempArrayForWeather = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weather) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeather addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeather addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeather] forKey:kWeatherReportWeather];
    [mutableDict setValue:[self.main dictionaryRepresentation] forKey:kWeatherReportMain];
    [mutableDict setValue:[self.sys dictionaryRepresentation] forKey:kWeatherReportSys];
    [mutableDict setValue:self.name forKey:kWeatherReportName];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.wind = [aDecoder decodeObjectForKey:kWeatherReportWind];
    self.base = [aDecoder decodeObjectForKey:kWeatherReportBase];
    self.clouds = [aDecoder decodeObjectForKey:kWeatherReportClouds];
    self.coord = [aDecoder decodeObjectForKey:kWeatherReportCoord];
    self.internalBaseClassIdentifier = [aDecoder decodeDoubleForKey:kWeatherReportId];
    self.dt = [aDecoder decodeDoubleForKey:kWeatherReportDt];
    self.cod = [aDecoder decodeDoubleForKey:kWeatherReportCod];
    self.weather = [aDecoder decodeObjectForKey:kWeatherReportWeather];
    self.main = [aDecoder decodeObjectForKey:kWeatherReportMain];
    self.sys = [aDecoder decodeObjectForKey:kWeatherReportSys];
    self.name = [aDecoder decodeObjectForKey:kWeatherReportName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_wind forKey:kWeatherReportWind];
    [aCoder encodeObject:_base forKey:kWeatherReportBase];
    [aCoder encodeObject:_clouds forKey:kWeatherReportClouds];
    [aCoder encodeObject:_coord forKey:kWeatherReportCoord];
    [aCoder encodeDouble:_internalBaseClassIdentifier forKey:kWeatherReportId];
    [aCoder encodeDouble:_dt forKey:kWeatherReportDt];
    [aCoder encodeDouble:_cod forKey:kWeatherReportCod];
    [aCoder encodeObject:_weather forKey:kWeatherReportWeather];
    [aCoder encodeObject:_main forKey:kWeatherReportMain];
    [aCoder encodeObject:_sys forKey:kWeatherReportSys];
    [aCoder encodeObject:_name forKey:kWeatherReportName];
}

- (id)copyWithZone:(NSZone *)zone
{
    WeatherReport *copy = [[WeatherReport alloc] init];
    
    if (copy) {

        copy.wind = [self.wind copyWithZone:zone];
        copy.base = [self.base copyWithZone:zone];
        copy.clouds = [self.clouds copyWithZone:zone];
        copy.coord = [self.coord copyWithZone:zone];
        copy.internalBaseClassIdentifier = self.internalBaseClassIdentifier;
        copy.dt = self.dt;
        copy.cod = self.cod;
        copy.weather = [self.weather copyWithZone:zone];
        copy.main = [self.main copyWithZone:zone];
        copy.sys = [self.sys copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
