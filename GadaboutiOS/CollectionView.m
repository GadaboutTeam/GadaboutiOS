//
//  CollectionView.m
//  GadaboutiOS
//
//  Created by David Barsky on 2/3/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import "CollectionView.h"

@implementation CollectionView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
}

@end