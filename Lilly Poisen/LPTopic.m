//
//  LPTopic.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPTopic.h"
#import "LPHtmlStringHelper.h"

@implementation LPTopic

static NSString *headerString;
static NSString *footerString;

- (NSString *) htmlString
{
    if(_htmlString == nil)
    {
        if(!headerString)
            headerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"header"];
    
        if(!footerString)
            footerString = [LPHtmlStringHelper stringFromHtmlFileWithName:@"footer"];

        NSString *headerWithData = [NSString stringWithFormat:headerString, self.title, @""];
        
        self.htmlString = [NSString stringWithFormat:@"%@\n%@\n%@", headerWithData, self.content, footerString];
    }

    return _htmlString;
}

@end
