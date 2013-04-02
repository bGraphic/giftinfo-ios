//
//  Poison.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 16.03.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPPoison.h"
#import "LPHtmlStringHelper.h"

@implementation LPPoison

- (NSString *) htmlString
{
    if (_htmlString == nil)
    {

        NSString *headerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"header"];
        
        NSString *footerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"footer"];
        
        NSString *summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
        
        NSString *summaryWithData = [NSString stringWithFormat:summaryString, self.risk, self.symptoms, self.coal?@"Ja":@"Nei", self.action?self.action:@"Ingen spesielle tiltak"];
            
        NSString *headerWithData = [NSString stringWithFormat:headerString, self.name, self.otherNames?[LPHtmlStringHelper stringFromArray:self.otherNames withSeperator:@", "]:@""];
            
        self.htmlString = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", headerWithData, summaryWithData, self.content, footerString];
    }
    
    return _htmlString;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Name: %@ \nSlug: %@ \nTag: %@", self.name, self.slug, [LPHtmlStringHelper stringFromArray:self.tags withSeperator:@", "]];
}

@end