//
//  WeatherViewController.m
//  api weather
//
//  Created by George Francis on 29/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "WeatherViewController.h"
#import <RestKit/RestKit.h>
#import "DataModels.h"

@interface WeatherViewController (){
    
    NSArray *weatherObjects;
    NSMutableArray *weatherArray;
}

@end

@implementation WeatherViewController

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
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    
//    self.setAlarmButton.titleLabel.font = [UIFont fontWithName:@"AGENTORANGE" size:10.0f];
//    [self.weatherLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.weatherLabel.font.pointSize]];
//    [self.clockTimeLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.clockTimeLabel.font.pointSize]];
//    [self.dailyReminderLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.dailyReminderLabel.font.pointSize]];
//    [self.locationLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.locationLabel.font.pointSize]];
//    [self.highTempLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.highTempLabel.font.pointSize]];
//    [self.lowTempLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.lowTempLabel.font.pointSize]];
//    [self.currentTempLabel setFont:[UIFont fontWithName:@"AGENTORANGE" size:self.currentTempLabel.font.pointSize]];
   
    [self.dailyReminderTextField setHidden:YES];
    [super viewDidLoad];
    
    weatherArray = [[NSMutableArray alloc] init];
    weatherObjects = [[NSArray alloc]init];
    self.dateTimePicker.date = [NSDate date];
    [self updateTime];
    
    self.dailyReminderString = [[NSUserDefaults standardUserDefaults]objectForKey:@"dailyReminder"];
    self.dailyReminderLabel.text = [NSString stringWithFormat:@"%@",self.dailyReminderString];
  
    if ([self.dailyReminderString length] == 0) {
        
        self.dailyReminderLabel.text = @"";
        
    }
    
    NSString *savedLocationString = self.locationString;
    savedLocationString = [[NSUserDefaults standardUserDefaults]stringForKey:@"savedLocation"];

    if ([savedLocationString length] == 0) {
        
        LocationViewController *lvc = [self.storyboard instantiateViewControllerWithIdentifier:@"LocationVC"];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    
    else{
    
        [self getWeatherForCity:[NSString stringWithFormat:@"%@",savedLocationString]];
        self.locationLabel.text = savedLocationString;
            }
}

-(RKResponseDescriptor *)responseDescriptor
{
    RKObjectMapping* cloudMapping = [RKObjectMapping mappingForClass:[Clouds class]];
    [cloudMapping addAttributeMappingsFromArray:@[@"all"]];
    RKObjectMapping* coordMapping = [RKObjectMapping mappingForClass:[Coord class]];
    [coordMapping addAttributeMappingsFromArray:@[@"lon",@"lat"]];
    RKObjectMapping* weatherMapping = [RKObjectMapping mappingForClass:[Weather class]];
    [weatherMapping addAttributeMappingsFromArray:@[@"icon",@"main",@"weatherIdentifier"]];
    RKObjectMapping* mainMapping = [RKObjectMapping mappingForClass:[Main class]];
    [mainMapping addAttributeMappingsFromArray:@[@"temp",@"temp_min",@"temp_max",@"humidity",@"pressure"]];
    RKObjectMapping* weatherReportMapping = [RKObjectMapping mappingForClass:[WeatherReport class]];
    [weatherReportMapping addAttributeMappingsFromArray:@[@"name"]];
    
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"clouds" toKeyPath:@"clouds" withMapping:cloudMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord" toKeyPath:@"coord" withMapping:coordMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"weather" withMapping:weatherMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main" toKeyPath:@"main" withMapping:mainMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weatherIdentifier" toKeyPath:@"weatherIdentifier" withMapping:mainMapping]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:weatherReportMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return responseDescriptor;
}

