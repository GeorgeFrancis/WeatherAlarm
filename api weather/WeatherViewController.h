//
//  WeatherViewController.h
//  api weather
//
//  Created by George Francis on 29/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationViewController.h"

//#import "WeatherViewController.m"
#import "MasterViewController.h"

@interface WeatherViewController : UIViewController <UITextFieldDelegate>

@property BOOL locationSet;

@property NSString *cityTemperature;
@property NSString *dailyReminderString;
@property NSString *weatherDescription;

@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIDatePicker *dateTimePicker;
@property (strong, nonatomic) IBOutlet UIButton *setAlarmButton;
@property (strong, nonatomic) IBOutlet UILabel *lowTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *highTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (strong, nonatomic) IBOutlet UILabel *dailyReminderLabel;
@property (strong, nonatomic) IBOutlet UITextField *dailyReminderTextField;
@property (strong, nonatomic) IBOutlet UIButton *saveDailyReminderButton;
@property (strong, nonatomic) IBOutlet UIImageView *weatherConditionImage;
@property (strong, nonatomic) IBOutlet UIImageView *rainOrSunImage;
@property (strong, nonatomic) IBOutlet UILabel *clockTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *speechBubbleImageView;

- (IBAction)saveDailyReminder:(id)sender;
- (IBAction)setAlarm:(id)sender;

@property BOOL alarmSet;
@property BOOL dailyReminderSet;

@property (strong,nonatomic) NSString *locationString;

-(void)getWeatherForCity:(NSString *)cityName;

//-(void)saveLocation;



@end
