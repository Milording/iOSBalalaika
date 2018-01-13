//
//  MLDSearchViewModel.h
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLDPlaylist;
@class MLDSong;

@interface MLDSearchViewModel : NSObject

@property (nonatomic, strong) MLDPlaylist *popularPlaylist;
@property (nonatomic, strong) MLDPlaylist *searchResultsPlaylist;

@property (nonatomic, copy) NSString *searchQuery;

-(void)addPremiumSong:(MLDSong *)song;

@end
