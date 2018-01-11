//
//  MLDConnectionServiceProtocol.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MLDConnectionServiceProtocol

-(void)startDefaultPlaylist;
-(void)addPremiumSong:(NSString *)songId;
-(void)getActualPlaylist;

@required
-(void)onRawPlaylistChanged:(void (^)(NSString *))completionHandler;
-(void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler;

@end
