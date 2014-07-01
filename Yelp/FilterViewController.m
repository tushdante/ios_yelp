//
//  FilterViewController.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "FilterViewController.h"
#import "SearchViewController.h"
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
    //price
    UITableViewCell *cell;
    if (indexPath.section == PRICE) {
        PriceCell *priceCell = [tableView dequeueReusableCellWithIdentifier:@"PriceCell"];
        priceCell.priceControl.selectedSegmentIndex = self.filters.price;
        [priceCell.priceControl addTarget:self action:@selector(setPriceFilter:) forControlEvents:UIControlEventValueChanged];
        cell = priceCell;
    }
    
    //categories
    if(indexPath.section == CATEGORY){
        AccordionCell *categoryCell = [tableView dequeueReusableCellWithIdentifier:@"AccordionCell"];
        
        if (!self.showAllCategories){
            if (indexPath.row == (CATEGORIES_ROW_NUMBER)) {
                //show more option on the 4th row
                categoryCell.rowLabel.text = @"Show more ...";
            }else{
                categoryCell.rowLabel.text = self.categories[indexPath.row];
            }
        }else{
            NSLog(@"indexpath.row %d, catcount: %d", indexPath.row, ([self.categories count]-1));
            if (indexPath.row == ([self.categories count]-1)) {
                //show less option on the last row
                categoryCell.rowLabel.text = @"Show Less ...";
            }else{
                categoryCell.rowLabel.text = self.categories[indexPath.row];
            }
            
        }
        cell = categoryCell;
        
        if([self isCategorySavedInFilteredSettings:self.categories[indexPath.row]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
    }
    
    //sort by
    if(indexPath.section == SORT){
        AccordionCell *sortByCell = [tableView dequeueReusableCellWithIdentifier:@"AccordionCell"];
        sortByCell.rowLabel.text = self.sortBy[indexPath.row];
        cell = sortByCell;
        //NSLog(@"default sort: %@,%@", self.filterOptions.sortBy, self.sortBy[indexPath.row]);
        
        if([self.filters.sortBy isEqualToString:self.sortBy[indexPath.row]]){
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            //NSLog(@"equal");
            self.checkedSortIndexPath = indexPath;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    //distance
    if(indexPath.section == DISTANCE){
        AccordionCell *distanceCell = [tableView dequeueReusableCellWithIdentifier:@"AccordionCell"];
        distanceCell.rowLabel.text = self.distance[indexPath.row];
        cell = distanceCell;
        //NSLog(@"default distance: %@,%@", self.filterOptions.distance, self.distance[indexPath.row]);
        
        if([self.filters.distance isEqualToString:self.distance[indexPath.row]]){
            //NSLog(@"equal");
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.checkedDistanceIndexPath = indexPath;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    //deals
    if(indexPath.section == DEALS){
        MostPopularCell *dealsCell = [tableView dequeueReusableCellWithIdentifier:@"MostPopularCell"];
        [dealsCell.switchControl setOn: self.filters.deals animated:YES];
        [dealsCell.switchControl addTarget:self action:@selector(dealsSwitchToggled:) forControlEvents:UIControlEventValueChanged];
        dealsCell.cellLabel.text = @"Deals";
        cell = dealsCell;

    }
    return cell;
    
    
}
- (void) showMore {
    self.showAllCategories = YES;
    [self.filterView reloadData];
}

- (void) showLess {
    self.showAllCategories = NO;
    [self.filterView reloadData];
}

- (BOOL) inArray: (NSMutableArray *)array item:(NSString *)item {
    for (NSString *string in array){
        if (string == item)
            return YES;
    }
    return NO;
}

- (void)popFromArray:(NSMutableArray *)array item:(NSString *)item {
    id toRemove;
    for (NSString * string in array){
        if (item == string){
            toRemove = string;
            break;
        }
    }
    [array removeObject:toRemove];
}
- (void)saveFilterSettingArray: (NSArray *)array withKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:array forKey:key];
    [defaults synchronize];
}

- (void)saveFilterSettingObject: (id)obj withKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}

- (void)saveFilterSettingInteger:(int)i withKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:i forKey:key];
    [defaults synchronize];
}

- (void)saveFilterSettingBOOL: (BOOL)b  withKey: (NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:b forKey:key];
    [defaults synchronize];
}

#pragma mark Setting Filters

- (void)dealsSwitchToggled:(id)sender {
    UISwitch *theSwitch = (UISwitch *)sender;
    if(theSwitch.on) {
        // switch turned on
        [self saveFilterSettingBOOL:YES withKey:@"deals"];
        self.filters.deals = YES;
    }
    else {
        // switch turned off
        [self saveFilterSettingBOOL:NO withKey:@"deals"];
        self.filters.deals = NO;
    }
}

- (void)setPriceFilter:(id)sender {
    UISegmentedControl *controlSegment = (UISegmentedControl *)sender;
    [self saveFilterSettingInteger:controlSegment.selectedSegmentIndex withKey:@"price_control_index"];
    self.filters.price = controlSegment.selectedSegmentIndex;
}

- (void)setSortByFilter:(id)sender{
    [self saveFilterSettingObject:sender withKey:@"sort"];
    //NSLog(@"sender sort: %@", sender);
    self.filters.sortBy = sender;
    
}

- (void)setDistanceFilter:(id)sender{
    [self saveFilterSettingObject:sender withKey:@"distance"];
    //NSLog(@"sender distance: %@", sender);
    self.filters.distance = sender;
}

- (void)setCategoryFilter{
    NSArray *array = [self.categoriesFilter copy];
    //NSLog(@"setting category filter array: %@", array);
    [self saveFilterSettingArray:array withKey:@"category"];
    self.filters.category = [self.categoriesFilter copy];
}

- (BOOL)isCategorySavedInFilteredSettings: (NSString *)category{
    //load saved defaults
    for (NSString *cat in self.filters.category){
        if (cat == category){
            return YES;
        }
    }
    
    return NO;
}

#pragma Mark View
- (void)viewWillAppear:(BOOL)animated {
    
    //load saved defaults
    self.filters = [[Filters alloc] init];
    //self.categoriesFilter = [[NSMutableArray alloc] init];
    self.categoriesFilter = self.filters.category;
    //based on filters select first row to show on distance
    [self swapWith:self.filters.distance];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    //saving tip default
    [self setCategoryFilter];
}

#pragma Mark Swapping
-(void)swapWith: (NSString *)selected{
    //swap spots in array to have selected option on top
    NSInteger row = 0;
    for (NSString *option in self.distance) {
        
        if ([option isEqualToString:selected]) {
            break;
        }else{
            row++;
        }
        
    }
    
    NSInteger zero = 0;
    NSMutableArray *swap = [NSMutableArray arrayWithArray:self.distance];
    [swap exchangeObjectAtIndex:zero withObjectAtIndex:row];
    self.distance = [swap mutableCopy];
}


@end
