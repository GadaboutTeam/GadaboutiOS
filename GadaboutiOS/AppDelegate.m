//
//  AppDelegate.m
//  GadaboutiOS
//
//  Created by David Barsky on 1/30/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>
#import "NetworkingManager.h"
#import "UserController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


#pragma mark - Global Appearence

- (void)setupAppearence {
    UINavigationBar *navigationBarAppearence = [UINavigationBar appearance];
    
    navigationBarAppearence.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor whiteColor]];
}

- (void)setViewController {
    UserController *userController = [UserController sharedUserController];
    if (![userController isLoggedIn]) {
        NSString *initialViewControllerID = @"loginScreen";
        UIViewController *rootVC = [[[[self window] rootViewController] storyboard] instantiateViewControllerWithIdentifier:initialViewControllerID];
        [[self window] setRootViewController:rootVC];
    }
}

#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Fabric with:@[TwitterKit]];
    [[Digits sharedInstance] logOut];
    
    // for white text in navigation bar controllers
    [self setupAppearence];
    
    // for tokens
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    [self setViewController];
    
    return YES;
}

#pragma mark - Notication Token Setup
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Got device token: %@", [devToken description]);
    
    [self sendProviderDeviceToken:[devToken bytes]]; // custom method; e.g., send to a web service and store
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void)sendProviderDeviceToken:(NSData *)devToken {
    NSDictionary *tokenDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:devToken, @"token", nil];
    
    NetworkingManager *networkingManager = [NetworkingManager sharedNetworkingManger];
    [networkingManager sendDictionary:tokenDictionary toService:@"users"];
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
