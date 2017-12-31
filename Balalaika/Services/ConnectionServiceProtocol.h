//
//  ConnectionServiceProtocol.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceProtocol

@property (nonatomic, strong) id<ConnectionServiceProtocol> delegate;

-(void)startDefaultPlaylist;
-(void)addPremiumSong:(NSString *)songId;
-(void)getActualPlaylist;

@required
-(void)rawPlaylistDidChange:(NSString *)playlistRawData;
-(void)onRawPlaylistChanged:(id)perform selector:(SEL)selector;
-(void)onRawPlaylistHandler:(void (^)(NSString *))completionHandler;


@end
