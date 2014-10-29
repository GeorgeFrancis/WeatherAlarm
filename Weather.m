//
//  Weather.m
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Weather.h"


NSString *const kWeatherId = @"id";
NSString *const kWeatherMain = @"main";
NSString *const kWeatherIcon = @"icon";
NSString *const kWeatherDescription = @"description";


@interface Weather ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Weather

@synthesize weatherIdentifier = _weatherIdentifier;
@synthesize main = _main;
@synthesize icon = _icon;
@synthesize weatherDescription = _weatherDescription;


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
            self.weatherIdentifier = [[self objectOrNilForKey:kWeatherId fromDictionary:dict] doubleValue];
            self.main = [self objectOrNilForKey:kWeatherMain fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kWeatherIcon fromDictionary:dict];
            self.weatherDescription = [self objectOrNilForKey:kWeatherDescription fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.weatherIdentifier] forKey:kWeatherId];
    [mutableDict setValue:self.main forKey:kWeatherMain];
    [mutableDict setValue:self.icon forKey:kWeatherIcon];
    [mutableDict setValue:self.weatherDescription forKey:kWeatherDescription];

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

    self.weatherIdentifier = [aDecoder decodeDoubleForKey:kWeatherId];
    self.main = [aDecoder decodeObjectForKey:kWeatherMain];
    self.icon = [aDecoder decodeObjectForKey:kWeatherIcon];
    self.weatherDescription = [aDecoder decodeObjectForKey:kWeatherDescription];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_weatherIdentifier forKey:kWeatherId];
    [aCoder encodeObject:_main forKey:kWeatherMain];
    [aCoder encodeObject:_icon forKey:kWeatherIcon];
    [aCoder encodeObject:_weatherDescription forKey:kWeatherDescription];
}

- (id)copyWithZone:(NSZone *)zone
{
    Weather *copy = [[Weather alloc] init];
    
    if (copy) {

        copy.weatherIdentifier = self.weatherIdentifier;
        copy.main = [self.main copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.weatherDescription = [self.weatherDescription copyWithZone:zone];
    }
    
    return copy;
}


@end
