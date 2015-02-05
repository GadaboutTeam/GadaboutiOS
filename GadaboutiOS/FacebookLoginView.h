//
//  FBLoginView.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 03/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import <FacebookSDK/FacebookSDK.h>
#import <UIButton+tintImage.h>

@interface FacebookLoginView : UIView

@property IBOutlet FBLoginView *fbLoginView;
@property IBOutlet UILabel *welcomeLabel;
@property IBOutlet UIButton *menuButton;

- (void)runAnimations;
- (void)setupLayout;
@end
