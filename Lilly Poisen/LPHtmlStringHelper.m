//
//  LPHtmlStringHelper.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPHtmlStringHelper.h"

@implementation LPHtmlStringHelper

+ (NSString *) stringFromHtmlFileWithName:(NSString *) name
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:name ofType:@"html"];
    
    NSError *contentError;
    NSString *contentString = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:&contentError];
    
    if(contentError)
        NSLog(@"Problems loading html content with name:%@ because: %@", name, contentError.description);

    return contentString;
}

@end
