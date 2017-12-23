//
//  ViewController.m
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "LoginViewModel.h"
#import "BarService.h"
#import <SignalR.h>
#import "BarLocationService.h"

@interface LoginViewModel ()

@property (nonatomic, strong)BarLocationService *barLocationService;

@end

@implementation LoginViewModel

-(instancetype)initWithProtocol:(BarLocationService *)barLocationService
{
    if(self = [super init])
    {
        _barLocationService = barLocationService;
        
        [self getCurrentBar];
    }
    return self;
}

-(void)getCurrentBar
{
    self.connectionStatus = @"Checking location...";
    self.isLoading = [NSNumber numberWithBool:YES];
    
    [self.barLocationService getCurrentBarTitle:^(Bar *bar) {
        self.connectionStatus = @"Location has been found";
        self.barTitle = bar.title;
        self.isLoading=[NSNumber numberWithBool:NO];
    }];
}

@end
