//
//  ConnectionService.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SignalR.h>
#import "ConnectionServiceProtocol.h"

@interface ConnectionService : NSObject

@property (nonatomic, strong) id<ConnectionServiceProtocol> delegate;
//
//- (void)startDefaultPlaylist;
//-(void)addPremiumSong:(NSString *)songId;
//-(void)getActualPlaylist;

@end
