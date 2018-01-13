//
//  MLDBarServiceProtocol.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLDPlaylist;
@class MLDSong;

@protocol MLDBarServiceProtocol <NSObject>

-(void)addPremiumSong:(MLDSong *)songId;
-(void)getActualPlaylist;
-(void)setDefaultPlaylist;

-(void)onPlaylistChanged:(void (^)(MLDPlaylist *))completionHandler;
-(void)onCurrentPlaylistDidGet:(void (^)(MLDPlaylist *))completionHandler;

@end
