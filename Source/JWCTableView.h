//
//  JWCTableView.h
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol JWCTableViewDelegate <NSObject>

-(void)tableView:(NSTableView *)tableView shouldSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol JWCTableViewDataSource <NSObject>

-(NSInteger)numberOfSectionsInTableView:(NSTableView *)tableView;
-(NSView *)tableView:(NSTableView *)tableView viewForHeaderInSection:(NSInteger)section;
-(BOOL)tableView:(NSTableView *)tableView hasHeaderViewForSection:(NSInteger)section;
-(NSInteger)tableView:(NSTableView *)tableView numberOfRowsInSection:(NSInteger)section;
-(NSView *)tableView:(NSTableView *)tableView viewForIndexPath:(NSIndexPath *)indexPath;

@end

@interface JWCTableView : NSTableView <NSTableViewDataSource, NSTableViewDelegate>

@property (nonatomic, assign) id <JWCTableViewDataSource> jwcTableViewDataSource;
@property (nonatomic, assign) id <JWCTableViewDelegate> jwcTableViewDelegate;

@end


//This is a reimplementation of the NSIndexPath UITableView category.
@interface NSIndexPath (NSTableView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property(nonatomic,readonly) NSInteger section;
@property(nonatomic,readonly) NSInteger row;

@end
