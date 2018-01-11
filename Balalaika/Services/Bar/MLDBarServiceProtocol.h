//
//  MLDBarServiceProtocol.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLDPlaylist;

@protocol MLDBarServiceProtocol <NSObject>

-(void)addPremiumSong:(NSString *)songId;
-(void)getActualPlaylist;
-(void)setDefaultPlaylist;

-(void)onPlaylistChanged:(void (^)(NSString *))completionHandler;
-(void)onCurrentPlaylistDidGet:(void (^)(NSString *))completionHandler;

@end
