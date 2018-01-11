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

@interface MLDSearchViewModel()

@property id<MLDStreamingServiceProtocol> streamingService;

@end

@implementation MLDSearchViewModel
objection_requires(@"streamingService")

#pragma mark - Lifecycle

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.streamingService getPopularPlaylist:^(MLDPlaylist *playlist) {
            self.popularPlaylist = playlist;
        }];
        
//        [self.streamingService searchSong:^NSString *(MLDPlaylist *playlist) {
//            self.searchResultsPlaylist = playlist;
//        }];
        
        [RACObserve(self, self.searchQuery) subscribeNext:^(id x) {
            if(!self.searchQuery)
                return;
            [self.streamingService searchSong:^(MLDPlaylist *playlist) {
                self.searchResultsPlaylist = playlist;
            } query:self.searchQuery];
        }];
        
        
    }
    return self;
}




@end
