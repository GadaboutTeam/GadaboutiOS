//
//  SetupView.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/24/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "SetupView.h"

@implementation SetupView

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [self setBackgroundGradient];
}

- (void)setBackgroundGradient {
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.14 green:0.18 blue:0.5 alpha:1] CGColor], (id)[[UIColor colorWithRed:0.41 green:0.5 blue:0.84 alpha:1] CGColor], nil];
    
    [self.layer insertSublayer:gradient atIndex:0];

    
}

@end
