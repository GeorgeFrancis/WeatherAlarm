//
//  alarmClockViewController.m
//  api weather
//
//  Created by George Francis on 03/09/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "alarmClockViewController.h"

@interface alarmClockViewController ()

@end

@implementation alarmClockViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.dateTimerPicker.date = [NSDate date];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    notification.fireDate = fireDate;
    notification.alertBody = @"Get up";
    notification.soundName = @"alarmSoundFile.mp3";
    [self presentAlertMessage:@"Get Up"];
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

-(void)presentAlertMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alarm Clock" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
}

- (IBAction)setAlarm:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    
    NSString *dateTimeString = [dateFormatter stringFromDate:self.dateTimerPicker.date];
    
    [self scheduleLocalNotificationWithDate:self.dateTimerPicker.date];
    
    [self presentAlertMessage:@"Alarm set"];
    
    NSLog(@"Alarm set button tapped %@",dateTimeString);
    
}


- (IBAction)cancelAlarm:(id)sender {
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    NSLog(@"Alarm cancel button tapped");
    
}
@end
