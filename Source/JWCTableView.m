//
//  JWCTableView.m
//  Table View Example
//
//  Created by Will Chilcutt on 3/23/14.
//  Copyright (c) 2014 NSWill. All rights reserved.
//

#import "JWCTableView.h"

@interface JWCTableView ()
{
    
}

@end

@implementation JWCTableView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self != nil)
    {
        [self setDelegate:self];
        self.dataSource = self;
    }
    
    return self;
}

#pragma mark NSTableViewDataSource methods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger numberOfSections = [self.jwcTableViewDataSource numberOfSectionsInTableView:tableView];
    
    NSInteger numberOfRows = 0;
    
    for (NSInteger section = 0; section < numberOfSections; section++)
    {
        NSInteger numberOfRowsInSection = [self.jwcTableViewDataSource tableView:tableView
                                                           numberOfRowsInSection:section];
        
        //Check if the section has a head view, and if so, then add 1 to the number of rows in that section.
        {
            BOOL needsSectionHeaderView = [self.jwcTableViewDataSource tableView:tableView
                                                         hasHeaderViewForSection:section];
            
            if (needsSectionHeaderView == YES)
            {
                numberOfRowsInSection++;
            }
        }
        
        numberOfRows = numberOfRowsInSection;
    }
    
    return numberOfRows;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSView *view = nil;
    
    NSInteger numberOfSections = [self.jwcTableViewDataSource numberOfSectionsInTableView:tableView];
    
    for (NSInteger section = 0; section < numberOfSections; section++)
    {
        NSInteger numberOfRowsInSection = [self.jwcTableViewDataSource tableView:tableView
                                                           numberOfRowsInSection:section];
        BOOL needsSectionHeaderView = [self.jwcTableViewDataSource tableView:tableView
                                                         hasHeaderViewForSection:section];
            
        if (needsSectionHeaderView == YES)
        {
            numberOfRowsInSection++;
        }
        
        //If the row number is larger than or equal to the number of Rows in section, then the row is not in the current section
        if (row >= numberOfRowsInSection)
        {
            row -=numberOfRowsInSection;
        }
        //The row we want is in this section.
        else
        {
            //If the row we are getting is the section header view
            if (row == 0 &&
                needsSectionHeaderView == YES)
            {
                view = [self.jwcTableViewDataSource tableView:tableView viewForHeaderInSection:section];
            }
            //Else if we are getting just a regular row.
            else
            {
                NSInteger realRowIndex = row;
                
                //If the section has a header view then subtract 1
                if (needsSectionHeaderView == YES)
                {
                    realRowIndex -=1;
                }
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:realRowIndex inSection:section];
                
                view = [self.jwcTableViewDataSource tableView:tableView viewForIndexPath:indexPath];
            }
            
            //We can break out of the for loop because we have the view!
            break;
        }
    }
    
    return view;
}
//
///* This method is required for the "Cell Based" TableView, and is optional for the "View Based" TableView. If implemented in the latter case, the value will be set to the view at a given row/column if the view responds to -setObjectValue: (such as NSControl and NSTableCellView).
// */
//- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
//
//#pragma mark -
//#pragma mark ***** Optional Methods *****
//
///* NOTE: This method is not called for the View Based TableView.
// */
//- (void)tableView:(NSTableView *)tableView setObjectValue:(id)object forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
//
///* Sorting support
// This is the indication that sorting needs to be done.  Typically the data source will sort its data, reload, and adjust selections.
// */
//- (void)tableView:(NSTableView *)tableView sortDescriptorsDidChange:(NSArray *)oldDescriptors;
//
///* Dragging Source Support - Required for multi-image dragging. Implement this method to allow the table to be an NSDraggingSource that supports multiple item dragging. Return a custom object that implements NSPasteboardWriting (or simply use NSPasteboardItem). If this method is implemented, then tableView:writeRowsWithIndexes:toPasteboard: will not be called.
// */
//- (id <NSPasteboardWriting>)tableView:(NSTableView *)tableView pasteboardWriterForRow:(NSInteger)row NS_AVAILABLE_MAC(10_7);
//
///* Dragging Source Support - Optional. Implement this method to know when the dragging session is about to begin and to potentially modify the dragging session.'rowIndexes' are the row indexes being dragged, excluding rows that were not dragged due to tableView:pasteboardWriterForRow: returning nil. The order will directly match the pasteboard writer array used to begin the dragging session with [NSView beginDraggingSessionWithItems:event:source]. Hence, the order is deterministic, and can be used in -tableView:acceptDrop:row:dropOperation: when enumerating the NSDraggingInfo's pasteboard classes.
// */
//- (void)tableView:(NSTableView *)tableView draggingSession:(NSDraggingSession *)session willBeginAtPoint:(NSPoint)screenPoint forRowIndexes:(NSIndexSet *)rowIndexes NS_AVAILABLE_MAC(10_7);
//
///* Dragging Source Support - Optional. Implement this method to know when the dragging session has ended. This delegate method can be used to know when the dragging source operation ended at a specific location, such as the trash (by checking for an operation of NSDragOperationDelete).
// */
//- (void)tableView:(NSTableView *)tableView draggingSession:(NSDraggingSession *)session endedAtPoint:(NSPoint)screenPoint operation:(NSDragOperation)operation NS_AVAILABLE_MAC(10_7);
//
///* Dragging Destination Support - Required for multi-image dragging. Implement this method to allow the table to update dragging items as they are dragged over the view. Typically this will involve calling [draggingInfo enumerateDraggingItemsWithOptions:forView:classes:searchOptions:usingBlock:] and setting the draggingItem's imageComponentsProvider to a proper image based on the content. For View Based TableViews, one can use NSTableCellView's -draggingImageComponents. For cell based TableViews, use NSCell's draggingImageComponentsWithFrame:inView:.
// */
//- (void)tableView:(NSTableView *)tableView updateDraggingItemsForDrag:(id <NSDraggingInfo>)draggingInfo NS_AVAILABLE_MAC(10_7);
//
///* Dragging Source Support - Optional for single-image dragging. Implement this method to support single-image dragging. Use the more modern tableView:pasteboardWriterForRow: to support multi-image dragging. This method is called after it has been determined that a drag should begin, but before the drag has been started.  To refuse the drag, return NO.  To start a drag, return YES and place the drag data onto the pasteboard (data, owner, etc...).  The drag image and other drag related information will be set up and provided by the table view once this call returns with YES.  'rowIndexes' contains the row indexes that will be participating in the drag.
// */
//- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard;
//
///* Dragging Destination Support - This method is used by NSTableView to determine a valid drop target. Based on the mouse position, the table view will suggest a proposed drop 'row' and 'dropOperation'. This method must return a value that indicates which NSDragOperation the data source will perform. The data source may "re-target" a drop, if desired, by calling setDropRow:dropOperation: and returning something other than NSDragOperationNone. One may choose to re-target for various reasons (eg. for better visual feedback when inserting into a sorted position).
// */
//- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation;
//
///* Dragging Destination Support - This method is called when the mouse is released over an NSTableView that previously decided to allow a drop via the validateDrop method. The data source should incorporate the data from the dragging pasteboard at this time. 'row' and 'dropOperation' contain the values previously set in the validateDrop: method.
// */
//- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id <NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation;
//
///* Dragging Destination Support - NSTableView data source objects can support file promised drags by adding NSFilesPromisePboardType to the pasteboard in tableView:writeRowsWithIndexes:toPasteboard:.  NSTableView implements -namesOfPromisedFilesDroppedAtDestination: to return the results of this data source method.  This method should returns an array of filenames for the created files (filenames only, not full paths).  The URL represents the drop location.  For more information on file promise dragging, see documentation on the NSDraggingSource protocol and -namesOfPromisedFilesDroppedAtDestination:.
// */
//- (NSArray *)tableView:(NSTableView *)tableView namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination forDraggedRowsWithIndexes:(NSIndexSet *)indexSet;

