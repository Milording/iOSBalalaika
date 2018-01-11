//
//  MLDPlaylist.m
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "MLDPlaylist.h"

@implementation MLDPlaylist

-(instancetype)init
{
    if(self == [super init])
    {
        _songList = [NSMutableArray new];
    }
    return self;
    
    
}
@end
