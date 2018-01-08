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
#import "Playlist.h"
#import "Song.h"
#import <Masonry.h>

@interface PlaylistView ()

@property (nonatomic, strong) UIButton *addSongButton;
@property (nonatomic, strong) Playlist *popularPlaylist;

@property (nonatomic, strong) UITableView *playlistTableView;
@property (nonatomic, strong) UIImageView *animatedImageView;

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation PlaylistView

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self bindUI];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.addSongButton];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"Добавить" style:UIBarButtonItemStylePlain target:self action:nil ];
    self.navigationItem.rightBarButtonItem = addButton;
    self.searchBar = [UISearchBar new];
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(@24); make.right.equalTo(@-24);
        make.top.equalTo(@64);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@50);
        //make.height.equalTo(@54);
        make.centerX.equalTo(self.view.mas_centerX);
        //make.top.equalTo(self.welcomeLabel.mas_bottom).offset(100);
    }];

    [self initTableView];
    
    self.animatedImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.animatedImageView.image = [UIImage animatedImageNamed:@"giphy-downsized-" duration:1.0f];
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.animatedImageView.animationDuration = 1.0f;
    self.animatedImageView.animationRepeatCount=10;
    [self.animatedImageView startAnimating];
    [self.view addSubview:self.animatedImageView];
}

-(void)initTableView
{
    self.playlistTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    
    self.playlistTableView.delegate = self;
    self.playlistTableView.dataSource = self;
    
    self.playlistTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.playlistTableView];
    [self.playlistTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@114);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view.mas_width);
    }];
}

#pragma mark - Binding

-(void)bindUI
{
    RAC(self, self.popularPlaylist) = RACObserve(self, self.viewModel.popularPlaylist);
    
    
    [RACObserve(self, self.viewModel.popularPlaylist) subscribeNext:^(id x) {
        if(x)
        {
            self.popularPlaylist = x;
            
            self.animatedImageView.hidden = YES;
            [self.playlistTableView reloadData];
        }
    }];
    
}

#pragma mark - Private Methods


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.popularPlaylist)
    {
        return self.popularPlaylist.songList.count;
    }
    else
    {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SongCell";
    
    PlaylistTableViewCell *cell = (PlaylistTableViewCell *)[self.playlistTableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[PlaylistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    Song *song = [self.popularPlaylist.songList objectAtIndex:indexPath.row];
    cell.artistLabel.text = song.artist;
    cell.songLabel.text = song.title;
    int minutes = (int)song.duration/60;
    int seconds = song.duration%60;
    
    cell.timeLabel.text = [NSString stringWithFormat:@"%d:%.02d",minutes, seconds];
    
    UIImage *coverImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:song.thumb]]];
    cell.coverImage = [[UIImageView alloc]initWithImage:coverImage];
    [cell setImage];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 76;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected....");
}

@end
