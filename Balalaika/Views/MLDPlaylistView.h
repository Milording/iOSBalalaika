//
//  MLDPlaylistView.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLDPlaylistViewModel;

@interface MLDPlaylistView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MLDPlaylistViewModel *viewModel;

@end
