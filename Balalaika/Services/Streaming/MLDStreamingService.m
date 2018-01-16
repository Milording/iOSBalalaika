//
//  SoundCloudService.m
//  Balalaika
//
//  Created by milording on 02/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import "MLDStreamingService.h"
#import "MLDSong.h"
#import "MLDPlaylist.h"

@implementation MLDStreamingService

NSString * const popularUrl = @"https://api-v2.hearthis.at/feed/?page=1&count=5&duration=3";
NSString * const searchUrl = @"https://api-v2.hearthis.at/search?t=%@&page=1&count=5";

#pragma mark - Protocol Public Methods

//TODO: Refactor this piece
- (void)getPopularPlaylist:(void (^)(MLDPlaylist *))completionHandler {
    MLDPlaylist *playlist = [MLDPlaylist new];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:popularUrl]];
    
    NSURLSessionDataTask *task = [[self getUrlSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *jsonError;
            NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            for(NSDictionary *item in parsedJSONArray)
            {
                MLDSong *song = [self deserializeSong:item];
                
                [playlist.songList addObject:song];
                NSLog(@"Item: %@", item[@"title"]);
            }
            
            completionHandler(playlist);
        });
    }];
    
    [task resume];
}

- (void)searchSong:(void (^)(MLDPlaylist *))completionHandler query:(NSString *)query {
    MLDPlaylist *playlist = [MLDPlaylist new];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:searchUrl, query]]];
    
    NSURLSessionDataTask *task = [[self getUrlSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *jsonError;
            if(!data)
                return;
            NSArray *parsedJSONArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
            
            for(NSDictionary *item in parsedJSONArray)
            {
                MLDSong *song = [self deserializeSong:item];
                
                [playlist.songList addObject:song];
                NSLog(@"Item: %@", item[@"title"]);
            }
            
            completionHandler(playlist);
        });
    }];
    
    [task resume];
}


#pragma mark - Private Methods

-(MLDSong *)deserializeSong:(NSDictionary *)rawData
{
    MLDSong *song = [MLDSong new];
    
    song.duration = [rawData[@"duration"] integerValue];
    
    NSString *artistAndSong = rawData[@"title"];
    if([artistAndSong containsString:@" - "])
    {
        NSArray *titleArray = [artistAndSong componentsSeparatedByString:@" - "];
        song.artist = titleArray[0];
        song.title = titleArray[1];
    }
    else
    {
        song.title = rawData[@"title"];
        song.artist = rawData[@"user"][@"username"];
    }
    
    song.thumb = rawData[@"thumb"];
    
    return song;
}

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

@end
