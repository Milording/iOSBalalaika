//
//  SoundCloudService.m
//  Balalaika
//
//  Created by milording on 02/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import "StreamingService.h"
#import "Song.h"
#import "Playlist.h"

@implementation StreamingService

-(NSURLSession *)getUrlSession
{
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
                        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                        session = [NSURLSession sessionWithConfiguration:configuration];
    });
    
    return session;
}

- (void)getPopularPlaylist:(void (^)(Playlist *))completionHandler {
    
    Playlist *playlist = [Playlist new];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:@"https://api-v2.hearthis.at/feed/?page=1&count=5&duration=3"]];
    
    NSURLSessionDataTask *task = [[self getUrlSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *jsonError;
            NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            for(NSDictionary *item in parsedJSONArray)
            {
                Song *song = [Song new];
                
                song.duration = [item[@"duration"] integerValue];
                
                NSString *artistAndSong = item[@"title"];
                if([artistAndSong containsString:@" - "])
                {
                    NSArray *titleArray = [artistAndSong componentsSeparatedByString:@" - "];
                    song.artist = titleArray[0];
                    song.title = titleArray[1];
                }
                else
                {
                    song.title = item[@"title"];
                    song.artist = item[@"user"][@"username"];
                }
                
                song.thumb = item[@"thumb"];
                
                [playlist.songList addObject:song];
                NSLog(@"Item: %@", item[@"title"]);
            }
            
            completionHandler(playlist);
        });
    }];
    
    [task resume];
}

@end
