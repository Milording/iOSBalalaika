//
//  SoundCloudServiceProtocol.h
//  Balalaika
//
//  Created by milording on 02/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Playlist;

@protocol StreamingServiceProtocol <NSObject>

-(void)getPopularPlaylist:(void (^)(Playlist *))completionHandler;

-(void)searchSong:(void (^)(Playlist *playlist))completionHandler query:(NSString *) query;

@end
