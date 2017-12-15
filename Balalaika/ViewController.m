//
//  ViewController.m
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "ViewController.h"
#import <SignalR.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    SRHubConnection *hub = [SRHubConnection connectionWithURLString:@"http://balalaikaalpha.azurewebsites.net/signalr"];
    SRHubProxy *chat = [hub createHubProxy:@"BarHub"];
    
    [hub setStarted:^{
        NSLog(@"Connection Started");
        [chat invoke:@"StartDefaultPlaylist" withArgs:[NSArray new] completionHandler:^(id response, NSError *error) {
            NSLog(@"%@",response);
        }];
        
        //[hub send:@"hello world"];
    }];
    [hub start];
    
}

-(void) test
{
    
}

@end
