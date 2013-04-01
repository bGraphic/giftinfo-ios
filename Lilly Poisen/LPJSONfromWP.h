//
//  LPWPtoJSON.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPJSONfromWP : NSObject

@property (nonatomic, strong) NSString *fileName;
@property (nonatomic, strong) NSArray *wpPostsInFile;

+ (NSArray *) wpPostsInFile: (NSString *) fileName;

@end
