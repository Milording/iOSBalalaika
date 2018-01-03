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
#import "PlaylistTableViewCell.h"

@interface PlaylistView ()

@property (nonatomic, strong) UIButton *addSongButton;
@property (nonatomic, strong) UILabel *actualPlaylist;

@property (nonatomic, strong) UITableView *playlistTableView;

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
    
    [self initTableView];
}

-(void)initTableView
{
    self.playlistTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.playlistTableView.delegate = self;
    self.playlistTableView.dataSource = self;
    
    self.playlistTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.playlistTableView];
}

-(void)bindUI
{
    RAC(self, self.actualPlaylist.text) = RACObserve(self, self.viewModel.rawPlaylist);
}

-(void)addPremiumSong
{
    [self.viewModel addPremiumSong];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SongCell";
    
    PlaylistTableViewCell *cell = (PlaylistTableViewCell *)[self.playlistTableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if(cell==nil)
    {
        cell = [[PlaylistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.artistLabel.text = @"Boards of Canada - Geoggadi";
    cell.songLabel.text = @"Music is Math";
    cell.timeLabel.text = @"5:23";
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

#pragma mark - UITableViewDelegatew
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected....");
}

@end
