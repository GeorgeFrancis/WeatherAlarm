//
//  Sys.h
//
//  Created by   on 09/08/2014
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Sys : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double sysIdentifier;
@property (nonatomic, assign) double message;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, assign) double type;
@property (nonatomic, assign) double sunset;
@property (nonatomic, assign) double sunrise;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
