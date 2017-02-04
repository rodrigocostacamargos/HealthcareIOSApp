//
//  GuiaMedicoAppDelegate.m
//  GuiaMedico
//
//  Created by Rodrigo Camargos on 10/20/11.
//  Copyright 2011 InHouse. All rights reserved.
//

#import "GuiaMedicoAppDelegate.h"
#import "MainViewController.h"
#import "BookmarksViewController.h"
#import "MapViewController.h"
#import "DataAccessObject.h"
#import "JSON.h"

@implementation GuiaMedicoAppDelegate


@synthesize window=_window;


-(NSArray*) initializeControllers{
    
    NSArray *arrayOfControllers;
    
    navigationController = [[UINavigationController alloc] init];
    MainViewController *mainViewController = [[MainViewController alloc] init];
    mainViewController.title = @"Guia Medico";
    [navigationController pushViewController:mainViewController animated:NO];
    [mainViewController release];
    
    MapViewController *mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    
    UINavigationController *navigationController2 = [[UINavigationController alloc] init];
    BookmarksViewController *bookmarksViewController = [[BookmarksViewController alloc] init];
    bookmarksViewController.title = @"Favoritos";
    [navigationController2 pushViewController:bookmarksViewController animated:NO];
    
    arrayOfControllers = [[NSArray alloc] initWithObjects:navigationController, navigationController2, mapViewController,  nil];
    
    return arrayOfControllers;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

    // Check if database exists
    DataAccessObject *dao = [DataAccessObject sharedInstance];
    
    if (![dao databaseExists]) {
        // Create database
        [dao createDataBase];
    }
    
    //[dao updateDataBase]; // call web service
    
    // Add view controllers to the main view
    
    tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = [self initializeControllers];
  
    [self.window addSubview:tabBarController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
