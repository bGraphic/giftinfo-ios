//
//  LPTopic.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 01.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPTopic : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * content;

+ (LPTopic *) topicFromDict:(NSDictionary *) poisonDict;

@end
