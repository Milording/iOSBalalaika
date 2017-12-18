//
//  ViewController.m
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "LoginViewModel.h"
#import "BarService.h"
#import <SignalR.h>
#import "LocationService.h"

@interface LoginViewModel ()

@property (nonatomic, strong)BarService *barService;
@property (nonatomic, strong)LocationService *locationService;

@end

@implementation LoginViewModel

-(instancetype)initWithProtocol:(BarService *)barService locationService:(LocationService *)locationService
{
    if(self = [super init])
    {
        _barService = barService;
        _locationService = locationService;
        _connectionStatus = @"Checking location...";
        
        _barService.delegate = self;
        
        [self startLocationService];
        //[self.barService setDefaultPlaylist];
    }
    return self;
}

-(void)startDefaultPlaylist
{
    [self.barService setDefaultPlaylist];
}

-(void)startLocationService
{
    self.isLoading = YES;
    [self.locationService startLocating];
}

-(void)locationFound
{
    self.isLoading = NO;
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.barService addPremiumSong:songId];
}

- (void)currentPlaylistDidChange:(NSString *)actualPlaylist { 
    self.currentPlaylist = actualPlaylist;
}

@end
