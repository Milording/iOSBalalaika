//
//  PlaylistTableViewCell.m
//  Balalaika
//
//  Created by milording on 04/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import "PlaylistTableViewCell.h"
#import <Masonry.h>

@interface PlaylistTableViewCell()

@property (nonatomic, strong) UIColor *grayColor;

@end

@implementation PlaylistTableViewCell

#pragma mark - Lifecycle

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.grayColor = [UIColor colorWithRed:(143/255.f) green:(142/255.f) blue:(148/255.f) alpha:1.0f];
        
        
        self.songLabel = [UILabel new];
        self.songLabel.textColor = [UIColor blackColor];
        
        [self addSubview:self.songLabel];
        [self.songLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_top).offset(20);
            make.left.equalTo(@84);
        }];
        
        self.artistLabel = [UILabel new];
        [self.artistLabel  setTextColor:self.grayColor];
        
        [self addSubview:self.artistLabel];
        [self.artistLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_bottom).offset(-20);
            make.left.equalTo(@84);
        }];
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setTextColor:self.grayColor];
        
        [self addSubview:self.timeLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_right);
            make.right.equalTo(@48);
            make.centerY.equalTo(self.mas_centerY);
        }];
        

    }
    return self;
}

#pragma mark - Public Methods

-(void)setImage
{
    [self addSubview:self.coverImage];
    [self.coverImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(38);
        make.height.equalTo(@64);
        make.width.equalTo(@64);
        //make.right.equalTo(@48);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

#pragma mark - Overrided Methods
//TODO: Check for reason

-(void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
