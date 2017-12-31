//
//  ConnectionServiceProtocol.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceProtocol

-(void)startDefaultPlaylist;
-(void)addPremiumSong:(NSString *)songId;
-(void)getActualPlaylist;

@required
-(void)onRawPlaylistChanged:(id)perform selector:(SEL)selector;

@end
