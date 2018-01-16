//
//  MLDBarLocationService.m
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "MLDBarLocationService.h"
#import "MLDLocationService.h"
#import "MLDBar.h"
#import <Objection.h>

@interface MLDBarLocationService()

@property (nonatomic, strong) NSMutableArray *barSet;
@property (nonatomic, strong) MLDLocationService *locationService;

@property (nonatomic, copy) void (^completionHandler)(MLDBar *);

@end

@implementation MLDBarLocationService
//objection_requires(@"locationService")

#pragma mark - Lifecycle

-(instancetype)init
{
    if(self == [super init])
    {
        _locationService = [[JSObjection defaultInjector]getObject:[MLDLocationService class]];
        
        [self initBarLocations];
    }
    return self;
}


#pragma mark - Public Methods

-(void)getCurrentBarTitle:(void (^)(MLDBar *))completionHandler
{
    self.completionHandler = completionHandler;
    
    [self.locationService getCurrentLocation:^(CLLocation *location) {
        MLDBar *bar = [self checkBarFor:location];
        self.completionHandler(bar);
    }];
}

#pragma mark - Private Methods

-(void)initBarLocations
{
    // Sbergile Location
    
    // TODO: Set the location of office
    double latitude = 37.332331;
    double longitude = -122.031219;
    CLLocation *sbergileLocation =  [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    self.barSet = [[NSMutableArray alloc]initWithCapacity:10];
    MLDBar *sbergile = [MLDBar new];
    sbergile.title =@"Дорогая, я попал в\nSbergile";
    sbergile.exactLocation = sbergileLocation;
    
    [self.barSet addObject:sbergile];
}

-(MLDBar *)checkBarFor:(CLLocation *)userLocation
{
    for (MLDBar *bar in self.barSet)
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

@end
