//
//  EventConversationViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 21/04/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventConversationViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel *eventTitleLabel;
@property (nonatomic, retain) IBOutlet UINavigationItem *eventTitle;
@property (nonatomic, retain) Event *event;

@end
