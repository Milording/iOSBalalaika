//
//  PlaylistViewModel.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "PlaylistViewModel.h"
#import <Objection.h>
#import "BarServiceProtocol.h"

@interface PlaylistViewModel()

@property (nonatomic, strong) NSString *rawPlaylist;
@property id<BarServiceProtocol> barService;

@end

@implementation PlaylistViewModel
objection_requires(@"barService")

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self.barService onPlaylistChanged:self selector:@selector(playListDidGet)];
    }
    return self;
}

-(void)playListDidGet:(NSString *)playlist
{
    NSLog(@"%@",playlist);
}

@end
