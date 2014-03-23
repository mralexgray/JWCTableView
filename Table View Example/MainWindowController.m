//
//  MainWindowController.m
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"MainWindowController"];
    
    if (self != nil)
    {

    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    [self.tableView reloadData];
}

#pragma mark JWCTableViewDataSource methods

//Number of rows in section
-(NSInteger)tableView:(NSTableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return 20;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 2;
            
        default:
            return 0;
            break;
    }
}

//Number of sections
-(NSInteger)numberOfSectionsInTableView:(NSTableView *)tableView
{
    return 3;
}

//Has a header view for a section
-(BOOL)tableView:(NSTableView *)tableView hasHeaderViewForSection:(NSInteger)section
{
    switch (section)
    {
        case 0:
            return NO;
            break;
        case 1:
            return YES;
            break;
        case 2:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
}

//Height related
-(CGFloat)tableView:(NSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 0;
    
    NSView *view = [self tableView:tableView
                  viewForIndexPath:indexPath];
    
    height = view.frame.size.height;
    
    //This is just to handle that the rows cannot be 0
    if (height == 0)
    {
        height = 1;
    }
    
    return height;
}

-(CGFloat)tableView:(NSTableView *)tableView heightForHeaderViewForSection:(NSInteger)section
{
    CGFloat height = 0;
    
    NSView *view = [self tableView:tableView
            viewForHeaderInSection:section];
    
    height = view.frame.size.height;
    
    //This is just to handle that the rows cannot be 0
    if (height == 0)
    {
        height = 1;
    }
    
    return height;
}

//View related
-(NSView *)tableView:(NSTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSTableCellView *view = nil;
    
    NSString *cellIdentifier = nil;
    
    switch (section)
    {
        case 0:
            cellIdentifier = @"sectionOneHeaderView";
            break;
        case 1:
            cellIdentifier = @"sectionTwoHeaderView";
            break;
        case 2:
            cellIdentifier = @"sectionThreeHeaderView";
            break;
            
        default:
            break;
    }
    
    [view.textField setStringValue:[NSString stringWithFormat:@"Section %ld header",(long)section]];
    
    view = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
    
    return view;
}

-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath
{
    NSTableCellView *view = nil;
    
    NSString *cellIdentifier = nil;
    
    switch (indexPath.section)
    {
        case 0:
            cellIdentifier = @"sectionOneCellView";
            break;
        case 1:
            cellIdentifier = @"sectionTwoCellView";
            break;
        case 2:
            cellIdentifier = @"sectionThreeCellView";
            break;
            
        default:
            break;
    }
    
    [view.textField setStringValue:[NSString stringWithFormat:@"Section %ld row %ld cell ",indexPath.section,indexPath.row]];
    
    view = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
    
    return view;
}

#pragma mark JWCTableViewDelegate methods

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectSection:(NSInteger)section
{
    return YES;
}

@end
