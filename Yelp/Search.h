//
//  Search.h
//  Yelp
//
//  Created by Tushar Bhushan on 6/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *address; //street + city
@property (strong,nonatomic) NSNumber *rating;
@property (strong,nonatomic) NSNumber *reviewCount;
@property (strong,nonatomic) NSString *categories;
@property (strong,nonatomic) NSString *imageURL;
@property (strong,nonatomic) NSString *ratingImageURL;

- (id)initWithDict: (NSDictionary *)dictionary;
+ (NSArray *)loadInArray: (NSArray *)array;

@end
