//
//  Poison.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "Poison.h"
#import "Term.h"
#import "LPHtmlStringHelper.h"

@implementation Poison

- (NSString *) htmlContentString
{
    NSString *contentString = self.content;
    NSString *summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
    summaryString = [NSString stringWithFormat:summaryString, self.name, self.risk, self.symptoms, self.coal, self.action];
    
    return [NSString stringWithFormat:@"%@\n%@", summaryString, contentString];
}

@end