//
//  MLDBarService.m
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <SignalR.h>
#import <Objection.h>
#import <JSONModel.h>

#import "MLDBarService.h"
#import "MLDConnectionServiceProtocol.h"
#import "MLDConnectionService.h"
#import "MLDSong.h"
#import "MLDPlaylist.h"

@interface MLDBarService()

@property (nonatomic, strong) id<MLDConnectionServiceProtocol> connectionService;

@property (nonatomic, copy) void (^playlistUpdatedHandler)(MLDPlaylist *);
@property (nonatomic, copy) void (^playlistDidGetHandler)(NSString *);

@end

@implementation MLDBarService
//objection_requires(@"connectionService")

#pragma mark - Lifecycle

-(instancetype)init
{
    if(self = [super init])
    {
        _connectionService = [[JSObjection defaultInjector]getObject:[MLDConnectionService class]];
        
        [self.connectionService onRawPlaylistChanged:^(NSString *rawPlaylist) {
            NSError *error;
            MLDPlaylist *playlist = [[MLDPlaylist alloc]initWithString:rawPlaylist error:&error];
            self.playlistUpdatedHandler(playlist);
        }];
        
        [self.connectionService onCurrentPlaylistDidGet:^(NSString *currentPlaylist) {
            _playlistDidGetHandler(currentPlaylist);
        }];
        
    }
    return self;
}

#pragma mark - Protocol Public Methods

-(void)addPremiumSong:(MLDSong *)songId
{
    NSString *jsonString = [songId toJSONString];
    
    [self.connectionService addPremiumSong:jsonString];
}

- (void)getActualPlaylist {
    [self.connectionService getActualPlaylist];
}

-(void)setDefaultPlaylist
{
    [self.connectionService startDefaultPlaylist];
}

#pragma mark - Protocol Completion Methods

- (void)onPlaylistChanged:(void (^)(MLDPlaylist *))completionHandler{
    self.playlistUpdatedHandler = completionHandler;
}

- (void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler {
    self.playlistDidGetHandler = completionHandler;
}

#pragma mark - Private Methods

-(MLDSong *)deserializeSong:(NSDictionary *)rawData
{
    MLDSong *song = [MLDSong new];
    
    song.duration = [rawData[@"duration"] integerValue];
    
    NSString *artistAndSong = rawData[@"title"];
    if([artistAndSong containsString:@" - "])
    {
        NSArray *titleArray = [artistAndSong componentsSeparatedByString:@" - "];
        song.artist = titleArray[0];
        song.title = titleArray[1];
    }
    else
    {
        song.title = rawData[@"title"];
        song.artist = rawData[@"user"][@"username"];
    }
    
    song.thumb = rawData[@"thumb"];
    
    return song;
}
@end
