//
//  SearchViewModel.m
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Objection.h>
#import <ReactiveObjC.h>

#import "SearchViewModel.h"
#import "StreamingServiceProtocol.h"

@interface SearchViewModel()

@property id<StreamingServiceProtocol> streamingService;

@end

@implementation SearchViewModel
objection_requires(@"streamingService")

#pragma mark - Lifecycle

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.streamingService getPopularPlaylist:^(Playlist *playlist) {
            self.popularPlaylist = playlist;
        }];
        
//        [self.streamingService searchSong:^NSString *(Playlist *playlist) {
//            self.searchResultsPlaylist = playlist;
//        }];
        
        [RACObserve(self, self.searchQuery) subscribeNext:^(id x) {
            if(!self.searchQuery)
                return;
            [self.streamingService searchSong:^(Playlist *playlist) {
                self.searchResultsPlaylist = playlist;
            } query:self.searchQuery];
        }];
        
        
    }
    return self;
}




@end
