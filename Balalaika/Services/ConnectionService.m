//
//  ConnectionService.m
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "ConnectionService.h"


@interface ConnectionService()

@property (nonatomic, strong) id target;
@property SEL rawPlaylistChangedSelector;

@property (nonatomic, strong) SRHubConnection *hub;
@property (nonatomic, strong) SRHubProxy *chat;

-(void)onRawPlaylistHandler:(void (^)(NSString *))completionHandler;

@end

@implementation ConnectionService

-(instancetype)init
{
    if(self = [super init])
    {
        _hub = [SRHubConnection connectionWithURLString:@"http://balalaikaalpha.azurewebsites.net/signalr"];
        _chat = [_hub createHubProxy:@"BarHub"];
        
        [_chat on:@"playlistUpdated" perform:self selector:@selector(playlistUpdated:)];
        
        [self startDefaultPlaylist];
        [self addPremiumSong:@"11"];
        
        [_hub start];
        
    }
    return self;
}

-(void)playlistUpdated:(NSString *)response
{
    [self.target performSelector:self.rawPlaylistChangedSelector withObject:response];
}

-(void)addPremiumSong:(NSString *)songId
{
    [self.chat invoke:@"AddPremiumSong" withArgs:@[songId] completionHandler:nil];
}
              
-(void)getActualPlaylist
{
    [self.chat invoke:@"GetActualPlaylist" withArgs:[NSArray new] completionHandler:^(id response, NSError *error) {
        
    }];
}

- (void)startDefaultPlaylist {
    [self.chat invoke:@"StartDefaultPlaylist" withArgs:[NSArray new] completionHandler:^(id response, NSError *error) {
        NSLog(@"Default playlist has been set");
    }];
}

- (void)onRawPlaylistChanged:(id)perform selector:(SEL)selector {
    self.target = perform;
    self.rawPlaylistChangedSelector = selector;
}


@end
