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

-(void)setDefaultPlaylist
{
    [self.connectionService startDefaultPlaylist];
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.connectionService addPremiumSong:songId];
}

- (void)onPlaylistChanged:(void (^)(NSString *))completionHandler{
    self.playlistUpdatedHandler = completionHandler;
}

- (void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler {
    self.playlistDidGetHandler = completionHandler;
}

- (void)getActualPlaylist {
    [self.connectionService getActualPlaylist];
}





@end
