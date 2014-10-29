//
//  alarmClockViewController.h
//  api weather
//
//  Created by George Francis on 03/09/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alarmClockViewController : UIViewController

//@property (strong, nonatomic) IBOutlet UIDatePicker *dateTimerPicker;

- (IBAction)setAlarm:(id)sender;
- (IBAction)cancelAlarm:(id)sender;

-(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate;

@end
