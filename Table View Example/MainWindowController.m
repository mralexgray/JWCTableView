 //
//  MainWindowController.m
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import "MainWindowController.h"
#import "ButtonTableCellView.h"

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
            return 40;
            break;
        case 2:
            return 202;
            
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
            return YES;
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
    NSView *view = [self tableView:tableView
                  viewForIndexPath:indexPath];
    
    CGFloat height = view.frame.size.height;
    
    return height;
}

-(CGFloat)tableView:(NSTableView *)tableView heightForHeaderViewForSection:(NSInteger)section
{
    NSView *view = [self tableView:tableView
            viewForHeaderInSection:section];
    
    CGFloat height = view.frame.size.height;
    
    return height;
}

//View related
-(NSView *)tableView:(NSTableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSTableCellView *view = [tableView makeViewWithIdentifier:@"sectionHeaderView" owner:self];
    
    [view.textField setStringValue:[NSString stringWithFormat:@"Section %ld header",(long)section]];

    return view;
}

-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath
{
    ButtonTableCellView *view = [tableView makeViewWithIdentifier:@"rowCellView" owner:self];
    
    [view.textField setStringValue:[NSString stringWithFormat:@"Section %ld row %ld cell ",indexPath.section,indexPath.row]];
    [view.button setTarget:self];
    [view.button setAction:@selector(handleButtonWasPressed:)];
    
    return view;
}

#pragma mark JWCTableViewDelegate methods

-(BOOL)tableView:(NSTableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected section %ld, row %ld",(long)indexPath.section,(long)indexPath.row);
    return YES;
}

-(BOOL)tableView:(NSTableView *)tableView shouldSelectSection:(NSInteger)section
{
    NSLog(@"Selected section header for section %ld", (long)section);
    return YES;
}

#pragma mark Testing IBActions to determine which index path it was

- (IBAction)handleButtonWasPressed:(NSButton *)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForView:sender];
    
    NSLog(@"Button pressed in section %ld, row %ld",indexPath.section,indexPath.row);
}


@end
