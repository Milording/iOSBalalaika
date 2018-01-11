//
//  MLDPlaylistViewModel.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MLDPlaylist;

@interface MLDPlaylistViewModel : NSObject

@property (nonatomic, strong) NSString *rawPlaylist;
@property (nonatomic, strong) MLDPlaylist *popularPlaylist;

@end