#pragma mark NSTableViewDelegate methods


///* View Based TableView:
// Non-bindings: This method is required if you wish to turn on the use of NSViews instead of NSCells. The implementation of this method will usually call -[tableView makeViewWithIdentifier:[tableColumn identifier] owner:self] in order to reuse a previous view, or automatically unarchive an associated prototype view for that identifier. The -frame of the returned view is not important, and it will be automatically set by the table. 'tableColumn' will be nil if the row is a group row. Returning nil is acceptable, and a view will not be shown at that location. The view's properties should be properly set up before returning the result.
// 
// Bindings: This method is optional if at least one identifier has been associated with the TableView at design time. If this method is not implemented, the table will automatically call -[self makeViewWithIdentifier:[tableColumn identifier] owner:[tableView delegate]] to attempt to reuse a previous view, or automatically unarchive an associated prototype view. If the method is implemented, the developer can setup properties that aren't using bindings.
// 
// The autoresizingMask of the returned view will automatically be set to NSViewHeightSizable to resize properly on row height changes.
// */
//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_7);
//
///* View Based TableView: The delegate can optionally implement this method to return a custom NSTableRowView for a particular 'row'. The reuse queue can be used in the same way as documented in tableView:viewForTableColumn:row:. The returned view will have attributes properly set to it before it is added to the tableView. Returning nil is acceptable. If nil is returned, or this method isn't implemented, a regular NSTableRowView will be created and used.
// */
//- (NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row NS_AVAILABLE_MAC(10_7);
//
///* View Based TableView: Optional: This delegate method can be used to know when a new 'rowView' has been added to the table. At this point, you can choose to add in extra views, or modify any properties on 'rowView'.
// */
//- (void)tableView:(NSTableView *)tableView didAddRowView:(NSTableRowView *)rowView forRow:(NSInteger)row NS_AVAILABLE_MAC(10_7);
//
///* View Based TableView: Optional: This delegate method can be used to know when 'rowView' has been removed from the table. The removed 'rowView' may be reused by the table so any additionally inserted views should be removed at this point. A 'row' parameter is included. 'row' will be '-1' for rows that are being deleted from the table and no longer have a valid row, otherwise it will be the valid row that is being removed due to it being moved off screen.
// */
//- (void)tableView:(NSTableView *)tableView didRemoveRowView:(NSTableRowView *)rowView forRow:(NSInteger)row NS_AVAILABLE_MAC(10_7);
//
//#pragma mark -
//#pragma mark ***** Cell Based TableView Support *****
//
///* Allows the delegate to provide further setup for 'cell' in 'tableColumn'/'row'. It is not safe to do drawing inside this method, and you should only setup state for 'cell'.
// */
//- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
//- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row;
//
///* Optional - Tool Tip Support
// When the user pauses over a cell, the value returned from this method will be displayed in a tooltip.  'point' represents the current mouse location in view coordinates.  If you don't want a tooltip at that location, return nil or the empty string.  On entry, 'rect' represents the proposed active area of the tooltip.  By default, rect is computed as [cell drawingRectForBounds:cellFrame].  To control the default active area, you can modify the 'rect' parameter.
// */
//- (NSString *)tableView:(NSTableView *)tableView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation;
//
///* Optional - Expansion ToolTip support
// View Based TableView: This method is not called or used.
// Cell Based TableView: Implement this method and return NO to prevent an expansion tooltip from appearing for a particular cell in a given row and tableColumn. See NSCell.h for more information on expansion tool tips.
// */
//- (BOOL)tableView:(NSTableView *)tableView shouldShowCellExpansionForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_5);
//
///*  Optional - Custom tracking support
// It is possible to control the ability to track a cell or not. Normally, only selectable or selected cells can be tracked. If you implement this method, cells which are not selectable or selected can be tracked, and vice-versa. For instance, this allows you to have an NSButtonCell in a table which does not change the selection, but can still be clicked on and tracked.
// */
//- (BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_5);
//
///*  Optional - Different cells for each row
// A different data cell can be returned for any particular tableColumn and row, or a cell that will be used for the entire row (a full width cell). The returned cell should properly implement copyWithZone:, since the cell may be copied by NSTableView. If the tableColumn is non-nil, and nil is returned, then the table will use the default cell from [tableColumn dataCellForRow:row].
// 
// When each row is being drawn, this method will first be called with a nil tableColumn. At this time, you can return a cell that will be used to draw the entire row, acting like a group. If you do return a cell for the 'nil' tableColumn, be prepared to have the other corresponding datasource and delegate methods to be called with a 'nil' tableColumn value. If don't return a cell, the method will be called once for each tableColumn in the tableView, as usual.
// */
//- (NSCell *)tableView:(NSTableView *)tableView dataCellForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_5);
//
//#pragma mark -
//#pragma mark ***** Common Delegate Methods *****
//
///* Optional - called whenever the user is about to change the selection. Return NO to prevent the selection from being changed at that time.
// */
//- (BOOL)selectionShouldChangeInTableView:(NSTableView *)tableView;
//
///* Optional - Return YES if 'row' should be selected and NO if it should not. For better performance and better control over the selection, you should use tableView:selectionIndexesForProposedSelection:.
// */
//- (BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row;
//
///* Optional - Return a set of new indexes to select when the user changes the selection with the keyboard or mouse. If implemented, this method will be called instead of tableView:shouldSelectRow:. This method may be called multiple times with one new index added to the existing selection to find out if a particular index can be selected when the user is extending the selection with the keyboard or mouse. Note that 'proposedSelectionIndexes' will contain the entire newly suggested selection, and you can return the exsiting selection to avoid changing the selection.
// */
//- (NSIndexSet *)tableView:(NSTableView *)tableView selectionIndexesForProposedSelection:(NSIndexSet *)proposedSelectionIndexes NS_AVAILABLE_MAC(10_5);
//
//- (BOOL)tableView:(NSTableView *)tableView shouldSelectTableColumn:(NSTableColumn *)tableColumn;
//
//- (void)tableView:(NSTableView *)tableView mouseDownInHeaderOfTableColumn:(NSTableColumn *)tableColumn;
//- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn;
//- (void)tableView:(NSTableView *)tableView didDragTableColumn:(NSTableColumn *)tableColumn;
//
///* Optional - Variable Row Heights
// Implement this method to support a table with varying row heights. The height returned by this method should not include intercell spacing and must be greater than zero. Performance Considerations: For large tables in particular, you should make sure that this method is efficient. NSTableView may cache the values this method returns, but this should NOT be depended on, as all values may not be cached. To signal a row height change, call -noteHeightOfRowsWithIndexesChanged:. For a given row, the same row height should always be returned until -noteHeightOfRowsWithIndexesChanged: is called, otherwise unpredicable results will happen. NSTableView automatically invalidates its entire row height cache in -reloadData, and -noteNumberOfRowsChanged.
// */
//- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row;
//
///* Optional - Type select support
// Implement this method if you want to control the string that is used for type selection. You may want to change what is searched for based on what is displayed, or simply return nil for that 'tableColumn' or 'row' to not be searched. By default, all cells with text in them are searched. The default value when this delegate method is not implemented is [[tableView preparedCellAtColumn:tableColumn row:row] stringValue], and this value can be returned from the delegate method if desired.
// */
//- (NSString *)tableView:(NSTableView *)tableView typeSelectStringForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row NS_AVAILABLE_MAC(10_5);
//
///* Optional - Type select support
// Implement this method if you want to control how type selection works. Return the first row that matches searchString from within the range of startRow to endRow. It is possible for endRow to be less than startRow if the search will wrap. Return -1 when there is no match. Include startRow as a possible match, but do not include endRow. It is not necessary to implement this method in order to support type select.
// */
//- (NSInteger)tableView:(NSTableView *)tableView nextTypeSelectMatchFromRow:(NSInteger)startRow toRow:(NSInteger)endRow forString:(NSString *)searchString NS_AVAILABLE_MAC(10_5);
//
///* Optional - Type select support
// Implement this method if you would like to prevent a type select from happening based on the current event and current search string. Generally, this will be called from keyDown: and the event will be a key event. The search string will be nil if no type select has began.
// */
//- (BOOL)tableView:(NSTableView *)tableView shouldTypeSelectForEvent:(NSEvent *)event withCurrentSearchString:(NSString *)searchString NS_AVAILABLE_MAC(10_5);
//
///* Optional - Group rows.
// Implement this method and return YES to indicate a particular row should have the "group row" style drawn for that row. If the cell in that row is an NSTextFieldCell and contains only a stringValue, the "group row" style attributes will automatically be applied for that cell. Group rows are drawn differently depending on the selectionHighlightStyle. For NSTableViewSelectionHighlightStyleRegular, there is a blue gradient background. For NSTableViewSelectionHighlightStyleSourceList, the text is light blue, and there is no background. Also see the related floatsGroupRows property.
// */
//- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row NS_AVAILABLE_MAC(10_5);
//
///* Optional - Autosizing table columns
// Implement this method if you want to control how wide a column is made when the user double clicks on the resize divider. By default, NSTableView iterates every row in the table, accesses a cell via preparedCellAtRow:column:, and requests the "cellSize" to find the appropriate largest width to use. For large row counts, a monte carlo simulation is done instead of interating every row. For performance and accurate results, it is recommended that this method is implemented when using large tables.
// */
//- (CGFloat)tableView:(NSTableView *)tableView sizeToFitWidthOfColumn:(NSInteger)column NS_AVAILABLE_MAC(10_6);
//
///*  Optional - Control of column reordering.
// Specifies if the column can be reordered to a new location, or not. 'columnIndex' is the column that is being dragged. The actual NSTableColumn instance can be retrieved from the [tableView tableColumns] array. 'newColumnIndex' is the new proposed target location for 'columnIndex'. When a column is initially dragged by the user, the delegate is first called with a 'newColumnIndex' of -1. Returning NO will disallow that column from being reordered at all. Returning YES allows it to be reordered, and the delegate will be called again when the column reaches a new location. If this method is not implemented, all columns are considered reorderable.
// */
//- (BOOL)tableView:(NSTableView *)tableView shouldReorderColumn:(NSInteger)columnIndex toColumn:(NSInteger)newColumnIndex NS_AVAILABLE_MAC(10_6);
//
//#pragma mark -
//#pragma mark ***** Notifications *****
//
//- (void)tableViewSelectionDidChange:(NSNotification *)notification;
//- (void)tableViewColumnDidMove:(NSNotification *)notification;
//- (void)tableViewColumnDidResize:(NSNotification *)notification;
//
///* Optional -  Called when the selection is about to be changed, but note, tableViewSelectionIsChanging: is only called when mouse events are changing the selection and not keyboard events.
// */
//- (void)tableViewSelectionIsChanging:(NSNotification *)notification;
//}

@end

@implementation NSIndexPath (NSTableView)

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section
{
    NSUInteger path[2] = {section, row};
    return [self indexPathWithIndexes:path length:2];
}

- (NSInteger)row
{
    return [self indexAtPosition:1];
}

-(NSInteger)section
{
    return [self indexAtPosition:0];
}

@end
