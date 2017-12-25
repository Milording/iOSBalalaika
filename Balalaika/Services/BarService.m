//
//  BarService.m
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "BarService.h"
#import <SignalR.h>
#import <Objection.h>
#import "ConnectionServiceProtocol.h"

@interface BarService()

@property id target;
@property SEL playlistChangedSelector;

@property (nonatomic, strong) id<ConnectionServiceProtocol> connectionService;

@end

@implementation BarService
objection_requires(@"connectionService")

-(instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.connectionService onRawPlaylistChanged:self selector:@selector(rawPlaylistDidChange:)];
        
    }
    return self;
}

-(void)setDefaultPlaylist
{
    [self.connectionService startDefaultPlaylist];
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.connectionService addPremiumSong:songId];
}

- (void)onPlaylistChanged:(id)target selector:(SEL)selector {
    self.target = target;
    self.playlistChangedSelector = selector;
}

- (void)rawPlaylistDidChange:(NSString *)playlistRawData
{
    [self.target performSelector:self.playlistChangedSelector withObject:playlistRawData];
}


@end
