//
//  AppDelegate.m
//  Notes
//
//  Created by Maksym Poliakov on 09.11.16.
//  Copyright © 2016 Maksym Poliakov. All rights reserved.
//

#import "AppDelegate.h"
#import "ListVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ListVC alloc] init]];
    UIColor* barTintColor = [[UIColor alloc] initWithRed:25.0/255.0 green:103.0/255.0 blue:154.0/255.0 alpha:1.0];
    [[UINavigationBar appearance] setBarTintColor:barTintColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    
    return YES;
}

@end
