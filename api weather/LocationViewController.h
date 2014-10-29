//
//  LocationViewController.h
//  api weather
//
//  Created by George Francis on 08/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherViewController.h"
//#import "WeatherViewController.m"

//@class WeatherViewController;
@interface LocationViewController : UIViewController


//- (IBAction)saveLocation:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UIButton *saveLocationButton;

//@property (nonatomic,assign) WeatherViewController *MethodSave;

@end
