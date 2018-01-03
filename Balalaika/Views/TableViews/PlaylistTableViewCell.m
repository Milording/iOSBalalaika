//
//  PlaylistTableViewCell.m
//  Balalaika
//
//  Created by milording on 04/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import "PlaylistTableViewCell.h"

@interface PlaylistTableViewCell()

@property (nonatomic, strong) UIColor *grayColor;

@end

@implementation PlaylistTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        self.grayColor = [UIColor colorWithRed:(143/255.f) green:(142/255.f) blue:(148/255.f) alpha:1.0f];
        
        
        self.songLabel = [UILabel new];
        self.songLabel.textColor = [UIColor blackColor];
        
        self.artistLabel = [UILabel new];
        [self.artistLabel  setTextColor:self.grayColor];
        
        self.timeLabel = [UILabel new];
        [self.timeLabel setTextColor:self.grayColor];
        
        
        self.songLabel.frame = CGRectMake(84, 12, 157, 20);
        self.artistLabel.frame = CGRectMake(84, 46, 157, 18);
        self.timeLabel.frame = CGRectMake(271, 29, 51, 18);
        
        
        [self addSubview:self.songLabel];
        [self addSubview:self.artistLabel];
        [self addSubview:self.timeLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    //[self setNeedsLayout];
    //[self layoutIfNeeded];
    
    //self.songLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.songLabel.frame);
    //self.artistLabel.preferredMaxLayoutWidth = CGRectGetWidth(self.artistLabel.frame);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
