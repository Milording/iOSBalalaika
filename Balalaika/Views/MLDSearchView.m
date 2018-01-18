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
#import "MLDPlaylistTableViewCell.h"

@interface MLDSearchView ()

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *searchTableView;

@property (nonatomic, strong) MLDPlaylist *searchPlaylist;

@property (nonatomic, copy) NSString *typedText;
@property (nonatomic, copy) NSString *searchQuery;

@property NSTimer *typeTimerDelay;

@end

@implementation MLDSearchView

NSString * const songCellIdentificator = @"SongCell";

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    

    _viewModel = [MLDSearchViewModel new];
    
    [self createUI];
    [self bindUI];
    
    
    _searchBar.delegate = self;
}

-(void)createUI
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
    
    [self initTableView];
}

-(void)bindUI
{
    RACChannelTo(self, self.searchQuery) = RACChannelTo(self, self.viewModel.searchQuery);
    
    
    [RACObserve(self, self.viewModel.searchResultsPlaylist) subscribeNext:^(id x) {
        if(x)
        {
            self.searchPlaylist = x;
            
            [self.searchTableView reloadData];
        }
    }];
}

-(void)initTableView
{
    self.searchTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    
    self.searchTableView.delegate = self;
    self.searchTableView.dataSource = self;
    
    self.searchTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.searchTableView];
    [self.searchTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@116);
        make.bottom.equalTo(@0);
        make.width.equalTo(self.view.mas_width);
    }];
}

#pragma mark - UISearchBarDelegate

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
    self.searchQuery = searchBar.text;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(!searchText || [searchText isEqualToString:@""])
    {
        [self.typeTimerDelay invalidate];
        self.typeTimerDelay = nil;
        return;
    }
        
    self.typedText = searchText;
    [self.typeTimerDelay invalidate];
    self.typeTimerDelay = nil;
    
    self.typeTimerDelay = [NSTimer scheduledTimerWithTimeInterval:2.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        self.searchQuery = searchText;
    }];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MLDSong *song = [self.searchPlaylist.songList objectAtIndex:indexPath.row];
    [self.viewModel addPremiumSong:song];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchPlaylist ? self.searchPlaylist.songList.count : 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = songCellIdentificator;
    
    MLDPlaylistTableViewCell *cell = (MLDPlaylistTableViewCell *)[self.searchTableView dequeueReusableHeaderFooterViewWithIdentifier:cellIdentifier];
    if(cell==nil) {
        cell = [[MLDPlaylistTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    MLDSong *song = [self.searchPlaylist.songList objectAtIndex:indexPath.row];
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
