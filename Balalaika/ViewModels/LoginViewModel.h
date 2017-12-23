//
//  ViewController.h
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarLocationService.h"
@class BarService;
@class LocationService;

@interface LoginViewModel : NSObject

//-(instancetype)initWithProtocol:(BarLocationService *)barLocationService;

@property (nonatomic, copy) NSString *barTitle;
@property (nonatomic, copy) NSString *currentPlaylist;
@property (nonatomic, copy) NSString *connectionStatus;
@property (nonatomic, strong) NSNumber *isLoading;



@end

