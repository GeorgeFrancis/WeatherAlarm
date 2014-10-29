//
//  Main.h
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Main : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double temp_max;
@property (nonatomic, assign) double temp_min;
@property (nonatomic, assign) double temp;
@property (nonatomic, assign) double pressure;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
