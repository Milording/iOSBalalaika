//
//  ConnectionServiceProtocol.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ConnectionServiceProtocol

@required
-(void)rawPlaylistDidChange:(NSString *)playlistRawData;

@end
