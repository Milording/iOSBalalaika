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
    
    self.createPlaylistButton = [[UIButton alloc]initWithFrame:CGRectMake(40, 100, 180, 40)];
    [self.createPlaylistButton setTitle:@"Create Default Playlist" forState:UIControlStateNormal];
    [self.createPlaylistButton setTitleColor:[UIColor redColor] forState:(UIControlState)UIControlStateNormal];
    [self.createPlaylistButton addTarget:self action:@selector(createPlaylist) forControlEvents:UIControlEventTouchDown];
    
    self.getActualPlaylistButton = [[UIButton alloc]initWithFrame:CGRectMake(40,180,180,40)];
    [self.getActualPlaylistButton setTitle:@"Add premium song" forState:UIControlStateNormal];
    [self.getActualPlaylistButton setTitleColor:[UIColor redColor] forState:(UIControlState)UIControlStateNormal];
    [self.getActualPlaylistButton addTarget:self action:@selector(getActualPlaylist) forControlEvents:UIControlEventTouchDown];
    
    self.actualPlaylist = [[UILabel alloc]initWithFrame:CGRectMake(40, 220, 180, 60)];
    self.actualPlaylist.text = @"OOOK";
    
    [self.view addSubview:self.createPlaylistButton];
    [self.view addSubview:self.getActualPlaylistButton];
    [self.view addSubview:self.actualPlaylist];
}

-(void)bindUI
{
    RAC(self, self.actualPlaylist.text) = RACObserve(self, self.viewModel.currentPlaylist);
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
