//
//  SearchViewModel.h
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Playlist;

@interface SearchViewModel : NSObject

@property (nonatomic, strong) Playlist *popularPlaylist;
@property (nonatomic, strong) Playlist *searchResultsPlaylist;

@property (nonatomic, copy) NSString *searchQuery;

@end
