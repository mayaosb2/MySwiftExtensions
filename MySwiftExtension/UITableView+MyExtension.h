//
//  ViewController.swift
//  table
//
//  Created by 马耀 on 16/9/9.
//  Copyright © 2016年 mayao. All rights reserved.
//
//  避免Block循环引用!!!
//  __weak typeof(self) weakSelf = self;
//  __strong typeof(weakSelf) strongSelf = weakSelf;
//  __TVOS_PROHIBITED 苹果不建议使用的方法都已经注释!!!


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (MyExtension)

#pragma mark - UITableViewDataSourceBlcok
//_______________________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)

/******* @required *******/
- (instancetype)my_tableViewNumberOfRowsInSectionBlock:(NSInteger (^)(UITableView *tableView, NSInteger section))my_tableViewNumberOfRowsInSectionBlock;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (instancetype)my_tableViewCellForRowAtIndexPathBlock:(UITableViewCell * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCellForRowAtIndexPathBlock;

/******* @optional *******/
- (instancetype)my_numberOfSectionsInTableViewBlock:(NSInteger (^)(UITableView *tableView))my_numberOfSectionsInTableViewBlock; // Default is 1 if not implemented

// fixed font style. use custom view (UILabel) if you want something different
- (instancetype)my_tableViewTitleForHeaderInSectionBlock:(NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForHeaderInSectionBlock;
- (instancetype)my_tableViewTitleForFooterInSectionBlock:(NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForFooterInSectionBlock;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (instancetype)my_tableViewCanEditRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanEditRowAtIndexPathBlock;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (instancetype)my_tableViewCanMoveRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanMoveRowAtIndexPathBlock;

// Index

// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (instancetype)my_sectionIndexTitlesForTableViewBlock:(NSArray<NSString *> * (^)(UITableView *tableView))my_sectionIndexTitlesForTableViewBlock __TVOS_PROHIBITED;

// tell table which section corresponds to section title/index (e.g. "B",1))
//- (instancetype)my_tableViewSectionForSectionIndexTitleAtIndexBlock:(NSInteger (^)(UITableView *tableView, NSString *title, NSInteger index))my_tableViewSectionForSectionIndexTitleAtIndexBlock __TVOS_PROHIBITED;

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (instancetype)my_tableViewCommitEditingStyleForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath))my_tableViewCommitEditingStyleForRowAtIndexPathBlock;

// Data manipulation - reorder / moving support
- (instancetype)my_tableViewMoveRowAtIndexPathToIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath))my_tableViewMoveRowAtIndexPathToIndexPathBlock;

#pragma mark - UITableViewDelegateBlcok
//_______________________________________________________________________________________________________________
// this represents the display and behaviour of the cells.

/******* @optional *******/
// Display customization
- (instancetype)my_tableViewWillDisplayCellForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewWillDisplayCellForRowAtIndexPathBlock;
- (instancetype)my_tableViewWillDisplayHeaderViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayHeaderViewForSectionBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewWillDisplayFooterViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayFooterViewForSectionBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewDidEndDisplayingHeaderViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingHeaderViewForSectionBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewDidEndDisplayingFooterViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingFooterViewForSectionBlock NS_AVAILABLE_IOS(6_0);

