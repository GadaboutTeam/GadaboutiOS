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
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:0.36 green:0.62 blue:0.91 alpha:1] CGColor], (id)[[UIColor colorWithRed:0.16 green:0.38 blue:0.75 alpha:1] CGColor], nil];
    
    [self.layer insertSublayer:gradient atIndex:0];

    
}

@end
