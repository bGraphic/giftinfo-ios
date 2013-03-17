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
    NSString *contentString = [LPHtmlStringHelper stringFromHtmlFileWithName:self.key];
    NSString *summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
    summaryString = [NSString stringWithFormat:summaryString, self.risk, self.symptoms, self.coal, self.action];
    
    return [NSString stringWithFormat:@"%@\n%@\n%@", summaryString, contentString, self.name];
}

+ (Poison *) poisonWithDict:(NSDictionary *) poisonDict
{
    Poison *poison = [[Poison alloc] init];
    if(poison)
    {
        poison.key = poisonDict[@"key"];
        poison.name = poisonDict[@"name"];
        poison.symptoms = poisonDict[@"symptoms"];
        poison.action = poisonDict[@"action"];
        poison.coal = poisonDict[@"coal"];
        poison.risk = poisonDict[@"risk"];
        poison.synonyms = [poisonDict[@"synonyms"] componentsSeparatedByString:@", "];
    }
    
    return poison;
}

@end
