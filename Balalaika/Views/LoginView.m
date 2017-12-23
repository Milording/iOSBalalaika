//
//  LoginView.m
//  Balalaika
//
//  Created by milording on 17/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "LoginView.h"
#import <ReactiveObjC.h>

@interface LoginView ()

@property (nonatomic, strong) UIButton *createPlaylistButton;
@property (nonatomic, strong) UIButton *getActualPlaylistButton;
@property (nonatomic, strong) UILabel *actualPlaylist;

@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UILabel *connectionStatus;
@property (nonatomic, strong) UIActivityIndicatorView *locationLoadingView;

@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UIButton *nextPageButton;

@end

@implementation LoginView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self bindUI];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.locationIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 50, 50)];
    
    self.connectionStatus = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2+50, 200, 30)];
    self.connectionStatus.textAlignment =NSTextAlignmentCenter;
    self.connectionStatus.textColor = [UIColor darkGrayColor];
    self.connectionStatus.text = @"Test";
    
    self.welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height/2+100, 300, 30)];
    self.welcomeLabel.textAlignment =NSTextAlignmentCenter;
    self.welcomeLabel.textColor = [UIColor blueColor];
    self.welcomeLabel.text = @"Test";
    
    self.locationLoadingView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50,self.view.frame.size.height/2+150,50,50)];
    self.locationLoadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.locationLoadingView startAnimating];
    
    self.nextPageButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, 110, 80, 30)];
    [self.nextPageButton setTitle:@"Дальше" forState:UIControlStateNormal];
    [self.nextPageButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    self.actualPlaylist = [[UILabel alloc]initWithFrame:CGRectMake(40, 220, 180, 60)];
    
    [self.view addSubview:self.locationIcon];
    [self.view addSubview:self.welcomeLabel];
    [self.view addSubview:self.connectionStatus];
    [self.view addSubview:self.locationLoadingView];
    [self.view addSubview:self.nextPageButton];
    
}

-(void)bindUI
{
    RAC(self, self.connectionStatus.text) = RACObserve(self, self.viewModel.connectionStatus);
    RAC(self, self.welcomeLabel.text) = RACObserve(self, self.viewModel.barTitle);
    
    [RACObserve(self, self.viewModel.isLoading) subscribeNext:^(id x) {
        NSNumber *isLoading = (NSNumber *)x;
        if([isLoading boolValue])
            [self.locationLoadingView startAnimating];
        else
            [self.locationLoadingView stopAnimating];
    }];
}

@end
