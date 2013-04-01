//
//  LPHtmlStringHelper.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPHtmlStringHelper : NSObject

+ (NSString *) stringFromHtmlFileWithName:(NSString *) name;

+ (NSString *) stringFromArray:(NSArray *) array withSeperator:(NSString *) seperator;

@end
