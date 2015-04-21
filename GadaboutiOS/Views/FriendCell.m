//
//  FriendCell.m
//  GadaboutiOS
//
//  Created by David Barsky on 3/27/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "FriendCell.h"

@interface FriendCell()
@property (nonatomic) CellState state;
@end

@implementation FriendCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.state = CellStateDeselected;
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    if(self.state == CellStateSelected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 1, 1, 1);
        CGContextFillRect(context, self.bounds);
    }
}

- (void)prepareForReuse {
    [self setCellState:CellStateDeselected];
}

- (void)setCellState:(CellState)cellState {
    self.state = cellState;
    [self setNeedsDisplay];
}

- (CellState)cellState {
    return self.state;
}

@end
