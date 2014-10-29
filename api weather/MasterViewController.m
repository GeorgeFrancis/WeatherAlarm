//
//  MasterViewController.m
//  api weather
//
//  Created by George Francis on 07/08/2014.
//  Copyright (c) 2014 GeorgeFrancis. All rights reserved.
//

#import "MasterViewController.h"
//#import "DetailViewController.h"
#import <RestKit/RestKit.h>
#import "DataModels.h"
//#import "Constants.h"

@interface MasterViewController (){
    
    NSArray *weatherObjects;
    NSMutableArray *weatherArray;
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    weatherArray = [[NSMutableArray alloc] init];
//    [self getWeatherForCity:@"London"];
//    [self getWeatherForCity:@"Luton"];
//    [self getWeatherForCity:@"Manchester"];
//    [self getWeatherForCity:@"Birmingham"];
}

-(RKResponseDescriptor *)responseDescriptor
{
    RKObjectMapping* cloudMapping = [RKObjectMapping mappingForClass:[Clouds class]];
    [cloudMapping addAttributeMappingsFromArray:@[@"all"]];
    RKObjectMapping* coordMapping = [RKObjectMapping mappingForClass:[Coord class]];
    [coordMapping addAttributeMappingsFromArray:@[@"lon",@"lat"]];
    RKObjectMapping* weatherMapping = [RKObjectMapping mappingForClass:[Weather class]];
    [weatherMapping addAttributeMappingsFromArray:@[@"icon",@"main"]];
    RKObjectMapping* mainMapping = [RKObjectMapping mappingForClass:[Main class]];
    [mainMapping addAttributeMappingsFromArray:@[@"temp",@"temp_min",@"temp_max",@"humidity",@"pressure"]];
    RKObjectMapping* weatherReportMapping = [RKObjectMapping mappingForClass:[WeatherReport class]];
    [weatherReportMapping addAttributeMappingsFromArray:@[@"name"]];
    
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"clouds" toKeyPath:@"clouds" withMapping:cloudMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"coord" toKeyPath:@"coord" withMapping:coordMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"weather" toKeyPath:@"weather" withMapping:weatherMapping]];
    [weatherReportMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"main" toKeyPath:@"main" withMapping:mainMapping]];
    
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:weatherReportMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return responseDescriptor;
}

-(void)getWeatherForCity:(NSString *)cityName
{    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@",cityName]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[[self responseDescriptor]]];
    
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {

        weatherObjects = mappingResult.array;
        [weatherArray addObject:weatherObjects];
        [self.tableView reloadData];
   
        RKLogInfo(@"Load collection of Weather: %@", mappingResult.array);
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    
    [objectRequestOperation start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return weatherArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
   
    NSMutableArray *weatherarray = weatherArray[indexPath.row];
    WeatherReport *weatherO = weatherarray[0];
    
    NSString *iconCode = [[weatherO.weather valueForKey:@"icon"] componentsJoinedByString:@""];
    NSString *imageUrlString = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png",iconCode];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",weatherO.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Temp: %.0f",weatherO.main.temp];
    cell.imageView.image = [UIImage imageWithData:data];
    
    return cell;
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSMutableArray *weatherarray = weatherArray[indexPath.row];
//        WeatherReport *weatherO = weatherarray[0];
//        [[segue destinationViewController] setDetailItem:weatherO];
//    }
//}

@end
