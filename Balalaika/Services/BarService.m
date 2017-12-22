//
//  BarService.m
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "BarService.h"
#import <SignalR.h>
#import "ConnectionService.h"

@interface BarService()

@property (nonatomic, strong) ConnectionService *connectionService;

@end

@implementation BarService

-(instancetype)initWithService:(ConnectionService *)connectionService
{
    if(self = [super init])
    {
        self.connectionService = connectionService;
        
        self.connectionService.delegate = self;
        
        //[self setDefaultPlaylist];
    }
    return self;
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.connectionService addPremiumSong:songId];
}

-(void)setDefaultPlaylist
{
    [self.connectionService startDefaultPlaylist];
    
}

- (void)rawPlaylistDidChange:(NSString *)playlistRawData {
    [self.delegate currentPlaylistDidChange:playlistRawData];
}

@end
