//
//  ComposeInvitationViewController.h
//  GadaboutiOS
//
//  Created by David Barsky on 4/13/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeInvitationViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, retain) NSArray *friendsArray;

@end
