//
//  MLDBarLocationService.h
//  Balalaika
//
//  Created by milording on 19/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MLDLocationServiceProtocol.h"
#import "MLDBar.h"
#import "MLDBarLocationServiceProtocol.h"
@class MLDLocationService;

@interface MLDBarLocationService : NSObject <MLDBarLocationServiceProtocol>

//TODO: Check for reason
-(void)getCurrentBarTitle:(void (^)(MLDBar *))completionHandler;

@end
