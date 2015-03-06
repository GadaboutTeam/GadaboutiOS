//
//  FBGraphController.h
//  GadaboutiOS
//
//  Created by David Barsky on 2/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Realm/Realm.h>
#import "User.h"

@interface FBGraphController : NSObject

+ (void)updateUserInfo;

@end
