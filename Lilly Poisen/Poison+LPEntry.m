//
//  Poison+LPEntry.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "Poison+LPEntry.h"
#import "LPHtmlStringHelper.h"

@implementation Poison (LPEntry)

- (NSString *) htmlContentString
{
    NSString *contentString = [LPHtmlStringHelper stringFromHtmlFileWithName:self.key];
    NSString *summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
    summaryString = [NSString stringWithFormat:summaryString, self.risk, self.symptoms, [self.coal stringValue], self.action];
    
    return [NSString stringWithFormat:@"%@\n%@\n%@", summaryString, contentString, self.name];
}

@end
