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
#import "BarLocationService.h"

@interface LoginViewModel ()

@property (nonatomic, strong)BarService *barService;
@property (nonatomic, strong)BarLocationService *barLocationService;


@end

@implementation LoginViewModel

-(instancetype)initWithProtocol:(BarService *)barService locationService:(BarLocationService *)barLocationService
{
    if(self = [super init])
    {
        _barService = barService;
        _barLocationService = barLocationService;
        _connectionStatus = @"Checking location...";
        
        _barService.delegate = self;
        
        [self.barLocationService checkCurrentBarLocation:^(NSString *barTitle) {
            NSLog(@"%@",barTitle);
        }];
        //[self.barService setDefaultPlaylist];
    }
    return self;
}

-(void)startDefaultPlaylist
{
    [self.barService setDefaultPlaylist];
}

-(void)getCurrentBar
{
    self.isLoading = YES;
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.barService addPremiumSong:songId];
}

- (void)currentPlaylistDidChange:(NSString *)actualPlaylist { 
    self.currentPlaylist = actualPlaylist;
}

- (void)didLocationGet:(CLLocation *)location { 
    self.isLoading = NO;
}

@end
