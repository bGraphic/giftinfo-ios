//
//  LPTopicDataSource.h
//  Lilly Poison
//
//  Created by Benedicte Raae on 02.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPTopic.h"

@interface LPTopicDataSource : NSObject <UITableViewDataSource, UISearchDisplayDelegate>

- (LPTopic *) topicAtIndexPath:(NSIndexPath *) indexPath;
- (LPTopic *) topicAtSlug:(NSString *) slug;

+ (LPTopic *) topicAtSlug:(NSString *) slug;

@end
