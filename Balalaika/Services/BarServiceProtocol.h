//
//  BarServiceProtocol.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Playlist.h"
#import "ConnectionService.h"

@protocol BarServiceProtocol <NSObject>

-(void)onPlaylistChanged:(id)perform selector:(SEL)selector;

-(void)addPremiumSong:(NSString *)songId;

-(void)setDefaultPlaylist;

@end