// Variable height support
- (instancetype)my_tableViewHeightForRowAtIndexPathBlock:(CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewHeightForRowAtIndexPathBlock;
- (instancetype)my_tableViewHeightForHeaderInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForHeaderInSectionBlock;
- (instancetype)my_tableViewHeightForFooterInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForFooterInSectionBlock;

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (instancetype)my_tableViewEstimatedHeightForRowAtIndexPathBlock:(CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEstimatedHeightForRowAtIndexPathBlock NS_AVAILABLE_IOS(7_0);
- (instancetype)my_tableViewEstimatedHeightForHeaderInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForHeaderInSectionBlock NS_AVAILABLE_IOS(7_0);
- (instancetype)my_tableViewEstimatedHeightForFooterInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForFooterInSectionBlock NS_AVAILABLE_IOS(7_0);

// Section header & footer information. Views are preferred over title should you decide to provide both
- (instancetype)my_tableViewViewForHeaderInSectionBlock:(nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForHeaderInSectionBlock; // custom view for header. will be adjusted to default or specified header height
- (instancetype)my_tableViewViewForFooterInSectionBlock:(nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForFooterInSectionBlock; // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures).
//- (instancetype)my_tableViewAccessoryTypeForRowWithIndexPathBlock:(UITableViewCellAccessoryType (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryTypeForRowWithIndexPathBlock NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

- (instancetype)my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock;

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (instancetype)my_tableViewShouldHighlightRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldHighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewDidHighlightRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidHighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0);
- (instancetype)my_tableViewDidUnhighlightRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidUnhighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0);

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (instancetype)my_tableViewWillSelectRowAtIndexPathBlock:(nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillSelectRowAtIndexPathBlock;
- (instancetype)my_tableViewWillDeselectRowAtIndexPathBlock:(nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillDeselectRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0);

// Called after the user changes the selection.
- (instancetype)my_tableViewDidSelectRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidSelectRowAtIndexPathBlock;
- (instancetype)my_tableViewDidDeselectRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidDeselectRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0);

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (instancetype)my_tableViewEditingStyleForRowAtIndexPathBlock:(UITableViewCellEditingStyle (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditingStyleForRowAtIndexPathBlock;
//- (instancetype)my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock:(nullable NSString * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED;
//- (instancetype)my_tableViewEditActionsForRowAtIndexPathBlock:(nullable NSArray<UITableViewRowAction *> * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditActionsForRowAtIndexPathBlock NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED; // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (instancetype)my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock;

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (instancetype)my_tableViewWillBeginEditingRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillBeginEditingRowAtIndexPathBlock __TVOS_PROHIBITED;
//- (instancetype)my_tableViewDidEndEditingRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidEndEditingRowAtIndexPathBlock __TVOS_PROHIBITED;

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (instancetype)my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock:(NSIndexPath * (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath))my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock;

// Indentation

- (instancetype)my_tableViewIndentationLevelForRowAtIndexPathBlock:(NSInteger (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewIndentationLevelForRowAtIndexPathBlock; // return 'depth' of row for hierarchies

// Copy/Paste.  All three methods must be implemented by the delegate.

- (instancetype)my_tableViewShouldShowMenuForRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldShowMenuForRowAtIndexPathBlock NS_AVAILABLE_IOS(5_0);
- (instancetype)my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock:(BOOL (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock NS_AVAILABLE_IOS(5_0);
- (instancetype)my_tableViewPerformActionForRowAtIndexPathWithSenderBlock:(void (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewPerformActionForRowAtIndexPathWithSenderBlock NS_AVAILABLE_IOS(5_0);

// Focus

- (instancetype)my_tableViewCanFocusRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanFocusRowAtIndexPathBlock NS_AVAILABLE_IOS(9_0);
- (instancetype)my_tableViewShouldUpdateFocusInContextBlock:(BOOL (^)(UITableView *tableView, UITableViewFocusUpdateContext *context))my_tableViewShouldUpdateFocusInContextBlock NS_AVAILABLE_IOS(9_0);
- (instancetype)my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock:(void (^)(UITableView *tableView, UITableViewFocusUpdateContext *context, UIFocusAnimationCoordinator *coordinator))my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock NS_AVAILABLE_IOS(9_0);
- (instancetype)my_indexPathForPreferredFocusedViewInTableViewBlock:(nullable NSIndexPath * (^)(UITableView *tableView))my_indexPathForPreferredFocusedViewInTableViewBlock NS_AVAILABLE_IOS(9_0);

//#pragma mark - MJRefreshBlock
//
- (instancetype)my_MJRefreshHeaderInTableViewBlock:(void (^)())my_numberOfSectionsInTableViewBlock; //
- (instancetype)my_MJRefreshFooterInTableViewBlock:(void (^)())my_numberOfSectionsInTableViewBlock; //

@end


NS_ASSUME_NONNULL_END
