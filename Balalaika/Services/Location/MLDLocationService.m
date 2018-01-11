//
//  MLDLocationService.m
//  Balalaika
//
//  Created by milording on 18/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "MLDLocationService.h"

@interface MLDLocationService()

@property  (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void (^completionHandler)(CLLocation *);

@end

@implementation MLDLocationService

#pragma mark - Lifecycle

-(instancetype)init
{
    if(self = [super init])
    {
        _locationManager = [CLLocationManager new];

        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [_locationManager requestWhenInUseAuthorization];

    }
    return self;
}

#pragma mark - Protocol Public Methods

- (void)getCurrentLocation:(void (^)(CLLocation *))completionHandler {
    self.completionHandler = completionHandler;
    [self startLocating];
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currentLocation = [locations firstObject];
    self.completionHandler(currentLocation);
    
    NSLog(@"Lat: %f Long: %f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    [self stopLocating];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}

#pragma mark - Private Methods

-(void)startLocating
{
    [self.locationManager startUpdatingLocation];
}

-(void)stopLocating
{
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}


@end
