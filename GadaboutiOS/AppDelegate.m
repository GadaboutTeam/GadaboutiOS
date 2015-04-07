//
//  AppDelegate.m
//  GadaboutiOS
//
//  Created by David Barsky on 1/30/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <LayerKit/LayerKit.h>
#import "NetworkingManager.h"
#import "UserController.h"

@interface AppDelegate ()

@property (nonatomic) LYRClient *layerClient;

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
    // for white text in navigation bar controllers
    [self setupAppearence];
    
    // for tokens
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];

    if (![FBSDKAccessToken currentAccessToken]) {
        // still needs to be filled out.
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

#pragma mark - Layer Setup

- (void)connectWithLayer {
    NSUUID *appID = [[NSUUID alloc] initWithUUIDString:@"11da1402-dd67-11e4-b1fa-52bb01004845"];
    self.layerClient = [LYRClient clientWithAppID:appID];
    [self.layerClient connectWithCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"Failed to connect to Layer: %@", error);
        } else {
            // For the purposes of this Quick Start project, let's authenticate as a user named 'Device'.  Alternatively, you can authenticate as a user named 'Simulator' if you're running on a Simulator.
            NSString *userIDString = @"Device";
            // Once connected, authenticate user.
            // Check Authenticate step for authenticateLayerWithUserID source
            [self authenticateLayerWithUserID:userIDString completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSLog(@"Failed Authenticating Layer Client with error:%@", error);
                }
            }];
        }
    }];
}

- (void)authenticateLayerWithUserID:(NSString *)userID completion:(void (^)(BOOL success, NSError * error))completion {
    if (self.layerClient.authenticatedUserID) {
        NSLog(@"Layer Authenticated as User %@", self.layerClient.authenticatedUserID);
        if (completion) completion(YES, nil);
        return;
    }
    
    // 1. Request an authentication Nonce from Layer
    [self.layerClient requestAuthenticationNonceWithCompletion:^(NSString *nonce, NSError *error) {
        if (!nonce) {
            if (completion) {
                completion(NO, error);
            }
            return;
        }
        
        // 2. acquire identity token from Layer Identity Service
        [self requestIdentityTokenForUserID:userID appID:[self.layerClient.appID UUIDString] nonce:nonce completion:^(NSString *identityToken, NSError *error) {
            if (!identityToken) {
                if (completion) {
                    completion(NO, error);
                }
                return;
            }
            
            // 3. submit identity token to Layer for validation
            [self.layerClient authenticateWithIdentityToken:identityToken completion:^(NSString *authenticatedUserID, NSError *error) {
                if (authenticatedUserID) {
                    if (completion) {
                        completion(YES, nil);
                    }
                    NSLog(@"Layer Authenticated as User: %@", authenticatedUserID);
                } else {
                    completion(NO, error);
                }
            }];
        }];
    }];
}

- (void)requestIdentityTokenForUserID:(NSString *)userID appID:(NSString *)appID nonce:(NSString *)nonce completion:(void(^)(NSString *identityToken, NSError *error))completion {
    NSParameterAssert(userID);
    NSParameterAssert(appID);
    NSParameterAssert(nonce);
    NSParameterAssert(completion);
    
    NSURL *identityTokenURL = [NSURL URLWithString:@"https://layer-identity-provider.herokuapp.com/identity_tokens"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:identityTokenURL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    NSDictionary *parameters = @{ @"app_id": appID, @"user_id": userID, @"nonce": nonce };
    NSData *requestBody = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    request.HTTPBody = requestBody;
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            completion(nil, error);
            return;
        }
        
        // Deserialize the response
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if(![responseObject valueForKey:@"error"]) {
            NSString *identityToken = responseObject[@"identity_token"];
            completion(identityToken, nil);
        } else {
            NSString *domain = @"layer-identity-provider.herokuapp.com";
            NSInteger code = [responseObject[@"status"] integerValue];
            NSDictionary *userInfo =
            @{
              NSLocalizedDescriptionKey: @"Layer Identity Provider Returned an Error.",
              NSLocalizedRecoverySuggestionErrorKey: @"There may be a problem with your APPID."
              };
            
            NSError *error = [[NSError alloc] initWithDomain:domain code:code userInfo:userInfo];
            completion(nil, error);
        }
        
    }] resume];
}

#pragma mark - Notication Token Setup
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    NSLog(@"Got device token: %@", [devToken description]);
    
    [self sendProviderDeviceToken:[devToken bytes]]; // custom method; e.g., send to a web service and store

    UserController *userController = [UserController sharedUserController];
    User *user = [userController getCurrentUser];
    [user setDeviceID:[devToken description]];
    [userController setCurrentUser: user];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", [err description]);
}

- (void)sendProviderDeviceToken:(NSData *)devToken {
    NSDictionary *tokenDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:devToken, @"token", nil];
    
    NetworkingManager *networkingManager = [NetworkingManager sharedNetworkingManger];
    [networkingManager sendDictionary:tokenDictionary toService:@"users"];
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
