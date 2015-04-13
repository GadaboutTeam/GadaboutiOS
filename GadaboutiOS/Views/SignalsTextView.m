//
//  SZTextView+Signals.m
//  GadaboutiOS
//
//  Created by David Barsky on 4/13/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SignalsTextView.h"

@implementation SignalsTextView

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.placeholderTextColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.4];
    self.scrollEnabled = NO;
}

@end
