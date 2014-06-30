//
//  FilterViewController.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "AccordionCell.h"
#import "MostPopularCell.h"
#import "PriceCell.h"

int const CATEGORIES_ROW_NUMBER = 3;
int const PRICE = 0;
int const CATEGORY = 1;
int const SORT = 2;
int const DISTANCE = 3;
int const DEALS = 4;
int const TOTAL = 5;

@interface FilterViewController ()


@property (weak, nonatomic) IBOutlet UITableView *filterView;
@property (strong, nonatomic) NSArray *mostPopularArray;
@property (strong, nonatomic) NSArray *sortBy;
@property (strong, nonatomic) NSArray *categories;
@property (strong, nonatomic) NSArray *distance;
@property (strong, nonatomic) NSDictionary *categoryKeys;
@property BOOL *showAllCategories;
@property BOOL *actionCell;
@property BOOL *distanceExpanded;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
@property (nonatomic, retain) NSIndexPath *checkedSortIndexPath;
@property (nonatomic, retain) NSIndexPath *checkedDistanceIndexPath;
@property (strong, nonatomic) NSMutableArray *categoriesFilter;
@property (strong, nonatomic) NSString *distanceFilter;
@property (strong, nonatomic) NSString *sortByFilter;


@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mostPopularArray = @[ @"Open Now", @"Hot & New", @"Offering a deal", @"Delivery" ];
        self.sortBy = @[ @"Best Match", @"Distance", @"Highest Rated" ];
        self.distance = @[ @"Auto", @"0.5 miles", @"1 mile", @"5 miles"];
        [self setTopLevelCategories];
        self.showAllCategories = NO;
        self.actionCell = NO;
        self.categoriesFilter = [[NSMutableArray alloc] init];
        self.distanceExpanded = NO;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Filters";
    
    //registration process
    [self.filterView registerNib:[UINib nibWithNibName:@"PriceCell" bundle:nil] forCellReuseIdentifier:@"PriceCell"];
    [self.filterView registerNib:[UINib nibWithNibName:@"MostPopularCell" bundle:nil] forCellReuseIdentifier:@"MostPopularCell"];
    [self.filterView registerNib:[UINib nibWithNibName:@"AccordionCell" bundle:nil] forCellReuseIdentifier:@"AccordionCell"];

    
    
    // Do any additional setup after loading the view from its nib.
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == PRICE){
        return @"Price";
    }
    if (section == CATEGORY){
        return @"Categories";
    }
    if (section == SORT){
        return @"Sort By";
    }
    if (section == DISTANCE){
        return @"Distance";
    }
    if (section == DEALS){
        return @"Deals";
    }
    
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //price,  deals
    if (section == PRICE || section == DEALS) {
        return 1;
    }
    //categories
    if (section == CATEGORY) {
        if (!self.showAllCategories){
            return CATEGORIES_ROW_NUMBER+1; //3 categories + show all row
        }else{
            return ([self.categories count]);//all categories + show less row
        }
    }
    //sort by
    if (section == SORT) {
        return [self.sortBy count];
    }
    
    //distance
    if (section == DISTANCE) {
        if (!self.distanceExpanded){
            return 1; //only show first row
        }else{
            return [self.distance count]; //show all options
        }
        
    }
    
    return 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setTopLevelCategories{
    self.categoryKeys = @{
                          @"Active Life" : @"active",
                          @"Arts & Entertainment" : @"arts",
                          @"Automotive" : @"auto",
                          @"Beauty & Spas" : @"beautysvc",
                          @"Education" : @"education",
                          @"Event Planning & Services" : @"eventservices",
                          @"Financial Services" : @"financialservices",
                          @"Food" : @"food",
                          @"Health & Medical" : @"health",
                          @"Home Services" : @"homeservices",
                          @"Hotels & Travel" : @"hotelstravel",
                          @"Local Flavor" : @"localflavor",
                          @"Local Services" : @"localservices",
                          @"Mass Media" : @"massmedia",
                          @"Nightlife" : @"nightlife",
                          @"Pets" : @"pets",
                          @"Professional Services" : @"professional",
                          @"Public Services & Government" : @"publicservicesgovt",
                          @"Real Estate" : @"realestate",
                          @"Religious Organizations" : @"religiousorgs",
                          @"Restaurants" : @"restaurants",
                          @"Shopping" : @"shopping"
                          };
    
    NSMutableArray *topLevelCategoriesArray = [[NSMutableArray alloc] init];
    //create an array with categories to display on the table view
    for (id key in [self.categoryKeys allKeys]) {
        [topLevelCategoriesArray addObject:key];
    }
    
    //categories sorted by alphabetical order
    self.categories = [[topLevelCategoriesArray copy] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return TOTAL;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
}

@end
