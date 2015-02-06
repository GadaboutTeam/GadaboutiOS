//
//  AppDelegate.m
//  GadaboutiOS
//
//  Created by David Barsky on 1/30/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import <Realm/Realm.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

#pragma mark - Facebook Login

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
}

- (id)init {
    self = [super init];

    return self;
}

- (void)configureInitialViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard *storyboard;
    
    // If the user is already logged in to FB, jump to the main storyboard
    if (false) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    }

    UIStoryboard *menuStoryboard = [UIStoryboard storyboardWithName:@"Menu" bundle:nil];

    // Configure MFSideMenuController
    MFSideMenuContainerViewController *container =
    [MFSideMenuContainerViewController containerWithCenterViewController:[storyboard instantiateInitialViewController]
                                                  leftMenuViewController:[menuStoryboard instantiateInitialViewController]
                                                 rightMenuViewController:nil];

    self.window.rootViewController = container;
    [self.window makeKeyAndVisible];
}

#pragma mark - Global Setup

- (void)setupAppearence {
    UINavigationBar *navigationBarAppearence = [UINavigationBar appearance];
    
    navigationBarAppearence.tintColor = [UIColor whiteColor];
    navigationBarAppearence.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};

    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.window setBackgroundColor:[UIColor whiteColor]];
}

- (void)createUser {
    RLMResults *result = [User allObjects];
    if (result.count == 0) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        User *user = [[User alloc] init];
        [user setUserID:@"0"];
        [realm beginWriteTransaction];
        [realm addObject:user];
        [realm commitWriteTransaction];
    }
}


#pragma mark - Application Lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // load proper storyboard dependning if user is logged in
    [self configureInitialViewController];
    
    // for white text in navigation bar controllers
    [self setupAppearence];
    [self createUser];
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
    [FBAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
