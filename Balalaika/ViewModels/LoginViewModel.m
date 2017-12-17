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

@interface LoginViewModel ()

@property (nonatomic, strong)BarService *barService;

@end

@implementation LoginViewModel

-(instancetype)initWithProtocol:(BarService *)barService
{
    if(self = [super init])
    {
        _barService = barService;
        
        self.barService.delegate = self;
        //[self.barService setDefaultPlaylist];
    }
    return self;
}

-(void)startDefaultPlaylist
{
    [self.barService setDefaultPlaylist];
}


-(void)addPremiumSong:(NSString *)songId
{
    [self.barService addPremiumSong:songId];
}

- (void)currentPlaylistDidChange:(NSString *)actualPlaylist { 
    self.currentPlaylist = actualPlaylist;
}

@end
