//
//  ObjectionModule.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "ObjectionModule.h"
#import "MLDBarService.h"
#import "MLDBarServiceProtocol.h"
#import "MLDBarLocationServiceProtocol.h"
#import "MLDBarLocationService.h"
#import "MLDConnectionService.h"
#import "MLDConnectionServiceProtocol.h"
#import "MLDLocationService.h"
#import "MLDLocationServiceProtocol.h"
#import "MLDStreamingService.h"
#import "MLDStreamingServiceProtocol.h"

@implementation ObjectionModule

-(void)configure
{
    // Base services
    [self bindClass:[MLDConnectionService class] toProtocol:@protocol(MLDConnectionServiceProtocol)];
    [self bindClass:[MLDLocationService class] toProtocol:@protocol(MLDLocationServiceProtocol)];
    [self bindClass:[MLDStreamingService class] toProtocol:@protocol(MLDStreamingServiceProtocol)];
    
    // High level services
    [self bindClass:[MLDBarService class] toProtocol:@protocol(MLDBarServiceProtocol)];
    [self bindClass:[MLDBarLocationService class] toProtocol:@protocol(MLDBarLocationServiceProtocol)];
}

@end
