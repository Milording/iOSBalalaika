//
//  MLDPlaylistViewModel.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "MLDPlaylistViewModel.h"
#import "MLDBarServiceProtocol.h"
#import "MLDStreamingServiceProtocol.h"
#import <Objection.h>

@interface MLDPlaylistViewModel()

@property id<MLDBarServiceProtocol> barService;
@property id<MLDStreamingServiceProtocol> streamingService;

@end

@implementation MLDPlaylistViewModel
objection_requires(@"barService", @"streamingService")

#pragma mark - Lifecycle

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.streamingService getPopularPlaylist:^(MLDPlaylist *playlist) {
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