//
//  MLDSong.h
//  Balalaika
//
//  Created by milording on 16/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MLDSong : NSObject

@property (nonatomic, copy) NSString *songId;
@property (nonatomic, copy) NSString *artist;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic) NSInteger duration;

@end
