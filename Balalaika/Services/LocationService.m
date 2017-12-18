//
//  LocationService.m
//  Balalaika
//
//  Created by milording on 18/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "LocationService.h"

@interface LocationService()

@property  (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation LocationService 

-(instancetype)init
{
    if(self = [super init])
    {
        _locationManager = [CLLocationManager new];

        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];

        [_locationManager startUpdatingLocation];
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations lastObject];
    
    NSLog(@"Lat: %f Long: %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
}

-(void)startLocating
{
}

@end