//
//  PlaylistView.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <ReactiveObjC.h>

#import "PlaylistView.h"
#import "PlaylistViewModel.h"

@interface PlaylistView ()

@property (nonatomic, strong) UIButton *addSongButton;

@property (nonatomic, strong) UILabel *actualPlaylist;

@end

@implementation PlaylistView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self bindUI];
    
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addSongButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 150, 50)];
    [self.addSongButton setTitle:@"Add test song" forState:UIControlStateNormal];
    [self.addSongButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addSongButton addTarget:self action:@selector(addPremiumSong) forControlEvents:UIControlEventTouchDown];
    
    self.actualPlaylist = [[UILabel alloc]initWithFrame:CGRectMake(100, 250, 150, 50)];
    self.actualPlaylist.textAlignment =NSTextAlignmentCenter;
    self.actualPlaylist.textColor = [UIColor blackColor];
    [self.actualPlaylist setText:@"OOOKAY??!"];

    [self.view addSubview:self.addSongButton];
    [self.view addSubview:self.actualPlaylist];
}

-(void)bindUI
{
    RAC(self, self.actualPlaylist.text) = RACObserve(self, self.viewModel.rawPlaylist);
}

-(void)addPremiumSong
{
    [self.viewModel addPremiumSong];
}

@end
