//
//  PlaylistViewModel.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "PlaylistViewModel.h"
#import "BarServiceProtocol.h"
#import "StreamingServiceProtocol.h"
#import <Objection.h>

@interface PlaylistViewModel()

@property id<BarServiceProtocol> barService;
@property id<StreamingServiceProtocol> streamingService;

@end

@implementation PlaylistViewModel
objection_requires(@"barService", @"streamingService")

#pragma mark - Lifecycle

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.streamingService getPopularPlaylist:^(Playlist *playlist) {
            self.popularPlaylist = playlist;
        }];
        
        [self.barService onPlaylistChanged:^(NSString *response) {
            self.rawPlaylist = response;
        }];
        [self.barService onCurrentPlaylistDidGet:^(NSString *response) {
            self.rawPlaylist = response;
        }];
    }
    return self;
}

#pragma mark - Private Methods

-(void)playListDidGet:(NSString *)playlist
{
    NSLog(@"%@",playlist);
}

@end
