//
//  MLDPlaylistView.m
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <ReactiveObjC.h>
#import <Masonry.h>

#import "MLDPlaylistView.h"
#import "MLDPlaylistViewModel.h"
#import "MLDPlaylistTableViewCell.h"
#import "MLDPlaylist.h"
#import "MLDSong.h"
#import "MLDSearchView.h"

@interface MLDPlaylistView ()

@property (nonatomic, strong) UIButton *addSongButton;
@property (nonatomic, strong) MLDPlaylist *popularPlaylist;

@property (nonatomic, strong) UITableView *playlistTableView;
@property (nonatomic, strong) UIImageView *animatedImageView;

@end

@implementation MLDPlaylistView

NSString * const songCellIndentificator = @"SongCell";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MLDPlaylistViewModel *playlistVm = [MLDPlaylistViewModel new];
    _viewModel = playlistVm;
    
    [self createUI];
    [self bindUI];
}

-(void)createUI
{
    self.title = @"Music";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.addSongButton];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithTitle:@"Добавить" style:UIBarButtonItemStylePlain target:self action:@selector(addSong) ];
    self.navigationItem.rightBarButtonItem = addButton;
    

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
        make.top.equalTo(@60);
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
-(void)addSong
{
    MLDSearchView *searchView = [MLDSearchView new];
    [self.navigationController pushViewController:searchView animated:YES];
}


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
    static NSString *cellIdentifier = songCellIndentificator;
    
    MLDPlaylistTableViewCell *cell = (MLDPlaylistTableViewCell *)[self.playlistTableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[MLDPlaylistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MLDSong *song = [self.popularPlaylist.songList objectAtIndex:indexPath.row];
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
