//
//  resturantTableViewCell.h
//  Yelp
//
//  Created by Tushar Bhushan on 6/22/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface resturantTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *resturantImage;
@property (weak, nonatomic) IBOutlet UILabel *resturantName;
@property (weak, nonatomic) IBOutlet UILabel *resturantAddress;
@property (weak, nonatomic) IBOutlet UIImageView *ratingsImage;
@property (weak, nonatomic) IBOutlet UILabel *reviewsLabel;

@end
