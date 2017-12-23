//
//  BarLocationService.m
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "BarLocationService.h"
#import "LocationService.h"
#import "Bar.h"

@interface BarLocationService()

@property (nonatomic, strong) NSMutableSet *barSet;
@property (nonatomic, strong) CLLocation *lastLocation;
@property (nonatomic, strong) LocationService *locationService;

@property (nonatomic, copy) void (^completionHandler)(Bar *);

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
    
    self.barSet = [[NSMutableSet alloc]initWithCapacity:10];
    Bar *sbergile = [[Bar alloc]init];
    sbergile.title =@"Дорогая, я попал в Sbergile";
    sbergile.exactLocation = sbergileLocation;
    
    [self.barSet addObject:sbergile];
    
}

-(Bar *)checkBarFor:(CLLocation *)userLocation
{
    for (Bar *bar in self.barSet)
    {
        CLLocationDegrees minLatitude =  bar.exactLocation.coordinate.latitude-1;
        CLLocationDegrees maxLatitude = bar.exactLocation.coordinate.latitude+1;
        
        CLLocationDegrees minLongitude = bar.exactLocation.coordinate.longitude-1;
        CLLocationDegrees maxLongitude = bar.exactLocation.coordinate.longitude+1;
        
        if((userLocation.coordinate.latitude > minLatitude || userLocation.coordinate.latitude < maxLatitude) &&
          (userLocation.coordinate.longitude > minLongitude || userLocation.coordinate.longitude < maxLongitude))
        {
            return bar;
        }
    }
    
    return nil;
}

-(void)getCurrentBarTitle:(void (^)(Bar *))completionHandler
{
    self.completionHandler = completionHandler;
    
    [self.locationService startLocating];
}

- (void)didLocationGet:(CLLocation *)location {
    Bar *bar = [self checkBarFor:location];
    self.completionHandler(bar);
    
    [self.locationService stopLocating];
}

@end
