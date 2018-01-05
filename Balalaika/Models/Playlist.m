//
//  Playlist.m
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "Playlist.h"

@implementation Playlist

-(instancetype)init
{
    if(self == [super init])
    {
        self.songList = [NSMutableArray new];
    }
    return self;
    
    
}
@end
