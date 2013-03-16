//
//  Poison+LPEntry.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "Poison+LPEntry.h"

@implementation Poison (LPEntry)

- (NSString *) htmlString
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:self.key ofType:@"html"];
    
    NSError *contentError;
    NSString *contentString = [NSString stringWithContentsOfFile:contentPath encoding:NSUTF8StringEncoding error:&contentError];
    
    if(contentError)
        NSLog(@"Problems loading content %@", contentError.description);
    
    return contentString;
}

@end
