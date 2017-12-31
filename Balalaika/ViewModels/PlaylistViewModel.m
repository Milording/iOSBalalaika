//
//  PlaylistViewModel.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "PlaylistViewModel.h"
#import "BarServiceProtocol.h"
#import <Objection.h>

@interface PlaylistViewModel()

@property (nonatomic, strong) NSString *rawPlaylist;
@property id<BarServiceProtocol> barService;

@end

@implementation PlaylistViewModel
objection_requires(@"barService")

- (instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.barService onPlaylistChanged:^(NSString *response) {
            NSLog(@"%@",response);
        }];
    }
    return self;
}

-(void)playListDidGet:(NSString *)playlist
{
    NSLog(@"%@",playlist);
}

-(void)addPremiumSong
{
    [self.barService addPremiumSong:@"999912"];
}

@end
