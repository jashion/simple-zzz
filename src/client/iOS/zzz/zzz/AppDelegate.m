//
//  AppDelegate.m
//  zzz
//
//  Created by jashion on 16/6/25.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HomePageVC *homeVC = [[HomePageVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController: homeVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
