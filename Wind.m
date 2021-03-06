//
//  Wind.m
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "Wind.h"


NSString *const kWindSpeed = @"speed";
NSString *const kWindDeg = @"deg";


@interface Wind ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Wind

@synthesize speed = _speed;
@synthesize deg = _deg;


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
            self.speed = [[self objectOrNilForKey:kWindSpeed fromDictionary:dict] doubleValue];
            self.deg = [[self objectOrNilForKey:kWindDeg fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.speed] forKey:kWindSpeed];
    [mutableDict setValue:[NSNumber numberWithDouble:self.deg] forKey:kWindDeg];

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

    self.speed = [aDecoder decodeDoubleForKey:kWindSpeed];
    self.deg = [aDecoder decodeDoubleForKey:kWindDeg];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_speed forKey:kWindSpeed];
    [aCoder encodeDouble:_deg forKey:kWindDeg];
}

- (id)copyWithZone:(NSZone *)zone
{
    Wind *copy = [[Wind alloc] init];
    
    if (copy) {

        copy.speed = self.speed;
        copy.deg = self.deg;
    }
    
    return copy;
}


@end
