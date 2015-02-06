//
//  MenuCell.m
//  GadaboutiOS
//
//  Created by Alex Bardasu on 05/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell
@synthesize itemTitle;

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:[UIColor blueColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMenuItemLabel:(NSString *)title {
    [itemTitle setText:title];
    [itemTitle setNeedsDisplay];
    NSLog(@"Cell title set to: %@", title);
}

@end
