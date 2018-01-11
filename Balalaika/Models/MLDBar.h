//
//  MLDBar.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MLDBar : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) CLLocation *exactLocation;

@end
