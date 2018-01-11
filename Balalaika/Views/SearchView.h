//
//  SearchView.h
//  Balalaika
//
//  Created by milording on 08/01/2018.
//  Copyright © 2018 milording. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewModel.h"

@interface SearchView : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) SearchViewModel *viewModel;

@end
