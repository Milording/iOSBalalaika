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


@property (nonatomic, strong) id<ConnectionServiceProtocol> connectionService;
@property (nonatomic, copy) void (^completionHandler)(NSString *);


@end

@implementation BarService
objection_requires(@"connectionService")

-(instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.connectionService onRawPlaylistChanged:^(NSString *bar) {
            self.completionHandler(bar);
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
    self.completionHandler = completionHandler;
}


@end
