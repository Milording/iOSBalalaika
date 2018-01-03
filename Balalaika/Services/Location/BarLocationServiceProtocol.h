//
//  BarLocationServiceProtocol.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationService.h"
#import "Bar.h"

@protocol BarLocationServiceProtocol <NSObject>

-(void)getCurrentBarTitle:(void (^)(Bar *))completionHandler;

@end
