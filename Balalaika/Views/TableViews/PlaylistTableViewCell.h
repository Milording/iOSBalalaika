//
//  PlaylistTableViewCell.h
//  Balalaika
//
//  Created by milording on 04/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString* const kCellTitle = @"CellWithTitle";
static NSString* const kCellTitleMain = @"CellWithTitleMain";


@interface PlaylistTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *artistLabel;
@property (nonatomic, strong) UILabel *songLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIImageView *coverImage;

-(void)setImage;

@end
