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

static NSString *headerString;
static NSString *footerString;
static NSString *summaryString;


- (NSString *) htmlString
{
    if (_htmlString == nil)
    {
        if(!headerString)
        headerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"header"];
        
        if(!footerString)
            footerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"footer"];
        
        if(!summaryString)
            summaryString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"summary"];
        
        NSString *summaryWithData = [NSString stringWithFormat:summaryString, self.risk, self.symptoms, self.coal?@"Ja":@"Nei", self.action?self.action:@"Ingen spesielle tiltak"];
            
        NSString *headerWithData = [NSString stringWithFormat:headerString, self.name, [LPHtmlStringHelper stringFromArray:self.otherNames withSeperator:@", "]];
            
        self.htmlString = [NSString stringWithFormat:@"%@\n%@\n%@\n%@", headerWithData, summaryWithData, self.content, footerString];
    }
    
    return _htmlString;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"Name: %@ \nSlug: %@ \nTag: %@", self.name, self.slug, [LPHtmlStringHelper stringFromArray:self.tags withSeperator:@", "]];
}

@end