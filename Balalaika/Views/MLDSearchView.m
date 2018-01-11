//
//  MLDSearchView.m
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveObjC.h>

#import "MLDSearchView.h"
#import "MLDSearchViewModel.h"
#import "MLDPlaylist.h"
#import "MLDSong.h"
#import "PlaylistTableViewCell.h"

@interface MLDSearchView ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;

@property (nonatomic, strong) MLDPlaylist *popularPlaylist;

@property (nonatomic, copy) NSString *searchQuery;

@end

@implementation MLDSearchView

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _viewModel = [MLDSearchViewModel new];
    
    [self initUI];
    [self bindUI];
    
    _searchBar.delegate = self;
}

-(void)initUI
{
    self.title = @"Добавить";
    self.searchBar = [UISearchBar new];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@64);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(@50);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

-(void)bindUI
{
    //RACObserve(self, self.searchQuery) = RAC(self, self.viewModel.searchQuery);
}

-(void)initTableView
{
    
}

#pragma mark - UISearchBarDelegate

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    self.searchQuery = searchBar.text;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.searchQuery = searchText;
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
    static NSString *cellIdentifier = @"SongCell";
    
    PlaylistTableViewCell *cell = (PlaylistTableViewCell *)[self.searchTableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[PlaylistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
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

@end
