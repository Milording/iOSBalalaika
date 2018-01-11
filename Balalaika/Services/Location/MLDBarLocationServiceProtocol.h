//
//  MLDBarLocationServiceProtocol.h
//  Balalaika
//
//  Created by milording on 23/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLDLocationService.h"
#import "MLDBar.h"

@protocol MLDBarLocationServiceProtocol <NSObject>

-(void)getCurrentBarTitle:(void (^)(MLDBar *))completionHandler;

@end
