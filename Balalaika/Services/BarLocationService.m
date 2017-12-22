//
//  BarLocationService.m
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "BarLocationService.h"
#import "LocationService.h"

@interface BarLocationService()

@property (nonatomic, strong) NSMutableDictionary<CLLocation *, NSString *> *barSet;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, strong) LocationService *locationService;

@property (nonatomic, copy) void (^completionHandler)(NSString *);

@end

@implementation BarLocationService

-(instancetype)initWithServices:(LocationService *)locationService
{
    if(self == [super init])
    {
        self.locationService = locationService;
        self.locationService.delegate = self;
        
        [self initBarLocations];
    }
    return self;
}

-(void)initBarLocations
{
    // Sbergile Location
    double latitude = 37.332331;
    double longitude = -122.031219;
    CLLocation *sbergileLocation =  [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    [self.barSet setObject:@"Дорогая, я попал в Sbergile" forKey:sbergileLocation];
}

-(NSString *)checkBarFor:(CLLocation *)userLocation
{
    if(self.lastLocation)
    {
        for (CLLocation* location in self.barSet.allKeys)
        {
            CLLocationDegrees minLatitude =  location.coordinate.latitude-1;
            CLLocationDegrees maxLatitude = location.coordinate.latitude+1;
            
            CLLocationDegrees minLongitude = location.coordinate.longitude-1;
            CLLocationDegrees maxLongitude = location.coordinate.longitude+1;
            
            if((userLocation.coordinate.latitude > minLatitude || userLocation.coordinate.latitude < maxLatitude) &&
               (userLocation.coordinate.longitude > minLongitude || userLocation.coordinate.longitude < maxLongitude))
            {
                return self.barSet[location];
            }
        }
    }
    return nil;
}

-(void)checkCurrentBarLocation:(void (^)(NSString *))completionHandler
{
    self.completionHandler = completionHandler;
    
    [self.locationService startLocating];
}

- (void)didLocationGet:(CLLocation *)location {
    NSString *barTitle = [self checkBarFor:location];
    self.completionHandler(barTitle);
    
    [self.locationService stopLocating];
}

@end
