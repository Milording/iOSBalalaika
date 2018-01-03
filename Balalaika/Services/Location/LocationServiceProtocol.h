//
//  LocationServiceProtocol.h
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@protocol LocationServiceProtocol <NSObject>

-(void)getCurrentLocation:(void (^)(CLLocation *))completionHandler;

@end
