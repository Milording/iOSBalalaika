//
//  ViewController.m
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "LoginViewModel.h"
#import "BarLocationService.h"
#import <SignalR.h>
#import <Objection.h>

@interface LoginViewModel ()

@property id<BarLocationServiceProtocol> barLocationService;

@end

@implementation LoginViewModel
objection_requires(@"barLocationService")

#pragma mark - Lifecycle

-(instancetype)init
{
    if(self = [super init])
    {
        [[JSObjection defaultInjector]injectDependencies:self];
        
        [self getCurrentBar];
    }
    return self;
}

#pragma mark - Private Methods

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
