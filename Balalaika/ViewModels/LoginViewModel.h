//
//  ViewController.h
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BarServiceProtocol.h"
@class BarService;
@class LocationService;

@interface LoginViewModel : NSObject<BarServiceProtocol>

-(instancetype)initWithProtocol:(BarService *)barService locationService:(LocationService *)locationService;
-(void)startDefaultPlaylist;
-(void)addPremiumSong:(NSString *)songId;

@property (nonatomic, strong) NSString *currentPlaylist;
@property (nonatomic, strong) NSString *connectionStatus;
@property (nonatomic) bool isLoading;

@end

