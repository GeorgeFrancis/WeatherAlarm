//
//  LocationViewController.m
//  api weather
//
//  Created by George Francis on 08/10/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "LocationViewController.h"
//#import "WeatherViewController.h"

@interface LocationViewController ()

@end

@implementation LocationViewController

- (void)viewDidLoad {
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
//
//    self.saveLocationButton.titleLabel.font = [UIFont fontWithName:@"AGENTORANGE" size:12.0f];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    WeatherViewController *wvc = [segue destinationViewController];
    wvc.locationString = self.locationTextField.text;
    
    
    [[NSUserDefaults standardUserDefaults] setObject:wvc.locationString forKey:@"savedLocation"];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (IBAction)saveLocation:(id)sender {
    
//    WeatherViewController *MethodSave = [WeatherViewController new];
//    MethodSave = [[WeatherViewController alloc]init];
    
    
  //  self.MethodSave = [WeatherViewController new];
  //  [self.MethodSave saveLocation];
   
    //[WeatherViewController getWeatherForCity:@"london"];
    
   // NSString *savedLocationString = self.locationTextField.text;
  //  MethodSave = [WeatherViewController new];
  //  [MethodSave saveLocation];
  
    
 //   [self.WeatherMethodSave saveLocation];
    // [self getWeatherForCity:[NSString stringWithFormat:@"%@",self.locationString]];
    
//}
@end
