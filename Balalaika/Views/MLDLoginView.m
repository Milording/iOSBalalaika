//
//  MLDLoginView.m
//  Balalaika
//
//  Created by milording on 17/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "MLDLoginView.h"
#import <ReactiveObjC.h>
#import "MLDPlaylistView.h"
#import "MLDPlaylistViewModel.h"
#import "Constants.h"
#import <Masonry.h>

@interface MLDLoginView ()

@property (nonatomic, strong) UIImageView *locationIcon;
@property (nonatomic, strong) UILabel *connectionStatus;
@property (nonatomic, strong) UIActivityIndicatorView *locationLoadingView;

@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UIButton *enterButton;

@property (nonatomic, strong) UIImageView *animatedImageView;

@end

@implementation MLDLoginView

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initUI];
    [self bindUI];
}

- (void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.animatedImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.animatedImageView.image = [UIImage animatedImageNamed:@"giphy-" duration:1.0f];
    self.animatedImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.animatedImageView.animationDuration = 1.0f;
    self.animatedImageView.animationRepeatCount=10;
    [self.animatedImageView startAnimating];
    [self.view addSubview:self.animatedImageView];
    
    self.connectionStatus = [UILabel new];
    self.connectionStatus.textColor = AMBlueColor;
    self.connectionStatus.text = @"Поиск бара";
    self.connectionStatus.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.connectionStatus];
    [self.connectionStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@215);
    }];

    self.locationLoadingView = [UIActivityIndicatorView new];
    self.locationLoadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.locationLoadingView startAnimating];
    
    [self.view addSubview:self.locationLoadingView];
    [self.locationLoadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.connectionStatus.mas_bottom).offset(36);
    }];
    
    self.welcomeLabel = [UILabel new];
    self.welcomeLabel.font = [UIFont fontWithName:@"TTMasters-Bold" size:36];
    self.welcomeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.numberOfLines = 0;
    self.welcomeLabel.textColor = [UIColor whiteColor];
    self.welcomeLabel.text = @"Название бара";

    [self.view addSubview:self.welcomeLabel];
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@200);
    }];

    self.enterButton = [UIButton new];
    [self.enterButton setTitle:@"Войти" forState:UIControlStateNormal];
    self.enterButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    [self.enterButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.enterButton setBackgroundColor:AMBlueColor];
    [self.enterButton addTarget:self action:@selector(goAsAdmin) forControlEvents:UIControlEventTouchDown];
    self.enterButton.layer.cornerRadius=5;
    
    
    [self.view addSubview:self.enterButton];
    [self.enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24); make.right.equalTo(@-24);
        make.height.equalTo(@54);
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.welcomeLabel.mas_bottom).offset(100);
        make.bottom.offset(-60);
    }];
}

#pragma mark - Binding

-(void)bindUI
{
    RAC(self, self.connectionStatus.text) = RACObserve(self, self.viewModel.connectionStatus);
    RAC(self, self.welcomeLabel.text) = RACObserve(self, self.viewModel.barTitle);
    
    [RACObserve(self, self.viewModel.isLoading) subscribeNext:^(id x) {
        NSNumber *isLoading = (NSNumber *)x;
        if([isLoading boolValue])
        {
            [self.locationLoadingView startAnimating];
            self.welcomeLabel.hidden = YES;
            self.animatedImageView.hidden = YES;
            self.connectionStatus.hidden = NO;
            self.enterButton.hidden = YES;
        }
        else
        {
            [self.locationLoadingView stopAnimating];
            self.welcomeLabel.hidden = NO;
            self.animatedImageView.hidden = NO;
            self.connectionStatus.hidden = YES;
            self.enterButton.hidden = NO;
        }
    }];
}

#pragma mark - Private Methods

-(void)goAsAdmin
{
    MLDPlaylistView *playlistView = [MLDPlaylistView new];
    
    [self.navigationController pushViewController:playlistView animated:YES];
}

@end
