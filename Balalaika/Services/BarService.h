//
//  BarService.h
//  Balalaika
//
//  Created by milording on 15/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BarServiceProtocol.h"
#import "ConnectionServiceProtocol.h"
#import "ConnectionService.h"


@interface BarService : NSObject<ConnectionServiceProtocol>

@property (nonatomic, strong) id<BarServiceProtocol> delegate;

-(instancetype)initWithService:(ConnectionService *)connectionService;
-(void)addPremiumSong:(NSString *)songId;

-(void)setDefaultPlaylist;

@end