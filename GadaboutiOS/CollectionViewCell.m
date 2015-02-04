//
//  CollectionViewCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/3/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)layoutSubviews {
    [super layoutSubviews];
    
    IBInspectable [self.layer setBorderWidth:2.0f];
    IBInspectable [self.layer setBorderColor:[UIColor blackColor].CGColor];
}

@end
