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
    self.barTintColor = [UIColor colorWithRed:0.27 green:0.52 blue:0.98 alpha:1];
}

@end
