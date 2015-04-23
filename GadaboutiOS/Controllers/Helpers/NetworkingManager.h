//
//  NetworkingManager.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "AFNetworking.h"
#import "User.h"

FOUNDATION_EXPORT NSString *const DomainURL;
FOUNDATION_EXPORT NSString *const LKEndPointEventsForUser;
FOUNDATION_EXPORT NSString *const LKEndPointUsersForEvent;
FOUNDATION_EXPORT NSString *const LKEndPointReplyToInvite;
FOUNDATION_EXPORT NSString *const LKEndPointCreateEvent;

@interface NetworkingManager : AFHTTPSessionManager {
    AFHTTPRequestOperationManager *manager;
}

+ (id)sharedNetworkingManger;
- (void)sendDictionary:(id)dictionary toService:(NSString*)service;
- (void)requestWithDictionary:(id)dictionary fromService:(NSString *)service completion:(void (^)(id, NSError *))completion;
- (void)getRequestWithDictionary:(id)dictionary fromService:(NSString *)service completion:(void (^)(id, NSError *))completion;
@end
