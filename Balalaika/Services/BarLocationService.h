//
//  BarLocationService.h
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LocationServiceProtocol.h"
#import "Bar.h"
#import "BarLocationServiceProtocol.h"
@class LocationService;

@interface BarLocationService : NSObject <BarLocationServiceProtocol>

-(void)getCurrentBarTitle:(void (^)(Bar *))completionHandler;

@end
