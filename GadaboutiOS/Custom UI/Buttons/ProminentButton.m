//
//  ProminentButton.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/23/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "ProminentButton.h"

@implementation ProminentButton

-(void)layoutSubviews {
    [super layoutSubviews];
    
    [[self layer] setCornerRadius:4.0f];
}

@end
