//
//  ConnectionService.m
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "ConnectionService.h"


@interface ConnectionService()

@property (nonatomic, strong) SRHubConnection *hub;
@property (nonatomic, strong) SRHubProxy *chat;

@property (nonatomic, strong) void (^playlistDidGetHandler)(NSString *);
@property (nonatomic, copy) void (^playlistUpdatedHandler)(NSString *);

@end

@implementation ConnectionService

-(instancetype)init
{
    if(self = [super init])
    {
        _hub = [SRHubConnection connectionWithURLString:@"http://balalaikaalpha.azurewebsites.net/"];
        _chat = [_hub createHubProxy:@"BarHub"];
        
        //[_chat on:@"playlistUpdated" perform:self selector:@selector(playlistUpdated:)];
        [self.chat on:@"playlistUpdated" perform:self selector:@selector(playlistUpdated:)];
        
        [_hub start];
    }
    return self;
}

-(void)playlistUpdated:(NSString *)response
{
    self.playlistUpdatedHandler(response);
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.chat invoke:@"AddPremiumSong" withArgs:@[songId] completionHandler:nil];
}
              
-(void)getActualPlaylist
{
    [self.chat invoke:@"GetActualPlaylist" withArgs:[NSArray new] completionHandler:^(id response, NSError *error) {
        self.playlistDidGetHandler(response);
    }];
}

- (void)startDefaultPlaylist {
    [self.chat invoke:@"StartDefaultPlaylist" withArgs:[NSArray new] completionHandler:^(id response, NSError *error) {
        NSLog(@"Default playlist has been set");
    }];
}

- (void)onRawPlaylistChanged:(void (^)(NSString *))completionHandler {
    self.playlistUpdatedHandler = completionHandler;
    
}

-(void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler
{
    self.playlistDidGetHandler = completionHandler;
}

@end
