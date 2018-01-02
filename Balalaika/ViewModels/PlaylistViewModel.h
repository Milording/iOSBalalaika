//
//  PlaylistViewModel.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaylistViewModel : NSObject

@property (nonatomic, strong) NSString *rawPlaylist;

-(void)addPremiumSong;

@end
