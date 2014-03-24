//
//  JWCTableView.h
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol JWCTableViewDelegate <NSObject>

//Selection
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(BOOL)tableView:(NSTableView *)tableView shouldSelectSection:(NSInteger)section;

@end

@protocol JWCTableViewDataSource <NSObject>

//Number of rows in section
-(NSInteger)tableView:(NSTableView *)tableView numberOfRowsInSection:(NSInteger)section;

@optional

//Number of sections
-(NSInteger)numberOfSectionsInTableView:(NSTableView *)tableView;

//Has a header view for a section
-(BOOL)tableView:(NSTableView *)tableView hasHeaderViewForSection:(NSInteger)section;

//Height related
-(CGFloat)tableView:(NSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(CGFloat)tableView:(NSTableView *)tableView heightForHeaderViewForSection:(NSInteger)section;

//View related
-(NSView *)tableView:(NSTableView *)tableView viewForHeaderInSection:(NSInteger)section;
-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath;

@end

@interface JWCTableView : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, assign) IBOutlet id <JWCTableViewDataSource> jwcTableViewDataSource;
@property (nonatomic, assign) IBOutlet id <JWCTableViewDelegate> jwcTableViewDelegate;

-(NSIndexPath *)indexPathForView:(NSView *)view;

@end

//This is a reimplementation of the NSIndexPath UITableView category.
@interface NSIndexPath (NSTableView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property(nonatomic,readonly) NSInteger section;
@property(nonatomic,readonly) NSInteger row;

@end
