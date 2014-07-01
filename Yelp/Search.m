//
//  Search.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Search.h"

@implementation Search

- (id)initWithDict: (NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        
        //create location = address + city
        NSMutableString *loc = [NSMutableString string];
        if ([dictionary[@"location"][@"address"] count]>0) {
            [loc appendString: dictionary[@"location"][@"address"][0]];
            [loc appendString: @", "];
            [loc appendString: dictionary[@"location"][@"city"]];
            self.address =  [NSString stringWithString:loc];
        }else{
            self.address = dictionary[@"location"][@"city"];
        }
        
        
        
        self.name = dictionary[@"name"];
        self.rating = dictionary[@"rating"];
        self.reviewCount = dictionary[@"review_count"];
        self.imageURL = dictionary[@"image_url"];
        self.ratingImageURL = dictionary[@"rating_img_url"];
    }
    
    return self;
}

+ (NSArray *)loadInArray: (NSArray *)array {
    NSMutableArray *catalog = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dictionary in array){
        Search *business = [[Search alloc] initWithDict:dictionary];
        [catalog addObject:business];
    }
    
    return catalog;
}

@end