-(void)getWeatherForCity:(NSString *)cityName
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@",cityName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[[self responseDescriptor]]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        //result = mappingResult.array[0];
        //weatherObjects = mappingResult.array;
        //[weatherArray addObject:weatherObjects];
        WeatherReport *reportForCity = mappingResult.array[0];
        [self updateLabel:reportForCity];
        
        
        RKLogInfo(@"Load collection of Weather: %@", mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

- (void)updateLabel:(WeatherReport *)city
{
    self.cityTemperature = [NSString stringWithFormat:@"The temperature in is %f\u00B0",city.main.temp - 273.15];
    self.currentTempLabel.text = [NSString stringWithFormat:@"%.0f\u00B0",city.main.temp - 273.15];
    self.lowTempLabel.text = [NSString stringWithFormat:@"%.0f\u00B0",city.main.temp_max - 273.15];
    self.highTempLabel.text = [NSString stringWithFormat:@"%.0f\u00B0",city.main.temp_min - 273.15];
    
    //NSString *weatherTemp = [NSString stringWithFormat:@"%.0f\u00B0",city.main.temp_max - 273.15];
    //[NSString stringWithFormat:@"%@",city.main];
    //int weatherValue = [weatherTemp intValue];
    
    Weather *weather = city.weather[0];
    
    NSString *weatherTypeString = weather.icon;
 
    if ([weatherTypeString  isEqualToString:(@"01d")]) {
       // self.weatherLabel.text = [NSString stringWithFormat:@"raining"];
        self.weatherConditionImage.image = [UIImage imageNamed:@"01d_clearSkyDay.png"];
    //    self.rainOrSunImage.image = [UIImage imageNamed:@"sunglasses.png"];
        self.weatherDescription = @"Clear Sky!!";
    }
    if ([weatherTypeString  isEqualToString:(@"02d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"02d_fewCloudsDay.png"];
        self.weatherDescription = @"A Few Clouds!!";
    }
    if ([weatherTypeString  isEqualToString:(@"03d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"03d_scatteredCloudsDay.png"];
        self.weatherDescription = @"Scattered Clouds!!";
    }
    if ([weatherTypeString  isEqualToString:(@"04d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"03d_scatteredCloudsDay.png"];
        self.weatherDescription = @"Cloudy!!";
    }
    if ([weatherTypeString  isEqualToString:(@"09d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"09d_showerRainDay.png"];
        self.weatherDescription = @"Light Rain!!";
    }
    if ([weatherTypeString  isEqualToString:(@"10d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"09d_showerRainDay.png"];
        self.weatherDescription = @"Rain!!";
    }
    if ([weatherTypeString  isEqualToString:(@"11d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"11d_thunderstormDay.png"];
        self.weatherDescription = @"Thunderstorm!!";
    }
    if ([weatherTypeString  isEqualToString:(@"13d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"13d_snowDay.png"];
        self.weatherDescription = @"Snowing!!";
    }
    if ([weatherTypeString  isEqualToString:(@"50d")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"50d_mist.png"];
        self.weatherDescription = @"Very Misty!!";
    }
    if ([weatherTypeString  isEqualToString:(@"01n")]) {
        // self.weatherLabel.text = [NSString stringWithFormat:@"raining"];
        self.weatherConditionImage.image = [UIImage imageNamed:@"01n_clearSkyNight.png"];
        self.weatherDescription = @"Clear Sky!!";
    }
    if ([weatherTypeString  isEqualToString:(@"02n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"02n_fewCloudsNight.png"];
        self.weatherDescription = @"A Few Clouds!!";
    }
    if ([weatherTypeString  isEqualToString:(@"03n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"03n_scatteredCloudsNight.png"];
        self.weatherDescription = @"Scattered Clouds!!";
    }
    if ([weatherTypeString  isEqualToString:(@"04n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"03n_scatteredCloudsNight.png"];
        self.weatherDescription = @"Cloudy!!";
    }
    if ([weatherTypeString  isEqualToString:(@"09n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"09n_showerRainNight.png"];
        self.weatherDescription = @"Light Rain!!";
    }
    if ([weatherTypeString  isEqualToString:(@"10n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"09n_showerRainNight.png"];
        self.weatherDescription = @"Rain!!";
    }
    if ([weatherTypeString  isEqualToString:(@"11n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"11n_thunderstormNight.png"];
        self.weatherDescription = @"Thunderstorm!!";
    }
    if ([weatherTypeString  isEqualToString:(@"13n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"13n_snowNight.png"];
        self.weatherDescription = @"Snowing!!";
    }
    if ([weatherTypeString  isEqualToString:(@"50n")]) {
        self.weatherConditionImage.image = [UIImage imageNamed:@"50d_mist.png"];
        self.weatherDescription = @"Very Misty!!";
    }

    self.weatherLabel.text = self.weatherDescription;
    
//    if (weatherValue > 22) {
//        self.weatherLabel.text = [NSString stringWithFormat:@"It's damn hot and %@",self.weatherDescription];
//    }
//    else if (weatherValue > 13)
//    {
//        self.weatherLabel.text = [NSString stringWithFormat:@"It's faily mild and %@",self.weatherDescription];
//    }
//    else
//    {
//        self.weatherLabel.text = [NSString stringWithFormat:@"It's Bloody Cold and %@",self.weatherDescription];
//    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)scheduleLocalNotificationWithDate:(NSDate *)fireDate{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.fireDate = fireDate;
    
    if ([self.dailyReminderString length] == 0) {
        notification.alertBody = [NSString stringWithFormat:@"Alarm"];
    }
    else{
        notification.alertBody = [NSString stringWithFormat:@"%@",self.dailyReminderString];
    }
    
    notification.alertAction = @"Check Weather";
    notification.soundName = @"newAlarm.mp3";
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

-(void)presentAlertMessage:(NSString *)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alarm Clock" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
}

-(void)updateTime{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    self.clockTimeLabel.text = [dateFormatter stringFromDate:[NSDate date]];
    
    [self performSelector:@selector(updateTime) withObject:self afterDelay:1.0];
}

- (IBAction)saveDailyReminder:(id)sender {
    
    if (!self.dailyReminderSet) {
        self.dailyReminderSet = YES;
        [self.saveDailyReminderButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.dailyReminderLabel setHidden:YES];
        [self.dailyReminderTextField setHidden:NO];
        [self.dailyReminderTextField becomeFirstResponder];
//        UIImage *buttonImage = [UIImage imageNamed:@"tickButton.png"];
//        [self.saveDailyReminderButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
    
    else if (self.dailyReminderSet){
        
        self.dailyReminderSet = NO;
        [self.saveDailyReminderButton setTitle:@"Change" forState:UIControlStateNormal];
        [self.dailyReminderTextField setHidden:YES];
        self.dailyReminderString = self.dailyReminderTextField.text;
        self.dailyReminderLabel.text = [NSString stringWithFormat:@"%@",self.dailyReminderString];
        [[NSUserDefaults standardUserDefaults]setObject:self.dailyReminderString forKey:@"dailyReminder"];
        [self.dailyReminderLabel setHidden:NO];
        [self.dailyReminderTextField resignFirstResponder];
//        UIImage *buttonImage = [UIImage imageNamed:@"refreshButton.png"];
//        [self.saveDailyReminderButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    }
}

- (IBAction)setAlarm:(id)sender {
    
    if (!self.alarmSet) {
        [self.setAlarmButton setTitle:@"Cancel Alarm" forState:UIControlStateNormal];
        self.alarmSet = YES;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.timeZone = [NSTimeZone defaultTimeZone];
        dateFormatter.timeStyle = NSDateFormatterShortStyle;
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        NSString *dateTimeString = [dateFormatter stringFromDate:self.dateTimePicker.date];
        [self scheduleLocalNotificationWithDate:self.dateTimePicker.date];
        [self presentAlertMessage:@"Alarm set"];
        NSLog(@"Alarm set button tapped %@",dateTimeString);
    }
    
    else if (self.alarmSet) {
        [self.setAlarmButton setTitle:@"Set Alarm" forState:UIControlStateNormal];
        self.alarmSet = NO;
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        NSLog(@"Alarm cancel button tapped");
        [self presentAlertMessage:@"Alarm cancelled"];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements

-(void)keyboardWillShow:(NSNotification *)notification{
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -105.0f;
        self.view.frame = f;
        
        self.view.backgroundColor = [UIColor blackColor];
        [self.weatherLabel setAlpha:0.1];
        [self.locationLabel setAlpha:0.1];
        [self.dateTimePicker setAlpha:0.1];
        [self.setAlarmButton setAlpha:0.1];
        [self.lowTempLabel setAlpha:0.1];
        [self.highTempLabel setAlpha:0.1];
        [self.currentTempLabel setAlpha:0.1];
        [self.dailyReminderLabel setAlpha:0.1];
        [self.weatherConditionImage setAlpha:0.1];
        [self.clockTimeLabel setAlpha:0.1];
        [self.transparentOverlay setAlpha:0.1];
        [self.saveDailyReminderButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
        
        [self.weatherLabel setAlpha:1.0];
        [self.locationLabel setAlpha:1.0];
        [self.dateTimePicker setAlpha:1.0];
        [self.setAlarmButton setAlpha:1.0];
        [self.lowTempLabel setAlpha:1.0];
        [self.highTempLabel setAlpha:1.0];
        [self.currentTempLabel setAlpha:1.0];
        [self.dailyReminderLabel setAlpha:1.0];
        [self.weatherConditionImage setAlpha:1.0];
        [self.clockTimeLabel setAlpha:1.0];
        [self.transparentOverlay setAlpha:1.0];
        [self.saveDailyReminderButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }];
}

@end
