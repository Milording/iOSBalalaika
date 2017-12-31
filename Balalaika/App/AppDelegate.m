//
//  AppDelegate.m
//  Balalaika
//
//  Created by milording on 13/12/2017.
//  Copyright © 2017 milording. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewModel.h"
#import "LoginView.h"
#import <Objection.h>
#import "ObjectionModule.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Objection configuration
    JSObjectionInjector *injector = [JSObjection createInjector:[ObjectionModule new]];
    [JSObjection setDefaultInjector:injector];

    
    self.window = 	[UIWindow new];
    
    LoginViewModel *loginVm = [LoginViewModel new];
    LoginView *loginView = [LoginView new];
    loginView.viewModel = loginVm;
    loginView.title=@"Location";
        
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginView];
    //[nav addChildViewController:playlistView];
    //[nav pushViewController:playlistView animated:YES];
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Balalaika"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }

    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
