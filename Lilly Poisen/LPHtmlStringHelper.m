//
//  LPHtmlStringHelper.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPHtmlStringHelper.h"

@implementation LPHtmlStringHelper

static NSMutableDictionary *htmlDict;

+ (NSString *) stringFromHtmlFileWithName:(NSString *) name
{
    if(htmlDict == nil)
        htmlDict = [NSMutableDictionary dictionary];
    
    if(!name || [name isEqualToString:@""])
    {
        return @"";
    }
    else if ([htmlDict valueForKey:name])
    {
        return [htmlDict valueForKey:name];
    }
    
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
    
    NSError *contentError;
    NSString *contentString = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:&contentError];
    
    if(contentError)
        NSLog(@"Problems loading html content with name:%@ because: %@", name, contentError.description);
    
    [htmlDict setValue:contentString forKey:name];

    return contentString;
}

+ (NSString *) stringFromArray:(NSArray *) array withSeperator:(NSString *) seperator
{
    NSString *arrayString;
    
    for(NSString *string in array)
    {
        if(!arrayString)
            arrayString = string;
        else
            arrayString = [NSString stringWithFormat:@"%@%@%@", arrayString, seperator, string];
    }
    
    return arrayString;
}

@end
