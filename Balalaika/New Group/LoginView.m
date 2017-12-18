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
    
    
    self.locationLoadingView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50,self.view.frame.size.height/2+150,50,50)];
    self.locationLoadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.locationLoadingView startAnimating];
    
    self.createPlaylistButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 100, 180, 40)];
    [self.createPlaylistButton setTitle:@"Create Default Playlist" forState:UIControlStateNormal];
    [self.createPlaylistButton setTitleColor:[UIColor redColor] forState:(UIControlState)UIControlStateNormal];
    [self.createPlaylistButton addTarget:self action:@selector(createPlaylist) forControlEvents:UIControlEventTouchDown];
    
    self.getActualPlaylistButton = [[UIButton alloc]initWithFrame:CGRectMake(40,180,180,40)];
    [self.getActualPlaylistButton setTitle:@"Add premium song" forState:UIControlStateNormal];
    [self.getActualPlaylistButton setTitleColor:[UIColor redColor] forState:(UIControlState)UIControlStateNormal];
    [self.getActualPlaylistButton addTarget:self action:@selector(getActualPlaylist) forControlEvents:UIControlEventTouchDown];
    
    self.actualPlaylist = [[UILabel alloc]initWithFrame:CGRectMake(40, 220, 180, 60)];
    
    [self.view addSubview:self.locationIcon];
    [self.view addSubview:self.connectionStatus];
    [self.view addSubview:self.locationLoadingView];
}

-(void)bindUI
{
    RAC(self, self.actualPlaylist.text) = RACObserve(self, self.viewModel.currentPlaylist);
    RAC(self, self.connectionStatus.text) = RACObserve(self, self.viewModel.connectionStatus);
}

-(void)createPlaylist
{
    [self.viewModel startDefaultPlaylist];
}

-(void)getActualPlaylist
{
    [self.viewModel addPremiumSong:@"11222223"];
}


@end
