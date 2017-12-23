//
//  BarServiceProtocol.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Playlist.h"

@protocol BarServiceProtocol <NSObject>

@required

-(void)currentPlaylistDidChange:(NSString *)actualPlaylist;

@end
