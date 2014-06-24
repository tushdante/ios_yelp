//
//  SearchViewController.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "SearchViewController.h"
#import "YelpClient.h"
#import "Search.h"
#import "Filters.h"
#import "resturantTableViewCell.h"
#import <AFNetworking/UIKit+AFNetworking.h>


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface SearchViewController ()

@property (nonatomic, strong) YelpClient *client;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBarField;
@property (nonatomic,strong) NSArray *searchResult;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterButton;
@property (weak, nonatomic) IBOutlet UITableView *resultTableView;


@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.resultTableView.dataSource = self;
    self.resultTableView.delegate = self;
    [self.resultTableView registerNib:[UINib nibWithNibName:@"resultTableViewCell" bundle:nil] forCellReuseIdentifier:@"ResultCell"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Yelp Search
- (void)yelpSearch
{
    // Perform a new search
    //self.searchTerm = @"Thai";
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm: @"Thai" success:^(AFHTTPRequestOperation *operation, id response)
     {
         //NSLog(@"sample response: %@", response);
         
         // response is a NSDictionary object
         NSArray *businesses = response[@"businesses"];
         
         if(self.searchResult == nil){
             
             self.searchResult = [[NSMutableArray alloc] init];
         }
         
         self.searchResult =  [Search loadInArray:businesses];
         [self.resultTableView reloadData];
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [error description]);
     }];
    
    
}

#pragma mark - Table view methods
//number of rows
- (int)resultTableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return the number of rows you want in this table view
    return self.searchResult.count;
}

- (UITableViewCell *)resultTableView:(UITableView *)restultTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"table view indexpath.row = %d", indexPath.row);
    resturantTableViewCell *cell = [restultTableView dequeueReusableCellWithIdentifier:@"ResultCell"];
    
    Search *b = [self.searchResult objectAtIndex:indexPath.row];
    
    cell.resturantName.text = b.name;
    cell.resturantAddress.text = b.address;
    //cell.categoriesLabel.text = b.categories;
    [cell.reviewsLabel setText:[NSString stringWithFormat:@"%@ Reviews", b.reviewCount]];
    
    //poster image
    NSString *posterThumbnail = b.imageURL;
    //Asynchronously load the image
    [cell.resturantImage setImageWithURL:[NSURL URLWithString:posterThumbnail]];
    
    //rating image
    NSString *ratingURL = b.ratingImageURL;
    //Asynchronously load the image
    [cell.ratingsImage setImageWithURL:[NSURL URLWithString:ratingURL]];
    
    return cell;
}




@end
