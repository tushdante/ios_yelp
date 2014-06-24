//
//  Filters.m
//  Yelp
//
//  Created by Tushar Bhushan on 6/23/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "Filters.h"

@implementation Filters
- (instancetype)init{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [self initWithSavedFilters:defaults];
}

-(id)initWithSavedFilters: (NSUserDefaults *)defaults{
    
    if (self = [super init]) {
        //price
        int priceControlIndex = [defaults integerForKey:@"price_control_index"];
        if(!priceControlIndex){
            self.price = 0; //lowest price
        }else{
            self.price = priceControlIndex;
        }
        NSLog(@"init filters called, priceControlIndex is: %d", self.price);
        
        //category
        NSMutableArray *cat = [[defaults arrayForKey:@"category"] mutableCopy];
        if(cat == nil){
            self.category = [[NSMutableArray alloc] init];
        }else{
            self.category = cat;
        }
        NSLog(@"init filters called, categories is: %@", [defaults arrayForKey:@"category"]);
        
        //sort by
        NSString *sort = [defaults stringForKey:@"sort"];
        if (!sort){
            self.sortBy = @"Best Match";
        }else{
            self.sortBy = sort;
        }
        NSLog(@"sort set on init: %@", self.sortBy);
        
        //distance
        NSString *dist = [defaults stringForKey:@"distance"];
        if (!dist){
            self.distance = @"Auto";
        }else{
            self.distance = dist;
        }
        NSLog(@"distance set on init: %@", self.distance);
        
        //deals
        BOOL d = [defaults boolForKey:@"deals"];
        if(!d){
            self.deals = NO;
        }else{
            self.deals = &(d);
        }
        
        
        //set categories
        self.categories = @[
                               @{@"name": @"American (New)", @"value": @"newamerican"},
                               @{@"name": @"American (Traditional)", @"value": @"tradamerican"},
                               @{@"name": @"Argentine", @"value": @"argentine"},
                               @{@"name": @"Asian Fusion", @"value": @"asianfusion"},
                               @{@"name": @"Australian", @"value": @"australian"},
                               @{@"name": @"Austrian", @"value": @"austrian"},
                               @{@"name": @"Beer Garden", @"value": @"beergarden"},
                               @{@"name": @"Belgian", @"value": @"belgian"},
                               @{@"name": @"Brazilian", @"value": @"brazilian"},
                               @{@"name": @"Breakfast & Brunch", @"value": @"breakfast_brunch"},
                               @{@"name": @"Buffets", @"value": @"buffets"},
                               @{@"name": @"Burgers", @"value": @"burgers"},
                               @{@"name": @"Burmese", @"value": @"burmese"},
                               @{@"name": @"Cafes", @"value": @"cafes"},
                               @{@"name": @"Cajun/Creole", @"value": @"cajun"},
                               @{@"name": @"Canadian", @"value": @"newcanadian"},
                               @{@"name": @"Chinese", @"value": @"chinese"},
                               @{@"name": @"Cantonese", @"value": @"cantonese"},
                               @{@"name": @"Dim Sum", @"value": @"dimsum"},
                               @{@"name": @"Cuban", @"value": @"cuban"},
                               @{@"name": @"Diners", @"value": @"diners"},
                               @{@"name": @"Dumplings", @"value": @"dumplings"},
                               @{@"name": @"Ethiopian", @"value": @"ethiopian"},
                               @{@"name": @"Fast Food", @"value": @"hotdogs"},
                               @{@"name": @"French", @"value": @"french"},
                               @{@"name": @"German", @"value": @"german"},
                               @{@"name": @"Greek", @"value": @"greek"},
                               @{@"name": @"Indian", @"value": @"indpak"},
                               @{@"name": @"Indonesian", @"value": @"indonesian"},
                               @{@"name": @"Irish", @"value": @"irish"},
                               @{@"name": @"Italian", @"value": @"italian"},
                               @{@"name": @"Japanese", @"value": @"japanese"},
                               @{@"name": @"Jewish", @"value": @"jewish"},
                               @{@"name": @"Korean", @"value": @"korean"},
                               @{@"name": @"Venezuelan", @"value": @"venezuelan"},
                               @{@"name": @"Malaysian", @"value": @"malaysian"},
                               @{@"name": @"Pizza", @"value": @"pizza"},
                               @{@"name": @"Russian", @"value": @"russian"},
                               @{@"name": @"Salad", @"value": @"salad"},
                               @{@"name": @"Scandinavian", @"value": @"scandinavian"},
                               @{@"name": @"Seafood", @"value": @"seafood"},
                               @{@"name": @"Turkish", @"value": @"turkish"},
                               @{@"name": @"Vegan", @"value": @"vegan"},
                               @{@"name": @"Vegetarian", @"value": @"vegetarian"},
                               @{@"name": @"Vietnamese", @"value": @"vietnamese"}
                               ];
        self.distanceConversions = @{@"Auto": @"", @"0.5 miles" : @"804", @"1 mile":@"1609", @"5 miles":@"8046"};
        self.sortCodes = @{ @"Best Match": @"0", @"Distance": @"1", @"Highest Rated": @"2" };
    }
    return self;
}

@end
