//
//  ViewController.h
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewModel : NSObject

@property (nonatomic, copy) NSString *barTitle;
@property (nonatomic, copy) NSString *currentPlaylist;
@property (nonatomic, copy) NSString *connectionStatus;
@property (nonatomic, strong) NSNumber *isLoading;

@end
