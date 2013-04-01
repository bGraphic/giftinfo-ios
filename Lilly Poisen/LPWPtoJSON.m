//
//  LPWPtoJSON.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "LPWPtoJSON.h"

@implementation LPWPtoJSON

- (id) initWithFileName: (NSString *) fileName
{
    self = [super init];

    if(self)
    {
        self.fileName = fileName;
    }
    
    return self;
}

- (NSArray *)wpPostsInFile
{
    NSData *jsonData = [self jsonDataFromFile:self.fileName];
    NSDictionary *jsonDictonary = [self jsonDictonaryFromJsonData:jsonData];
    
    return jsonDictonary[@"posts"];
}

- (NSData *) jsonDataFromFile:(NSString *) fileName
{
    NSString *contentPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:contentPath];
    
    return data;
}

- (NSDictionary *) jsonDictonaryFromJsonData: (NSData *) jsonData
{
    NSError *error;
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:&error];
    
    if(error) {
        NSLog(@"Error: %@", [error description]);
    }
    
    return json;
}

+ (NSArray *) wpPostsInFile: (NSString *) fileName
{
    LPWPtoJSON *wpToJson = [[LPWPtoJSON alloc] initWithFileName:fileName];
    
    return wpToJson.wpPostsInFile;
}

@end
