//
//  Filters.h
//  Yelp
//
//  Created by Tushar Bhushan on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Filters : NSObject
@property NSInteger price;
@property (strong, nonatomic) NSMutableArray *category;
@property (strong, nonatomic) NSString *sortBy;
@property (strong, nonatomic) NSString *distance;
@property BOOL *deals;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSDictionary *distanceConversions;
@property (strong, nonatomic) NSDictionary *sortCodes;

@end
