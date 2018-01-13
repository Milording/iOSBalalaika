//
//  MLDSearchViewModel.m
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Objection.h>
#import <ReactiveObjC.h>

#import "MLDSearchViewModel.h"
#import "MLDStreamingServiceProtocol.h"
#import "MLDBarServiceProtocol.h"

@interface MLDSearchViewModel()

@property id<MLDStreamingServiceProtocol> streamingService;
@property id<MLDBarServiceProtocol> barService;

@end

@implementation MLDSearchViewModel
objection_requires(@"streamingService", @"barService")

#pragma mark - Lifecycle

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.streamingService getPopularPlaylist:^(MLDPlaylist *playlist) {
            self.popularPlaylist = playlist;
        }];
        
        
        [RACObserve(self, searchQuery) subscribeNext:^(id x) {
            if(!self.searchQuery)
                return;
            [self.streamingService searchSong:^(MLDPlaylist *playlist) {
                self.searchResultsPlaylist = playlist;
            } query:self.searchQuery];
        }];
        
        
    }
    return self;
}

-(void)addPremiumSong:(MLDSong *)song
{
    [self.barService addPremiumSong:song];
}

@end
