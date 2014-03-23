//
//  AppDelegate.m
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"

@interface AppDelegate ()
{
    MainWindowController *mainWindowController;
}

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    mainWindowController = [[MainWindowController alloc] init];
    [mainWindowController showWindow:self];
    
    self.window = mainWindowController.window;
}

@end
