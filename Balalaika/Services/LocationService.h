//
//  LocationService.h
//  Balalaika
//
//  Created by milording on 18/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationService : NSObject <CLLocationManagerDelegate>

-(void)startLocating;

@end
