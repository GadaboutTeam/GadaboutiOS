//
//  NavigationBar.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/3/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "NavigationBar.h"

@implementation NavigationBar

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor whiteColor];
    self.barTintColor = [UIColor colorWithRed:0.34 green:0.62 blue:0.92 alpha:1];
}

@end
