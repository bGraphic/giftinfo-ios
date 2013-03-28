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
    summaryString = [NSString stringWithFormat:summaryString, self.risk, self.symptoms, self.coal, self.action];
    
    return [NSString stringWithFormat:@"%@\n%@", summaryString, contentString];
}

+ (Poison *) poisonWithDict:(NSDictionary *) poisonDict
{
    Poison *poison = [[Poison alloc] init];
    if(poison)
    {
        poison.name = poisonDict[@"title"];
        poison.content = poisonDict[@"content"];
        poison.symptoms = poisonDict[@"custom_fields"][@"wpcf-symptoms"][0];
        poison.action = poisonDict[@"custom_fields"][@"wpcf-action"][0];
        poison.coal = poisonDict[@"custom_fields"][@"wpcf-coal"][0];
        poison.risk = poisonDict[@"custom_fields"][@"wpcf-risk"][0];
        poison.synonyms = [poisonDict[@"synonyms"] componentsSeparatedByString:@", "];
    }
    
    return poison;
}

@end
