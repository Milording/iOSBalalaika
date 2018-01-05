//
//  ObjectionModule.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "ObjectionModule.h"
#import "BarService.h"
#import "BarServiceProtocol.h"
#import "BarLocationServiceProtocol.h"
#import "BarLocationService.h"
#import "ConnectionService.h"
#import "ConnectionServiceProtocol.h"
#import "LocationService.h"
#import "LocationServiceProtocol.h"
#import "StreamingService.h"
#import "StreamingServiceProtocol.h"

@implementation ObjectionModule

-(void)configure
{
    // Base services
    [self bindClass:[ConnectionService class] toProtocol:@protocol(ConnectionServiceProtocol)];
    [self bindClass:[LocationService class] toProtocol:@protocol(LocationServiceProtocol)];
    [self bindClass:[StreamingService class] toProtocol:@protocol(StreamingServiceProtocol)];
    
    // High level services
    [self bindClass:[BarService class] toProtocol:@protocol(BarServiceProtocol)];
    [self bindClass:[BarLocationService class] toProtocol:@protocol(BarLocationServiceProtocol)];
}

@end
