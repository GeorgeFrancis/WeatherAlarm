//
//  DetailViewController.m
//  api weather
//
//  Created by George Francis on 07/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "DetailViewController.h"
#import <RestKit/RestKit.h>
#import "DataModels.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WeatherReport *weatherO =(WeatherReport*)self.detailItem;
    NSString *mainDescription = [[weatherO.weather valueForKey:@"main"] componentsJoinedByString:@""];
    self.descriptionLabel.text = [NSString stringWithFormat:@"Condition: %@",mainDescription];
    self.coordLabel.text = [NSString stringWithFormat:@"Lon: %.0f   Lat: %.0f",weatherO.coord.lon,weatherO.coord.lat];
    self.minMaxTempLabel.text = [NSString stringWithFormat:@"MinTemp: %.0f°   MaxTemp: %.0f°",weatherO.main.temp_min - 273.15f,weatherO.main.temp_max - 273.15f];
    self.humidityPressureLabel.text = [NSString stringWithFormat:@"Humidity: %.2f%%   Pressure: %.2f",weatherO.main.humidity,weatherO.main.pressure];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
