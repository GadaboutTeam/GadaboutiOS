//
//  FBGraphController.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//
#import "FBGraphController.h"

@implementation FBGraphController

+ (id)sharedLocationController {
    static FBGraphController *graphController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        graphController = [[self alloc] init];
    });
    
    return graphController;
}

- (id)init {
    if (self = [super init]) {
        NSLog(@"Graph Controller Initialized");
    }
    return self;
}

+(void)getUserFriends {
    [FBRequestConnection startWithGraphPath:@"/me/friends" parameters:nil HTTPMethod:@"GET"
                          completionHandler:^( FBRequestConnection *connection, id result, NSError *error) {
                              /* handle the result */
                          }];
}

+(void)updateUserInfo {
    [FBRequestConnection startWithGraphPath:@"/me"
                          completionHandler:^(FBRequestConnection *connection,
                                              id<FBGraphUser> result,
                                              NSError *error) {
                              NSLog(@"Retrieved user info.");
                              
                              NSString *userID = [result objectForKey:@"objectID"];
                              NSString *first_name = [result objectForKey:@"first_name"];
                              NSString *last_name = [result objectForKey:@"last_name"];
                              NSString *email = [result objectForKey:@"email"];
                              
                              RLMResults *userQuery = [User objectsWhere:[NSString stringWithFormat:@"facebookID = '%@'", userID]];
                              if ([userQuery count] == 0) {
                                  // Create user
                                  User *currentUser = [User init];
                                  [currentUser setUserID:userID.hash];
                                  [currentUser setFacebookID:userID];
                                  [currentUser setFirstName:first_name];
                                  [currentUser setLastName:last_name];
                                  [currentUser setEmail:email];
                                  [User createOrUpdateInDefaultRealmWithObject:currentUser];
                              }
                              
                          }];
}

@end
