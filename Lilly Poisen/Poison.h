//
//  Poison.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Term;

@interface Poison : NSObject

@property (nonatomic, strong) NSString * key;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * content;
@property (nonatomic, strong) NSString * symptoms;
@property (nonatomic, strong) NSString * action;
@property (nonatomic, strong) NSString * coal;
@property (nonatomic, strong) NSString * risk;
@property (nonatomic, strong) NSArray * synonyms;

@property (strong, nonatomic, readonly) NSString *htmlContentString;

+ (NSArray *) poisonWithDict:(NSDictionary *) poisonDict;

+ (NSArray *) poisonList;

@end
