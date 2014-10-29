//
//  Sys.m
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Sys.h"


NSString *const kSysId = @"id";
NSString *const kSysMessage = @"message";
NSString *const kSysCountry = @"country";
NSString *const kSysType = @"type";
NSString *const kSysSunset = @"sunset";
NSString *const kSysSunrise = @"sunrise";


@interface Sys ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Sys

@synthesize sysIdentifier = _sysIdentifier;
@synthesize message = _message;
@synthesize country = _country;
@synthesize type = _type;
@synthesize sunset = _sunset;
@synthesize sunrise = _sunrise;


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
            self.sysIdentifier = [[self objectOrNilForKey:kSysId fromDictionary:dict] doubleValue];
            self.message = [[self objectOrNilForKey:kSysMessage fromDictionary:dict] doubleValue];
            self.country = [self objectOrNilForKey:kSysCountry fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kSysType fromDictionary:dict] doubleValue];
            self.sunset = [[self objectOrNilForKey:kSysSunset fromDictionary:dict] doubleValue];
            self.sunrise = [[self objectOrNilForKey:kSysSunrise fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sysIdentifier] forKey:kSysId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.message] forKey:kSysMessage];
    [mutableDict setValue:self.country forKey:kSysCountry];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kSysType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunset] forKey:kSysSunset];
    [mutableDict setValue:[NSNumber numberWithDouble:self.sunrise] forKey:kSysSunrise];

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

    self.sysIdentifier = [aDecoder decodeDoubleForKey:kSysId];
    self.message = [aDecoder decodeDoubleForKey:kSysMessage];
    self.country = [aDecoder decodeObjectForKey:kSysCountry];
    self.type = [aDecoder decodeDoubleForKey:kSysType];
    self.sunset = [aDecoder decodeDoubleForKey:kSysSunset];
    self.sunrise = [aDecoder decodeDoubleForKey:kSysSunrise];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_sysIdentifier forKey:kSysId];
    [aCoder encodeDouble:_message forKey:kSysMessage];
    [aCoder encodeObject:_country forKey:kSysCountry];
    [aCoder encodeDouble:_type forKey:kSysType];
    [aCoder encodeDouble:_sunset forKey:kSysSunset];
    [aCoder encodeDouble:_sunrise forKey:kSysSunrise];
}

- (id)copyWithZone:(NSZone *)zone
{
    Sys *copy = [[Sys alloc] init];
    
    if (copy) {

        copy.sysIdentifier = self.sysIdentifier;
        copy.message = self.message;
        copy.country = [self.country copyWithZone:zone];
        copy.type = self.type;
        copy.sunset = self.sunset;
        copy.sunrise = self.sunrise;
    }
    
    return copy;
}


@end
