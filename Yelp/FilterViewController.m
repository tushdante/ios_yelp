//
//  FilterViewController.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"

int const CATEGORIES_ROW_NUMBER = 3;
int const PRICE = 0;
int const CATEGORY = 1;
int const SORT = 2;
int const DISTANCE = 3;
int const DEALS = 4;
int const TOTAL = 5;

@interface FilterViewController ()


@property (weak, nonatomic) IBOutlet UITableView *filterView;
@property (strong, nonatomic) NSArray *mostPopular;
@property (strong, nonatomic) NSArray *sortBy;
@property (strong, nonatomic) NSArray *distance;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mostPopular = @[ @"Open Now", @"Hot & New", @"Offering a deal", @"Delivery" ];
        self.sortBy = @[ @"Best Match", @"Distance", @"Highest Rated" ];
        self.distance = @[ @"Auto", @"0.5 miles", @"1 mile", @"5 miles"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
