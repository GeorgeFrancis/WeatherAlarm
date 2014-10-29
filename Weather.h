//
//  Weather.h
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Weather : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double weatherIdentifier;
@property (nonatomic, strong) NSString *main;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *weatherDescription;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
