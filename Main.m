//
//  Main.m
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Main.h"


NSString *const kMainHumidity = @"humidity";
NSString *const kMainTempMax = @"temp_max";
NSString *const kMainTempMin = @"temp_min";
NSString *const kMainTemp = @"temp";
NSString *const kMainPressure = @"pressure";


@interface Main ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Main

@synthesize humidity = _humidity;
@synthesize temp_max = _temp_max;
@synthesize temp_min = _temp_min;
@synthesize temp = _temp;
@synthesize pressure = _pressure;


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
            self.humidity = [[self objectOrNilForKey:kMainHumidity fromDictionary:dict] doubleValue];
            self.temp_max = [[self objectOrNilForKey:kMainTempMax fromDictionary:dict] doubleValue];
            self.temp_min = [[self objectOrNilForKey:kMainTempMin fromDictionary:dict] doubleValue];
            self.temp = [[self objectOrNilForKey:kMainTemp fromDictionary:dict] doubleValue];
            self.pressure = [[self objectOrNilForKey:kMainPressure fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.humidity] forKey:kMainHumidity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp_max] forKey:kMainTempMax];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp_min] forKey:kMainTempMin];
    [mutableDict setValue:[NSNumber numberWithDouble:self.temp] forKey:kMainTemp];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pressure] forKey:kMainPressure];

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

    self.humidity = [aDecoder decodeDoubleForKey:kMainHumidity];
    self.temp_max = [aDecoder decodeDoubleForKey:kMainTempMax];
    self.temp_min = [aDecoder decodeDoubleForKey:kMainTempMin];
    self.temp = [aDecoder decodeDoubleForKey:kMainTemp];
    self.pressure = [aDecoder decodeDoubleForKey:kMainPressure];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_humidity forKey:kMainHumidity];
    [aCoder encodeDouble:_temp_max forKey:kMainTempMax];
    [aCoder encodeDouble:_temp_min forKey:kMainTempMin];
    [aCoder encodeDouble:_temp forKey:kMainTemp];
    [aCoder encodeDouble:_pressure forKey:kMainPressure];
}

- (id)copyWithZone:(NSZone *)zone
{
    Main *copy = [[Main alloc] init];
    
    if (copy) {

        copy.humidity = self.humidity;
        copy.temp_max = self.temp_max;
        copy.temp_min = self.temp_min;
        copy.temp = self.temp;
        copy.pressure = self.pressure;
    }
    
    return copy;
}


@end
