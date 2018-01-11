//
//  SoundCloudServiceProtocol.h
//  Balalaika
//
//  Created by milording on 02/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLDPlaylist;

@protocol MLDStreamingServiceProtocol <NSObject>

-(void)getPopularPlaylist:(void (^)(MLDPlaylist *))completionHandler;

-(void)searchSong:(void (^)(MLDPlaylist *playlist))completionHandler query:(NSString *) query;

@end
