//
//  MLDPlaylist.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel.h>
#import "MLDSong.h"
#import "MLDBarServiceProtocol.h"

@interface MLDPlaylist : JSONModel

@property (nonatomic, retain) NSMutableArray<MLDSong *><MLDSong> *songList;

@end
