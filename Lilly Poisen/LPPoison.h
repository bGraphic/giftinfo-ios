//
//  Poison.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@class Term;

@interface LPPoison : PFObject <PFSubclassing>

@property (retain) NSString * slug;
@property (retain) NSString * name;
@property (retain) NSArray * otherNames;
@property (retain) NSString * content;
@property (retain) NSString * symptoms;
@property (retain) NSString * action;
@property (retain) NSString * coal;
@property (retain) NSString * risk;
@property (retain) NSArray * tags;

@property (nonatomic, strong) NSString * htmlString;

@end
