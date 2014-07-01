//
//  SearchViewController.h
//  Yelp
//
//  Created by Tushar Bhushan on 6/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Filters.h"
@interface SearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) Filters *filters;

@end
