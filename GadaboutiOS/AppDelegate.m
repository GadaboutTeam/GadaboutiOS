//
//  AppDelegate.m
//  GadaboutiOS
//
//  Created by David Barsky on 1/30/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

// Framework Imports
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>

// App Imports
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "NetworkingManager.h"
#import "UserManager.h"
#import "PushManager.h"
#import "ReceivedInvitationViewController.h"

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
    UserManager *userController = [UserManager sharedUserController];
    if (![[userController currentUser] loggedIn]) {
        NSString *initialViewControllerID = @"loginScreen";
        UIViewController *rootVC = [[[[self window] rootViewController] storyboard] instantiateViewControllerWithIdentifier:initialViewControllerID];
        [[self window] setRootViewController:rootVC];
    }
}


#pragma mark - Global Setup

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // for white text in navigation bar controllers
    [self setupAppearence];
    
    // for tokens
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    [Parse setApplicationId:@"TH0mKaoKkU2YL6dQrWSIMdBahG1udfFASXVnYPh3"
                  clientKey:@"pk0bX25aA8PpX0JTD80zYUNdtZSYadXcJ2UJVvL0"];

    NSDictionary *userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSDictionary *aps = [userInfo objectForKey:@"aps"];

    if (aps) {
        NSLog(@"Pending notifications");
        UIViewController *vc = self.window.rootViewController;
        ReceivedInvitationViewController *rivc = [vc.storyboard instantiateViewControllerWithIdentifier:@"ReceivedInfitationViewController"];
        [vc presentViewController:rivc animated:YES completion:nil];
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

#pragma mark - Facebook

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

#pragma mark - Notication Token Setup
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    PFInstallation *currentInstalation = [PFInstallation currentInstallation];
    [currentInstalation setDeviceTokenFromData:devToken];
    [currentInstalation saveInBackground];

    //Legacy code
    UserManager *userController = [UserManager sharedUserController];
    User *user = [userController currentUser];
    [user setDeviceID:[[[devToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]] stringByReplacingOccurrencesOfString:@" " withString:@""]];

}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", [err description]);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Received notification: %@", userInfo);
    [PushManager handlePushNotification:userInfo navController:(UINavigationController *)self.window.rootViewController];
//    [PFPush handlePush:userInfo];
}

#pragma mark - First Run Notification

- (void)showFirstTimeMessage {
    static NSString *const applicationHasLaunchedOnceDefaultsKey = @"applicationHasLaunchedOnce";
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:applicationHasLaunchedOnceDefaultsKey]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:applicationHasLaunchedOnceDefaultsKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello!"
                                                       message:@"Welcome to this app!"
                                                      delegate:self
                                             cancelButtonTitle:nil
                                              otherButtonTitles:nil];
        
        [alert addButtonWithTitle:@"Got it!"];
        [alert show];
    }
}

#pragma mark - Application Lifecycle

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
    
        [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
