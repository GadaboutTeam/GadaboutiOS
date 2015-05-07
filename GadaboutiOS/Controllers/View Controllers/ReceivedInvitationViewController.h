//
//  ReceivedInvitationViewController.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/20/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceivedInvitationViewController : UIViewController

@property (nonatomic, retain) NSDictionary *userInfo;

@property (nonatomic, retain) IBOutlet UIButton *affirmativeReplyButton;
@property (nonatomic, retain) IBOutlet UIButton *negativeReplyButton;

@end
