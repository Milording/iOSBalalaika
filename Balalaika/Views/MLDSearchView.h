//
//  MLDSearchView.h
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLDSearchViewModel.h"

@interface MLDSearchView : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) MLDSearchViewModel *viewModel;

@end
