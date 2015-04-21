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
FOUNDATION_EXPORT NSString *const LKEndPointEventsForUser = @"events_for_user";
FOUNDATION_EXPORT NSString *const LKEndPointUsersForEvent = @"users_for_events";
FOUNDATION_EXPORT NSString *const LKEndPointReplyToInvite = @"reply_to_invite";

@interface NetworkingManager : AFHTTPSessionManager {
    AFHTTPRequestOperationManager *manager;
}

+ (id)sharedNetworkingManger;
- (void)sendDictionary:(NSDictionary*)dictionary toService:(NSString*)service;
- (void)requestWithDictionary:(NSDictionary *)dictionary fromService:(NSString *)service completion:(void (^)(id, NSError *))completion;
@end
