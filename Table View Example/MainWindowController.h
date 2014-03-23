//
//  MainWindowController.h
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JWCTableView.h"

@interface MainWindowController : NSWindowController <JWCTableViewDataSource, JWCTableViewDelegate>

@property (weak) IBOutlet JWCTableView *tableView;

@end
