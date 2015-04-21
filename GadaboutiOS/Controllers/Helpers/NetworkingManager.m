//
//  NetworkingManager.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NetworkingManager.h"
#import <Realm/Realm.h>

NSString *const DomainURL = @"http://104.236.228.143:8080/";
NSString *const LKEndPointEventsForUser = @"events_for_user";
NSString *const LKEndPointUsersForEvent = @"users_for_events";
NSString *const LKEndPointReplyToInvite = @"reply_to_invite";

@implementation NetworkingManager

+ (id)sharedNetworkingManger {
    static NetworkingManager *sharedNetworkingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkingManager = [[self alloc] init];
    });
    
    return sharedNetworkingManager;
}

- (NetworkingManager *)init {
    self = [super init];
    if (self) {
        manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void)sendDictionary:(NSDictionary *)dictionary toService:(NSString *)service{
    NSString *postURL = [DomainURL stringByAppendingString:service];
    
    [manager POST:postURL
       parameters:dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSLog(@"Success for operation: %@", [operation description]);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"Failure: %@", error.description);
          }];
}

- (void)requestWithDictionary:(NSDictionary *)dictionary fromService:(NSString *)service
                 completion:(void (^)(id, NSError *))completion{

    NSString *postURL = [DomainURL stringByAppendingString:service];

    [manager POST:postURL
       parameters:dictionary
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              completion(responseObject, nil);
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              completion(nil, error);
          }];
}

@end
