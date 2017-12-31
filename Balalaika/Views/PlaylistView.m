//
//  PlaylistView.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "PlaylistView.h"
#import "PlaylistViewModel.h"

@interface PlaylistView ()

@property (nonatomic, strong) UIButton *addSongButton;

@end

@implementation PlaylistView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.addSongButton = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 150, 50)];
    [self.addSongButton setTitle:@"Add test song" forState:UIControlStateNormal];
    [self.addSongButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.addSongButton addTarget:self action:@selector(addPremiumSong) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:self.addSongButton];
}

-(void)addPremiumSong
{
    [self.viewModel addPremiumSong];
}

@end
