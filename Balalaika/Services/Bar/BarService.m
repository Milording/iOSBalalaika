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
#include "ConnectionService.h"

@interface BarService()

@property (nonatomic, strong) id<ConnectionServiceProtocol> connectionService;

@property (nonatomic, copy) void (^playlistUpdatedHandler)(NSString *);
@property (nonatomic, copy) void (^playlistDidGetHandler)(NSString *);

@end

@implementation BarService
//objection_requires(@"connectionService")

#pragma mark - Lifecycle

-(instancetype)init
{
    if(self = [super init])
    {
        _connectionService = [[JSObjection defaultInjector]getObject:[ConnectionService class]];
        
        [self.connectionService onRawPlaylistChanged:^(NSString *rawPlaylist) {
            self.playlistUpdatedHandler(rawPlaylist);
        }];
        [self.connectionService onCurrentPlaylistDidGet:^(NSString *currentPlaylist) {
            self.playlistDidGetHandler(currentPlaylist);
        }];
        
    }
    return self;
}

#pragma mark - Protocol Public Methods

-(void)addPremiumSong:(NSString *)songId
{
    [self.connectionService addPremiumSong:songId];
}

- (void)getActualPlaylist {
    [self.connectionService getActualPlaylist];
}

-(void)setDefaultPlaylist
{
    [self.connectionService startDefaultPlaylist];
}

#pragma mark - Protocol Completion Methods

- (void)onPlaylistChanged:(void (^)(NSString *))completionHandler{
    self.playlistUpdatedHandler = completionHandler;
}

- (void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler {
    self.playlistDidGetHandler = completionHandler;
}


@end
