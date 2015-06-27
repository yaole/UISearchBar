//
//  AppDelegate.m
//  twoKindsOfSearchBar
//
//  Created by ozx on 15/5/29.
//  Copyright (c) 2015年 ozx. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
//    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    ViewController * _viewController = [[ViewController alloc]init];
//    UINavigationController * _navigationController = [[UINavigationController alloc] initWithRootViewController:_viewController];
//    _window.rootViewController = _navigationController;
//    [self.window makeKeyAndVisible];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    ViewController *rootViewContriller = [[ViewController alloc] init] ;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:rootViewContriller];
    nav.navigationBar.translucent = NO;//设置导航栏的透明度为no.
    //如果不透明,则self.view 从{0,0}开始;如果透明,则self.view 从{0,64}开始
    
    self.window.rootViewController = nav;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
