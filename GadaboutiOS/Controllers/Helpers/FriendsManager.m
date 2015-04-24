//
//  FriendsController.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 27/03/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendsManager.h"

// frameworks
#import <Realm/Realm.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <CoreLocation/CoreLocation.h>

// app specific imports
#import "NetworkingManager.h"
#import "UserManager.h"
#import "Picture.h"
#import "Invitation.h"

@interface FriendsManager ()

@property UserManager *userController;
@property NSMutableArray *friendsArray;
@property NetworkingManager *networkingManager;

@end

@implementation FriendsManager

#pragma mark - Initializers

+ (id)sharedFriendsController {
    static FriendsManager *sharedFriendsController = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedFriendsController = [[self alloc] init];
    });

    return sharedFriendsController;
}

- (id)init {
    self = [super init];

    if (self) {
        self.userController = [UserManager sharedUserController];
        self.networkingManager = [NetworkingManager sharedNetworkingManger];
        self.friendsArray = [[NSMutableArray alloc] init];
    }

    return self;
}

#pragma mark - Friend Getters

- (void)getFacebookFriends {
    NSString *serviceString = @"/me/friends?fields=name,installed,picture";
    [[[FBSDKGraphRequest alloc] initWithGraphPath:serviceString parameters:nil]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
         if (!error) {
             NSArray *friendsArray = [result valueForKey:@"data"];
             NSString *nextPage = [[result valueForKey:@"paging"] valueForKey:@"next"];
             [self persistFriends:friendsArray];
             [self getNextFacebookFriends:nextPage];
             
         } else {
             NSLog(@"Error: %@", error);
         }
     }];
}

- (void)getNextFacebookFriends:(NSString *)graphURL {
    if (graphURL != nil) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:graphURL]];

        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if (!connectionError) {
                NSError *jsonError;
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (!jsonError) {
                    [self persistFriends:[responseDictionary valueForKey:@"data"]];
                    [self getNextFacebookFriends:[[responseDictionary valueForKey:@"paging"] valueForKey:@"next"]];
                } else {
                    NSLog(@"JSON parsing error: %@", [jsonError description]);
                }
            }
        }];
    }
}

- (void)persistFriends:(NSArray *)friends {
    for (NSDictionary *fbFriend in friends) {
        User *friend = [[User alloc] init];
        [friend setFacebookID:[fbFriend valueForKey:@"id"]];
        [friend setDisplayName:[fbFriend valueForKey:@"name"]];
        [friend setUserType:UserTypeFriend];

        long hasApp = [[fbFriend valueForKey:@"installed"] integerValue];
        if (hasApp == 1) {
            [friend setHasApp:true];
        } else {
            [friend setHasApp:false];
        }

        [[RLMRealm defaultRealm] beginWriteTransaction];
        [User createOrUpdateInDefaultRealmWithObject:friend];
        [[RLMRealm defaultRealm] commitWriteTransaction];

        NSLog(@"Persisted friend: %@", [friend displayName]);
    }
}

- (void)getPictureForID:(User *)friend onCompletion:(void (^)())completionBlock {
    NSString *graphURL = [NSString stringWithFormat:@"https://graph.facebok.com/%@/picture?width=200", [friend facebookID]];
    NSURL *url = [NSURL URLWithString:graphURL];
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];

    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        @autoreleasepool {
            Picture *picture = [[Picture alloc] init];
            [picture setPictureData:(NSData *)responseObject];
            [picture setPictureID:[friend facebookID]];

            [[RLMRealm defaultRealm] beginWriteTransaction];
            [Picture createOrUpdateInDefaultRealmWithObject:picture];
            [[RLMRealm defaultRealm] commitWriteTransaction];
        }

        completionBlock();
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failed to download profile picture for %@: ", [friend displayName]);
    }];

    // Check for cached version
    Picture *cachedPicture = [Picture objectForPrimaryKey:[friend facebookID]];
    if (cachedPicture != nil) {
        completionBlock();
    } else {
        [requestOperation start];
    }
}

+ (NSArray *)getFriendsFromInvitations:(RLMArray<Invitation> *)invitations {
    NSMutableArray *users = [[NSMutableArray alloc] init];
    for(Invitation *invitation in invitations) {
        NSString *queryString = [[invitation user_id] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        User *user = [[User objectsWhere:@"facebookID = %@", queryString] firstObject];

        if (user != nil && ![queryString isEqualToString:[[[UserManager sharedUserController] currentUser] facebookID]]) {
            [users addObject:user];
        }
    }
    return users;
}


@end
