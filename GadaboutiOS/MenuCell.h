//
//  MenuCell.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 05/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *itemTitle;

- (void)setMenuItemLabel:(NSString *)title;

@end
