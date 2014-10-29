//
//  DetailViewController.h
//  api weather
//
//  Created by George Francis on 07/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *minMaxTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *humidityPressureLabel;
@property (strong, nonatomic) IBOutlet UILabel *coordLabel;

@end
