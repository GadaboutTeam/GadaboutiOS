//
//  MenuViewController.h
//  GadaboutiOS
//
//  Created by Alex Bardasu on 05/02/15.
//  Copyright (c) 2015 GadaboutTeam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCell.h"

@interface MenuViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSArray *menuItemsArray;
@end
