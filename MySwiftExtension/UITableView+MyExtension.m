//
//  ViewController.swift
//  table
//
//  Created by 马耀 on 16/9/9.
//  Copyright © 2016年 mayao. All rights reserved.
//

#import "UITableView+MyExtension.h"
#import <objc/runtime.h>
#import "MJRefresh.h"
@implementation UITableView (MyExtension)

#pragma mark - 重写UITableViewDataSource
+ (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.my_tableViewNumberOfRowsInSectionBlock) {
        return tableView.my_tableViewNumberOfRowsInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [dataSource tableView:tableView numberOfRowsInSection:section];
    }
    
    return 0;
}

+ (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewCellForRowAtIndexPathBlock) {
        return tableView.my_tableViewCellForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    NSAssert(tableView.my_tableViewCellForRowAtIndexPathBlock, @"my_tableViewCellForRowAtIndexPathBlock must be set to return to UITableViewCell!!!");
    return nil;
}

+ (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView.my_numberOfSectionsInTableViewBlock) {
        return tableView.my_numberOfSectionsInTableViewBlock(tableView);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [dataSource numberOfSectionsInTableView:tableView];
    }

    return 1; // 默认是1组
}

+ (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.my_tableViewTitleForHeaderInSectionBlock) {
        return tableView.my_tableViewTitleForHeaderInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [dataSource tableView:tableView titleForHeaderInSection:section];
    }
    
    return nil;
}

+ (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (tableView.my_tableViewTitleForFooterInSectionBlock) {
        return tableView.my_tableViewTitleForFooterInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [dataSource tableView:tableView titleForFooterInSection:section];
    }
    
    return nil;
}

+ (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewCanEditRowAtIndexPathBlock) {
        return tableView.my_tableViewCanEditRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:canEditRowAtIndexPath:)]) {
        return [dataSource tableView:tableView canEditRowAtIndexPath:indexPath];
    }
    
    return YES; // 默认可编辑
}

+ (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewCanMoveRowAtIndexPathBlock) {
        return tableView.my_tableViewCanMoveRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:canMoveRowAtIndexPath:)]) {
        return [dataSource tableView:tableView canMoveRowAtIndexPath:indexPath];
    }
    
    return YES; // 默认允许重新排序附属视图选择为一个特定的行显示
}

//+ (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView __TVOS_PROHIBITED {
//    if (tableView.my_sectionIndexTitlesForTableViewBlock) {
//        return tableView.my_sectionIndexTitlesForTableViewBlock(tableView);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
//    
//    if ([dataSource respondsToSelector:@selector(sectionIndexTitlesForTableView:)]) {
//        return [dataSource sectionIndexTitlesForTableView:tableView];
//    }
//    
//    return nil;
//}

//+ (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index __TVOS_PROHIBITED {
//    if (tableView.my_tableViewSectionForSectionIndexTitleAtIndexBlock) {
//        return tableView.my_tableViewSectionForSectionIndexTitleAtIndexBlock(tableView, title, index);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:sectionForSectionIndexTitle:atIndex:)]) {
//        return [dataSource tableView:tableView sectionForSectionIndexTitle:title atIndex:index];
//    }
//    
//    return 0;
//}

+ (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewCommitEditingStyleForRowAtIndexPathBlock) {
        return tableView.my_tableViewCommitEditingStyleForRowAtIndexPathBlock(tableView, editingStyle, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        return [dataSource tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

+ (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (tableView.my_tableViewMoveRowAtIndexPathToIndexPathBlock) {
        return tableView.my_tableViewMoveRowAtIndexPathToIndexPathBlock(tableView, sourceIndexPath, destinationIndexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDataSourceKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:moveRowAtIndexPath:toIndexPath:)]) {
        return [dataSource tableView:tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    }
}

#pragma mark - UITableViewDataSourceBlcok
//_______________________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)
static const void *UITableViewDataSourceKey                          = &UITableViewDataSourceKey;

static const void *UITableViewNumberOfRowsInSectionKey               = &UITableViewNumberOfRowsInSectionKey;
static const void *UITableViewCellForRowAtIndexPathKey               = &UITableViewCellForRowAtIndexPathKey;
static const void *UITableViewNumberOfSectionsInTableViewKey         = &UITableViewNumberOfSectionsInTableViewKey;
static const void *UITableViewTitleForHeaderInSectionKey             = &UITableViewTitleForHeaderInSectionKey;
static const void *UITableViewTitleForFooterInSectionKey             = &UITableViewTitleForFooterInSectionKey;
static const void *UITableViewCanEditRowAtIndexPathKey               = &UITableViewCanEditRowAtIndexPathKey;
static const void *UITableViewCanMoveRowAtIndexPathKey               = &UITableViewCanMoveRowAtIndexPathKey;
//static const void *UITableViewSectionIndexTitlesForTableViewKey      = &UITableViewSectionIndexTitlesForTableViewKey;
//static const void *UITableViewSectionForSectionIndexTitleAtIndexKey  = &UITableViewSectionForSectionIndexTitleAtIndexKey;
static const void *UITableViewCommitEditingStyleForRowAtIndexPathKey = &UITableViewCommitEditingStyleForRowAtIndexPathKey;
static const void *UITableViewMoveRowAtIndexPathToIndexPathKey       = &UITableViewMoveRowAtIndexPathToIndexPathKey;

/******* @required *******/
- (NSInteger (^)(UITableView *tableView, NSInteger section))my_tableViewNumberOfRowsInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewNumberOfRowsInSectionKey);
}

- (instancetype)my_tableViewNumberOfRowsInSectionBlock:(NSInteger (^)(UITableView *tableView, NSInteger section))my_tableViewNumberOfRowsInSectionBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewNumberOfRowsInSectionKey, my_tableViewNumberOfRowsInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
- (UITableViewCell * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCellForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewCellForRowAtIndexPathKey);
}

- (instancetype)my_tableViewCellForRowAtIndexPathBlock:(UITableViewCell * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCellForRowAtIndexPathBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewCellForRowAtIndexPathKey, my_tableViewCellForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

/******* @optional *******/
- (NSInteger (^)(UITableView *tableView))my_numberOfSectionsInTableViewBlock {
    return objc_getAssociatedObject(self, UITableViewNumberOfSectionsInTableViewKey);
}

- (instancetype)my_numberOfSectionsInTableViewBlock:(NSInteger (^)(UITableView *tableView))my_numberOfSectionsInTableViewBlock { // Default is 1 if not implemented
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewNumberOfSectionsInTableViewKey, my_numberOfSectionsInTableViewBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForHeaderInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewTitleForHeaderInSectionKey);
}

// fixed font style. use custom view (UILabel) if you want something different
- (instancetype)my_tableViewTitleForHeaderInSectionBlock:(NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForHeaderInSectionBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewTitleForHeaderInSectionKey, my_tableViewTitleForHeaderInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForFooterInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewTitleForFooterInSectionKey);
}

- (instancetype)my_tableViewTitleForFooterInSectionBlock:(NSString * (^)(UITableView *tableView, NSInteger section))my_tableViewTitleForFooterInSectionBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewTitleForFooterInSectionKey, my_tableViewTitleForFooterInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanEditRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewCanEditRowAtIndexPathKey);
}

- (instancetype)my_tableViewCanEditRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanEditRowAtIndexPathBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewCanEditRowAtIndexPathKey, my_tableViewCanEditRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanMoveRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewCanMoveRowAtIndexPathKey);
}

- (instancetype)my_tableViewCanMoveRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanMoveRowAtIndexPathBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewCanMoveRowAtIndexPathKey, my_tableViewCanMoveRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Index

// return list of section titles to display in section index view (e.g. "ABCD...Z#")
//- (NSArray<NSString *> * (^)(UITableView *tableView))my_sectionIndexTitlesForTableViewBlock {
//    return objc_getAssociatedObject(self, UITableViewSectionIndexTitlesForTableViewKey);
//}

//- (instancetype)my_sectionIndexTitlesForTableViewBlock:(NSArray<NSString *> * (^)(UITableView *tableView))my_sectionIndexTitlesForTableViewBlock __TVOS_PROHIBITED {
//    [self my_setDataSourceIfDataSourceSet];
//    objc_setAssociatedObject(self, UITableViewSectionIndexTitlesForTableViewKey, my_sectionIndexTitlesForTableViewBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

// tell table which section corresponds to section title/index (e.g. "B",1))
//- (NSInteger (^)(UITableView *tableView, NSString *title, NSInteger index))my_tableViewSectionForSectionIndexTitleAtIndexBlock {
//    return objc_getAssociatedObject(self, UITableViewSectionForSectionIndexTitleAtIndexKey);
//}

//- (instancetype)my_tableViewSectionForSectionIndexTitleAtIndexBlock:(NSInteger (^)(UITableView *tableView, NSString *title, NSInteger index))my_tableViewSectionForSectionIndexTitleAtIndexBlock __TVOS_PROHIBITED {
//    [self my_setDataSourceIfDataSourceSet];
//    objc_setAssociatedObject(self, UITableViewSectionForSectionIndexTitleAtIndexKey, my_tableViewSectionForSectionIndexTitleAtIndexBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
// Not called for edit actions using UITableViewRowAction - the action's handler will be invoked instead
- (void (^)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath))my_tableViewCommitEditingStyleForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewCommitEditingStyleForRowAtIndexPathKey);
}

- (instancetype)my_tableViewCommitEditingStyleForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCellEditingStyle editingStyle, NSIndexPath *indexPath))my_tableViewCommitEditingStyleForRowAtIndexPathBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewCommitEditingStyleForRowAtIndexPathKey, my_tableViewCommitEditingStyleForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Data manipulation - reorder / moving support
- (void (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath))my_tableViewMoveRowAtIndexPathToIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewMoveRowAtIndexPathToIndexPathKey);
}

- (instancetype)my_tableViewMoveRowAtIndexPathToIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *destinationIndexPath))my_tableViewMoveRowAtIndexPathToIndexPathBlock {
    [self my_setDataSourceIfDataSourceSet];
    objc_setAssociatedObject(self, UITableViewMoveRowAtIndexPathToIndexPathKey, my_tableViewMoveRowAtIndexPathToIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

/**
 *  避免使用UITableView-block而没有设置dataSource将自己设置为dataSource
 */
- (void)my_setDataSourceIfDataSourceSet {
    if (self.dataSource != (id<UITableViewDataSource>)[self class]) {
        objc_setAssociatedObject(self, UITableViewDataSourceKey, self.dataSource, OBJC_ASSOCIATION_ASSIGN);
        self.dataSource = (id<UITableViewDataSource>)[self class];
    }
}

#pragma mark - 重写UITableViewDelegate
+ (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewWillDisplayCellForRowAtIndexPathBlock) {
        return tableView.my_tableViewWillDisplayCellForRowAtIndexPathBlock(tableView, cell, indexPath);
    }

    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        return [dataSource tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

+ (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewWillDisplayHeaderViewForSectionBlock) {
        return tableView.my_tableViewWillDisplayHeaderViewForSectionBlock(tableView, view, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        return [dataSource tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

+ (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewWillDisplayFooterViewForSectionBlock) {
        return tableView.my_tableViewWillDisplayFooterViewForSectionBlock(tableView, view, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        return [dataSource tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

+ (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock) {
        return tableView.my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock(tableView, cell, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        return [dataSource tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

+ (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewDidEndDisplayingHeaderViewForSectionBlock) {
        return tableView.my_tableViewDidEndDisplayingHeaderViewForSectionBlock(tableView, view, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didEndDisplayingHeaderView:forSection:)]) {
        return [dataSource tableView:tableView didEndDisplayingHeaderView:view forSection:section];
    }
}

+ (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewDidEndDisplayingFooterViewForSectionBlock) {
        return tableView.my_tableViewDidEndDisplayingFooterViewForSectionBlock(tableView, view, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didEndDisplayingFooterView:forSection:)]) {
        return [dataSource tableView:tableView didEndDisplayingFooterView:view forSection:section];
    }
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewHeightForRowAtIndexPathBlock) {
        return tableView.my_tableViewHeightForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [dataSource tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    
    return tableView.rowHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView.my_tableViewHeightForHeaderInSectionBlock) {
        return tableView.my_tableViewHeightForHeaderInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [dataSource tableView:tableView heightForHeaderInSection:section];
    }
    
    return tableView.sectionHeaderHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView.my_tableViewHeightForFooterInSectionBlock) {
        return tableView.my_tableViewHeightForFooterInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [dataSource tableView:tableView heightForFooterInSection:section];
    }
    
    return tableView.sectionFooterHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0) {
    if (tableView.my_tableViewEstimatedHeightForRowAtIndexPathBlock) {
        return tableView.my_tableViewEstimatedHeightForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        return [dataSource tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    
    return tableView.estimatedRowHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
    if (tableView.my_tableViewEstimatedHeightForHeaderInSectionBlock) {
        return tableView.my_tableViewEstimatedHeightForHeaderInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:estimatedHeightForHeaderInSection:)]) {
        return [dataSource tableView:tableView estimatedHeightForHeaderInSection:section];
    }
    
    return 1; // tableView.estimatedSectionHeaderHeight;
}

+ (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0) {
    if (tableView.my_tableViewEstimatedHeightForFooterInSectionBlock) {
        return tableView.my_tableViewEstimatedHeightForFooterInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:estimatedHeightForFooterInSection:)]) {
        return [dataSource tableView:tableView estimatedHeightForFooterInSection:section];
    }
    
    return 1; // tableView.estimatedSectionFooterHeight;
}

+ (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView.my_tableViewViewForHeaderInSectionBlock) {
        return tableView.my_tableViewViewForHeaderInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [dataSource tableView:tableView viewForHeaderInSection:section];
    }
    
    return nil;
}

+ (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (tableView.my_tableViewViewForFooterInSectionBlock) {
        return tableView.my_tableViewViewForFooterInSectionBlock(tableView, section);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [dataSource tableView:tableView viewForFooterInSection:section];
    }
    
    return nil;
}

//+ (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED {
//    if (tableView.my_tableViewAccessoryTypeForRowWithIndexPathBlock) {
//        return tableView.my_tableViewAccessoryTypeForRowWithIndexPathBlock(tableView, indexPath);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:accessoryTypeForRowWithIndexPath:)]) {
//        return [dataSource tableView:tableView accessoryTypeForRowWithIndexPath:indexPath];
//    }
//    
//    return UITableViewCellAccessoryNone; // 默认为none
//}

+ (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock) {
        return tableView.my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        return [dataSource tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

+ (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewShouldHighlightRowAtIndexPathBlock) {
        return tableView.my_tableViewShouldHighlightRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:shouldHighlightRowAtIndexPath:)]) {
        return [dataSource tableView:tableView shouldHighlightRowAtIndexPath:indexPath];
    }
    
    return YES;
}

+ (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewDidHighlightRowAtIndexPathBlock) {
        return tableView.my_tableViewDidHighlightRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didHighlightRowAtIndexPath:)]) {
        return [dataSource tableView:tableView didHighlightRowAtIndexPath:indexPath];
    }
}

+ (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(6_0) {
    if (tableView.my_tableViewDidUnhighlightRowAtIndexPathBlock) {
        return tableView.my_tableViewDidUnhighlightRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didUnhighlightRowAtIndexPath:)]) {
        return [dataSource tableView:tableView didUnhighlightRowAtIndexPath:indexPath];
    }
}

+ (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewWillSelectRowAtIndexPathBlock) {
        return tableView.my_tableViewWillSelectRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        return [dataSource tableView:tableView willSelectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

+ (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    if (tableView.my_tableViewWillDeselectRowAtIndexPathBlock) {
        return tableView.my_tableViewWillDeselectRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:willDeselectRowAtIndexPath:)]) {
        return [dataSource tableView:tableView willDeselectRowAtIndexPath:indexPath];
    }
    
    return indexPath;
}

+ (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewDidSelectRowAtIndexPathBlock) {
        return tableView.my_tableViewDidSelectRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [dataSource tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

+ (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    if (tableView.my_tableViewDidDeselectRowAtIndexPathBlock) {
        return tableView.my_tableViewDidDeselectRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        return [dataSource tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

+ (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewEditingStyleForRowAtIndexPathBlock) {
        return tableView.my_tableViewEditingStyleForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [dataSource tableView:tableView editingStyleForRowAtIndexPath:indexPath];
    }
    
    return UITableViewCellEditingStyleNone;
}

//+ (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
//    if (tableView.my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock) {
//        return tableView.my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock(tableView, indexPath);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:titleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
//        return [dataSource tableView:tableView titleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
//    }
//    
//    return nil;
//}

//+ (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED {
//    if (tableView.my_tableViewEditActionsForRowAtIndexPathBlock) {
//        return tableView.my_tableViewEditActionsForRowAtIndexPathBlock(tableView, indexPath);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:editActionsForRowAtIndexPath:)]) {
//        return [dataSource tableView:tableView editActionsForRowAtIndexPath:indexPath];
//    }
//    
//    return nil;
//}

+ (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock) {
        return tableView.my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:shouldIndentWhileEditingRowAtIndexPath:)]) {
        return [dataSource tableView:tableView shouldIndentWhileEditingRowAtIndexPath:indexPath];
    }
    
    return YES;
}

//+ (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED {
//    if (tableView.my_tableViewWillBeginEditingRowAtIndexPathBlock) {
//        return tableView.my_tableViewWillBeginEditingRowAtIndexPathBlock(tableView, indexPath);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
//        return [dataSource tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
//    }
//}

//+ (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath __TVOS_PROHIBITED {
//    if (tableView.my_tableViewDidEndEditingRowAtIndexPathBlock) {
//        return tableView.my_tableViewDidEndEditingRowAtIndexPathBlock(tableView, indexPath);
//    }
//    
//    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
//    
//    if ([dataSource respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
//        return [dataSource tableView:tableView didEndEditingRowAtIndexPath:indexPath];
//    }
//}

+ (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (tableView.my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock) {
        return tableView.my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock(tableView, sourceIndexPath, proposedDestinationIndexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:targetIndexPathForMoveFromRowAtIndexPath:toProposedIndexPath:)]) {
        return [dataSource tableView:tableView targetIndexPathForMoveFromRowAtIndexPath:sourceIndexPath toProposedIndexPath:proposedDestinationIndexPath];
    }
    
    NSAssert(tableView.my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock, @"my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock must be set to return to NSIndexPath!!!");
    return nil;
}

+ (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView.my_tableViewIndentationLevelForRowAtIndexPathBlock) {
        return tableView.my_tableViewIndentationLevelForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:indentationLevelForRowAtIndexPath:)]) {
        return [dataSource tableView:tableView indentationLevelForRowAtIndexPath:indexPath];
    }
    
    return 0;
}

+ (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(5_0) {
    if (tableView.my_tableViewShouldShowMenuForRowAtIndexPathBlock) {
        return tableView.my_tableViewShouldShowMenuForRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:shouldShowMenuForRowAtIndexPath:)]) {
        return [dataSource tableView:tableView shouldShowMenuForRowAtIndexPath:indexPath];
    }
    
    return NO; // 默认不显示编辑菜单
}

+ (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    if (tableView.my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock) {
        return tableView.my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock(tableView, action, indexPath, sender);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:canPerformAction:forRowAtIndexPath:withSender:)]) {
        return [dataSource tableView:tableView canPerformAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
    
    return NO; // 默认不能执行每一行菜单方法
}

+ (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender NS_AVAILABLE_IOS(5_0) {
    if (tableView.my_tableViewPerformActionForRowAtIndexPathWithSenderBlock) {
        return tableView.my_tableViewPerformActionForRowAtIndexPathWithSenderBlock(tableView, action, indexPath, sender);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:performAction:forRowAtIndexPath:withSender:)]) {
        return [dataSource tableView:tableView performAction:action forRowAtIndexPath:indexPath withSender:sender];
    }
}

+ (BOOL)tableView:(UITableView *)tableView canFocusRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0) {
    if (tableView.my_tableViewCanFocusRowAtIndexPathBlock) {
        return tableView.my_tableViewCanFocusRowAtIndexPathBlock(tableView, indexPath);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:canFocusRowAtIndexPath:)]) {
        return [dataSource tableView:tableView canFocusRowAtIndexPath:indexPath];
    }
    
    return YES;
}

+ (BOOL)tableView:(UITableView *)tableView shouldUpdateFocusInContext:(UITableViewFocusUpdateContext *)context NS_AVAILABLE_IOS(9_0) {
    if (tableView.my_tableViewShouldUpdateFocusInContextBlock) {
        return tableView.my_tableViewShouldUpdateFocusInContextBlock(tableView, context);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:shouldUpdateFocusInContext:)]) {
        return [dataSource tableView:tableView shouldUpdateFocusInContext:context];
    }
    
    return YES;
}

+ (void)tableView:(UITableView *)tableView didUpdateFocusInContext:(UITableViewFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator NS_AVAILABLE_IOS(9_0) {
    if (tableView.my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock) {
        return tableView.my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock(tableView, context, coordinator);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(tableView:didUpdateFocusInContext:withAnimationCoordinator:)]) {
        return [dataSource tableView:tableView didUpdateFocusInContext:context withAnimationCoordinator:coordinator];
    }
}

+ (nullable NSIndexPath *)indexPathForPreferredFocusedViewInTableView:(UITableView *)tableView NS_AVAILABLE_IOS(9_0) {
    if (tableView.my_indexPathForPreferredFocusedViewInTableViewBlock) {
        return tableView.my_indexPathForPreferredFocusedViewInTableViewBlock(tableView);
    }
    
    id dataSource = objc_getAssociatedObject(self, UITableViewDelegateKey);
    
    if ([dataSource respondsToSelector:@selector(indexPathForPreferredFocusedViewInTableView:)]) {
        return [dataSource indexPathForPreferredFocusedViewInTableView:tableView];
    }
    
    return nil;
}

#pragma mark - UITableViewDelegateBlock
//_______________________________________________________________________________________________________________
// this represents the display and behaviour of the cells.
static const void *UITableViewDelegateKey                                          = &UITableViewDelegateKey;

static const void *UITableViewWillDisplayCellForRowAtIndexPathKey                  = &UITableViewWillDisplayCellForRowAtIndexPathKey;
static const void *UITableViewWillDisplayHeaderViewForSectionKey                   = &UITableViewWillDisplayHeaderViewForSectionKey;
static const void *UITableViewWillDisplayFooterViewForSectionKey                   = &UITableViewWillDisplayFooterViewForSectionKey;
static const void *UITableViewDidEndDisplayingCellForRowAtIndexPathKey             = &UITableViewDidEndDisplayingCellForRowAtIndexPathKey;
static const void *UITableViewDidEndDisplayingHeaderViewForSectionKey              = &UITableViewDidEndDisplayingHeaderViewForSectionKey;
static const void *UITableViewDidEndDisplayingFooterViewForSectionKey              = &UITableViewDidEndDisplayingFooterViewForSectionKey;
static const void *UITableViewHeightForRowAtIndexPathKey                           = &UITableViewHeightForRowAtIndexPathKey;
static const void *UITableViewHeightForHeaderInSectionKey                          = &UITableViewHeightForHeaderInSectionKey;
static const void *UITableViewHeightForFooterInSectionKey                          = &UITableViewHeightForFooterInSectionKey;
static const void *UITableViewEstimatedHeightForRowAtIndexPathKey                  = &UITableViewEstimatedHeightForRowAtIndexPathKey;
static const void *UITableViewEstimatedHeightForHeaderInSectionKey                 = &UITableViewEstimatedHeightForHeaderInSectionKey;
static const void *UITableViewEstimatedHeightForFooterInSectionKey                 = &UITableViewEstimatedHeightForFooterInSectionKey;
static const void *UITableViewViewForHeaderInSectionKey                            = &UITableViewViewForHeaderInSectionKey;
static const void *UITableViewViewForFooterInSectionKey                            = &UITableViewViewForFooterInSectionKey;
//static const void *UITableViewAccessoryTypeForRowWithIndexPathKey                  = &UITableViewAccessoryTypeForRowWithIndexPathKey;
static const void *UITableViewAccessoryButtonTappedForRowWithIndexPathKey          = &UITableViewAccessoryButtonTappedForRowWithIndexPathKey;
static const void *UITableViewShouldHighlightRowAtIndexPathKey                     = &UITableViewShouldHighlightRowAtIndexPathKey;
static const void *UITableViewDidHighlightRowAtIndexPathKey                        = &UITableViewDidHighlightRowAtIndexPathKey;
static const void *UITableViewDidUnhighlightRowAtIndexPathKey                      = &UITableViewDidUnhighlightRowAtIndexPathKey;
static const void *UITableViewWillSelectRowAtIndexPathKey                          = &UITableViewWillSelectRowAtIndexPathKey;
static const void *UITableViewWillDeselectRowAtIndexPathKey                        = &UITableViewWillDeselectRowAtIndexPathKey;
static const void *UITableViewDidSelectRowAtIndexPathKey                           = &UITableViewDidSelectRowAtIndexPathKey;
static const void *UITableViewDidDeselectRowAtIndexPathKey                         = &UITableViewDidDeselectRowAtIndexPathKey;
static const void *UITableViewEditingStyleForRowAtIndexPathKey                     = &UITableViewEditingStyleForRowAtIndexPathKey;
//static const void *UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathKey = &UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathKey;
//static const void *UITableViewEditActionsForRowAtIndexPathKey                      = &UITableViewEditActionsForRowAtIndexPathKey;
static const void *UITableViewShouldIndentWhileEditingRowAtIndexPathKey            = &UITableViewShouldIndentWhileEditingRowAtIndexPathKey;
//static const void *UITableViewWillBeginEditingRowAtIndexPathKey                    = &UITableViewWillBeginEditingRowAtIndexPathKey;
//static const void *UITableViewDidEndEditingRowAtIndexPathKey                       = &UITableViewDidEndEditingRowAtIndexPathKey;
static const void *UITableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathKey = &UITableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathKey;
static const void *UITableViewIndentationLevelForRowAtIndexPathKey                 = &UITableViewIndentationLevelForRowAtIndexPathKey;
static const void *UITableViewShouldShowMenuForRowAtIndexPathKey                   = &UITableViewShouldShowMenuForRowAtIndexPathKey;
static const void *UITableViewCanPerformActionForRowAtIndexPathWithSenderKey       = &UITableViewCanPerformActionForRowAtIndexPathWithSenderKey;
static const void *UITableViewPerformActionForRowAtIndexPathWithSenderKey          = &UITableViewPerformActionForRowAtIndexPathWithSenderKey;
static const void *UITableViewCanFocusRowAtIndexPathKey                            = &UITableViewCanFocusRowAtIndexPathKey;
static const void *UITableViewShouldUpdateFocusInContextKey                        = &UITableViewShouldUpdateFocusInContextKey;
static const void *UITableViewDidUpdateFocusInContextWithAnimationCoordinatorKey   = &UITableViewDidUpdateFocusInContextWithAnimationCoordinatorKey;
static const void *UITableViewIndexPathForPreferredFocusedViewInTableViewKey       = &UITableViewIndexPathForPreferredFocusedViewInTableViewKey;

/******* @optional *******/
// Display customization
- (void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewWillDisplayCellForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewWillDisplayCellForRowAtIndexPathKey);
}

- (instancetype)my_tableViewWillDisplayCellForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewWillDisplayCellForRowAtIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewWillDisplayCellForRowAtIndexPathKey, my_tableViewWillDisplayCellForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayHeaderViewForSectionBlock {
    return objc_getAssociatedObject(self, UITableViewWillDisplayHeaderViewForSectionKey);
}

- (instancetype)my_tableViewWillDisplayHeaderViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayHeaderViewForSectionBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewWillDisplayHeaderViewForSectionKey, my_tableViewWillDisplayHeaderViewForSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayFooterViewForSectionBlock {
    return objc_getAssociatedObject(self, UITableViewWillDisplayFooterViewForSectionKey);
}

- (instancetype)my_tableViewWillDisplayFooterViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewWillDisplayFooterViewForSectionBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewWillDisplayFooterViewForSectionKey, my_tableViewWillDisplayFooterViewForSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewDidEndDisplayingCellForRowAtIndexPathKey);
}

- (instancetype)my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock:(void (^)(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath))my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidEndDisplayingCellForRowAtIndexPathKey, my_tableViewDidEndDisplayingCellForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingHeaderViewForSectionBlock {
    return objc_getAssociatedObject(self, UITableViewDidEndDisplayingHeaderViewForSectionKey);
}

- (instancetype)my_tableViewDidEndDisplayingHeaderViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingHeaderViewForSectionBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidEndDisplayingHeaderViewForSectionKey, my_tableViewDidEndDisplayingHeaderViewForSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingFooterViewForSectionBlock {
    return objc_getAssociatedObject(self, UITableViewDidEndDisplayingFooterViewForSectionKey);
}

- (instancetype)my_tableViewDidEndDisplayingFooterViewForSectionBlock:(void (^)(UITableView *tableView, UIView *view, NSInteger section))my_tableViewDidEndDisplayingFooterViewForSectionBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidEndDisplayingFooterViewForSectionKey, my_tableViewDidEndDisplayingFooterViewForSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Variable height support
- (CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewHeightForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewHeightForRowAtIndexPathKey);
}

- (instancetype)my_tableViewHeightForRowAtIndexPathBlock:(CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewHeightForRowAtIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewHeightForRowAtIndexPathKey, my_tableViewHeightForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForHeaderInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewHeightForHeaderInSectionKey);
}

- (instancetype)my_tableViewHeightForHeaderInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForHeaderInSectionBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewHeightForHeaderInSectionKey, my_tableViewHeightForHeaderInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForFooterInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewHeightForFooterInSectionKey);
}

- (instancetype)my_tableViewHeightForFooterInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewHeightForFooterInSectionBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewHeightForFooterInSectionKey, my_tableViewHeightForFooterInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Use the estimatedHeight methods to quickly calcuate guessed values which will allow for fast load times of the table.
// If these methods are implemented, the above -tableView:heightForXXX calls will be deferred until views are ready to be displayed, so more expensive logic can be placed there.
- (CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEstimatedHeightForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewEstimatedHeightForRowAtIndexPathKey);
}

- (instancetype)my_tableViewEstimatedHeightForRowAtIndexPathBlock:(CGFloat (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEstimatedHeightForRowAtIndexPathBlock NS_AVAILABLE_IOS(7_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewEstimatedHeightForRowAtIndexPathKey, my_tableViewEstimatedHeightForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForHeaderInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewEstimatedHeightForHeaderInSectionKey);
}

- (instancetype)my_tableViewEstimatedHeightForHeaderInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForHeaderInSectionBlock NS_AVAILABLE_IOS(7_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewEstimatedHeightForHeaderInSectionKey, my_tableViewEstimatedHeightForHeaderInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForFooterInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewEstimatedHeightForFooterInSectionKey);
}

- (instancetype)my_tableViewEstimatedHeightForFooterInSectionBlock:(CGFloat (^)(UITableView *tableView, NSInteger section))my_tableViewEstimatedHeightForFooterInSectionBlock NS_AVAILABLE_IOS(7_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewEstimatedHeightForFooterInSectionKey, my_tableViewEstimatedHeightForFooterInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Section header & footer information. Views are preferred over title should you decide to provide both
- (nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForHeaderInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewViewForHeaderInSectionKey);
}

- (instancetype)my_tableViewViewForHeaderInSectionBlock:(nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForHeaderInSectionBlock { // custom view for header. will be adjusted to default or specified header height
    objc_setAssociatedObject(self, UITableViewViewForHeaderInSectionKey, my_tableViewViewForHeaderInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForFooterInSectionBlock {
    return objc_getAssociatedObject(self, UITableViewViewForFooterInSectionKey);
}

- (instancetype)my_tableViewViewForFooterInSectionBlock:(nullable UIView * (^)(UITableView *tableView, NSInteger section))my_tableViewViewForFooterInSectionBlock { // custom view for footer. will be adjusted to default or specified footer height
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewViewForFooterInSectionKey, my_tableViewViewForFooterInSectionBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Accessories (disclosures).
//- (UITableViewCellAccessoryType (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryTypeForRowWithIndexPathBlock {
//    return objc_getAssociatedObject(self, UITableViewAccessoryTypeForRowWithIndexPathKey);
//}
//
//- (instancetype)my_tableViewAccessoryTypeForRowWithIndexPathBlock:(UITableViewCellAccessoryType (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryTypeForRowWithIndexPathBlock NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED {
//    [self my_setDelegateIfDelegateSet];
//    objc_setAssociatedObject(self, UITableViewAccessoryTypeForRowWithIndexPathKey, my_tableViewAccessoryTypeForRowWithIndexPathBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewAccessoryButtonTappedForRowWithIndexPathKey);
}

- (instancetype)my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewAccessoryButtonTappedForRowWithIndexPathKey, my_tableViewAccessoryButtonTappedForRowWithIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Selection

// -tableView:shouldHighlightRowAtIndexPath: is called when a touch comes down on a row.
// Returning NO to that message halts the selection process and does not cause the currently selected row to lose its selected look while the touch is down.
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldHighlightRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewShouldHighlightRowAtIndexPathKey);
}

- (instancetype)my_tableViewShouldHighlightRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldHighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewShouldHighlightRowAtIndexPathKey, my_tableViewShouldHighlightRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidHighlightRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewDidHighlightRowAtIndexPathKey);
}

- (instancetype)my_tableViewDidHighlightRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidHighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidHighlightRowAtIndexPathKey, my_tableViewDidHighlightRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidUnhighlightRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewDidUnhighlightRowAtIndexPathKey);
}

- (instancetype)my_tableViewDidUnhighlightRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidUnhighlightRowAtIndexPathBlock NS_AVAILABLE_IOS(6_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidUnhighlightRowAtIndexPathKey, my_tableViewDidUnhighlightRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillSelectRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewWillSelectRowAtIndexPathKey);
}

- (instancetype)my_tableViewWillSelectRowAtIndexPathBlock:(nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillSelectRowAtIndexPathBlock {
    objc_setAssociatedObject(self, UITableViewWillSelectRowAtIndexPathKey, my_tableViewWillSelectRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillDeselectRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewWillDeselectRowAtIndexPathKey);
}

- (instancetype)my_tableViewWillDeselectRowAtIndexPathBlock:(nullable NSIndexPath * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillDeselectRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewWillDeselectRowAtIndexPathKey, my_tableViewWillDeselectRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Called after the user changes the selection.
- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidSelectRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewDidSelectRowAtIndexPathKey);
}

- (instancetype)my_tableViewDidSelectRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidSelectRowAtIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidSelectRowAtIndexPathKey, my_tableViewDidSelectRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidDeselectRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewDidDeselectRowAtIndexPathKey);
}

- (instancetype)my_tableViewDidDeselectRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidDeselectRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidDeselectRowAtIndexPathKey, my_tableViewDidDeselectRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditingStyleForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewEditingStyleForRowAtIndexPathKey);
}

- (instancetype)my_tableViewEditingStyleForRowAtIndexPathBlock:(UITableViewCellEditingStyle (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditingStyleForRowAtIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewEditingStyleForRowAtIndexPathKey, my_tableViewEditingStyleForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

//- (nullable NSString * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock {
//    return objc_getAssociatedObject(self, UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathKey);
//}

//- (instancetype)my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock:(nullable NSString * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock NS_AVAILABLE_IOS(3_0) __TVOS_PROHIBITED {
//    [self my_setDelegateIfDelegateSet];
//    objc_setAssociatedObject(self, UITableViewTitleForDeleteConfirmationButtonForRowAtIndexPathKey, my_tableViewTitleForDeleteConfirmationButtonForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

//- (nullable NSArray<UITableViewRowAction *> * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditActionsForRowAtIndexPathBlock {
//    return objc_getAssociatedObject(self, UITableViewEditActionsForRowAtIndexPathKey);
//}

//- (instancetype)my_tableViewEditActionsForRowAtIndexPathBlock:(nullable NSArray<UITableViewRowAction *> * (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewEditActionsForRowAtIndexPathBlock NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED { // supercedes -tableView:titleForDeleteConfirmationButtonForRowAtIndexPath: if return value is non-nil
//    [self my_setDelegateIfDelegateSet];
//    objc_setAssociatedObject(self, UITableViewEditActionsForRowAtIndexPathKey, my_tableViewEditActionsForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewShouldIndentWhileEditingRowAtIndexPathKey);
}

- (instancetype)my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewShouldIndentWhileEditingRowAtIndexPathKey, my_tableViewShouldIndentWhileEditingRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
//- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillBeginEditingRowAtIndexPathBlock {
//    return objc_getAssociatedObject(self, UITableViewWillBeginEditingRowAtIndexPathKey);
//}

//- (instancetype)my_tableViewWillBeginEditingRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewWillBeginEditingRowAtIndexPathBlock __TVOS_PROHIBITED {
//    [self my_setDelegateIfDelegateSet];
//    objc_setAssociatedObject(self, UITableViewWillBeginEditingRowAtIndexPathKey, my_tableViewWillBeginEditingRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

//- (void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidEndEditingRowAtIndexPathBlock {
//    return objc_getAssociatedObject(self, UITableViewDidEndEditingRowAtIndexPathKey);
//}

//- (instancetype)my_tableViewDidEndEditingRowAtIndexPathBlock:(void (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewDidEndEditingRowAtIndexPathBlock __TVOS_PROHIBITED {
//    [self my_setDelegateIfDelegateSet];
//    objc_setAssociatedObject(self, UITableViewDidEndEditingRowAtIndexPathKey, my_tableViewDidEndEditingRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
//    
//    return self;
//}

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath * (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath))my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathKey);
}

- (instancetype)my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock:(NSIndexPath * (^)(UITableView *tableView, NSIndexPath *sourceIndexPath, NSIndexPath *proposedDestinationIndexPath))my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathKey, my_tableViewTargetIndexPathForMoveFromRowAtIndexPathToProposedIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Indentation
- (NSInteger (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewIndentationLevelForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewIndentationLevelForRowAtIndexPathKey);
}

- (instancetype)my_tableViewIndentationLevelForRowAtIndexPathBlock:(NSInteger (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewIndentationLevelForRowAtIndexPathBlock { // return 'depth' of row for hierarchies
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewIndentationLevelForRowAtIndexPathKey, my_tableViewIndentationLevelForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Copy/Paste.  All three methods must be implemented by the delegate.
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldShowMenuForRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewShouldShowMenuForRowAtIndexPathKey);
}

- (instancetype)my_tableViewShouldShowMenuForRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewShouldShowMenuForRowAtIndexPathBlock NS_AVAILABLE_IOS(5_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewShouldShowMenuForRowAtIndexPathKey, my_tableViewShouldShowMenuForRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (BOOL (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock {
    return objc_getAssociatedObject(self, UITableViewCanPerformActionForRowAtIndexPathWithSenderKey);
}

- (instancetype)my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock:(BOOL (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock NS_AVAILABLE_IOS(5_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewCanPerformActionForRowAtIndexPathWithSenderKey, my_tableViewCanPerformActionForRowAtIndexPathWithSenderBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewPerformActionForRowAtIndexPathWithSenderBlock {
    return objc_getAssociatedObject(self, UITableViewPerformActionForRowAtIndexPathWithSenderKey);
}

- (instancetype)my_tableViewPerformActionForRowAtIndexPathWithSenderBlock:(void (^)(UITableView *tableView, SEL action, NSIndexPath *indexPath, __nullable id sender))my_tableViewPerformActionForRowAtIndexPathWithSenderBlock NS_AVAILABLE_IOS(5_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewPerformActionForRowAtIndexPathWithSenderKey, my_tableViewPerformActionForRowAtIndexPathWithSenderBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

// Focus
- (BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanFocusRowAtIndexPathBlock {
    return objc_getAssociatedObject(self, UITableViewCanFocusRowAtIndexPathKey);
}

- (instancetype)my_tableViewCanFocusRowAtIndexPathBlock:(BOOL (^)(UITableView *tableView, NSIndexPath *indexPath))my_tableViewCanFocusRowAtIndexPathBlock NS_AVAILABLE_IOS(9_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewCanFocusRowAtIndexPathKey, my_tableViewCanFocusRowAtIndexPathBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (BOOL (^)(UITableView *tableView, UITableViewFocusUpdateContext *context))my_tableViewShouldUpdateFocusInContextBlock {
    return objc_getAssociatedObject(self, UITableViewShouldUpdateFocusInContextKey);
}

- (instancetype)my_tableViewShouldUpdateFocusInContextBlock:(BOOL (^)(UITableView *tableView, UITableViewFocusUpdateContext *context))my_tableViewShouldUpdateFocusInContextBlock NS_AVAILABLE_IOS(9_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewShouldUpdateFocusInContextKey, my_tableViewShouldUpdateFocusInContextBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (void (^)(UITableView *tableView, UITableViewFocusUpdateContext *context, UIFocusAnimationCoordinator *coordinator))my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock {
    return objc_getAssociatedObject(self, UITableViewDidUpdateFocusInContextWithAnimationCoordinatorKey);
}

- (instancetype)my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock:(void (^)(UITableView *tableView, UITableViewFocusUpdateContext *context, UIFocusAnimationCoordinator *coordinator))my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock NS_AVAILABLE_IOS(9_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewDidUpdateFocusInContextWithAnimationCoordinatorKey, my_tableViewDidUpdateFocusInContextWithAnimationCoordinatorBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (nullable NSIndexPath * (^)(UITableView *tableView))my_indexPathForPreferredFocusedViewInTableViewBlock {
    return objc_getAssociatedObject(self, UITableViewIndexPathForPreferredFocusedViewInTableViewKey);
}

- (instancetype)my_indexPathForPreferredFocusedViewInTableViewBlock:(nullable NSIndexPath * (^)(UITableView *tableView))my_indexPathForPreferredFocusedViewInTableViewBlock NS_AVAILABLE_IOS(9_0) {
    [self my_setDelegateIfDelegateSet];
    objc_setAssociatedObject(self, UITableViewIndexPathForPreferredFocusedViewInTableViewKey, my_indexPathForPreferredFocusedViewInTableViewBlock, OBJC_ASSOCIATION_COPY);
    
    return self;
}

/**
 *  避免使用UITableView-block而没有设置delegate将自己设置为delegate
 */
- (void)my_setDelegateIfDelegateSet {
    if (self.delegate != (id<UITableViewDelegate>)[self class]) {
        objc_setAssociatedObject(self, UITableViewDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UITableViewDelegate>)[self class];
    }
}

#pragma mark - MJRefreshBlock

- (NSInteger (^)())my_MJRefreshHeaderInTableViewBlock {
    return objc_getAssociatedObject(self, UITableViewMJRefreshHeaderKey);
}

- (instancetype)my_MJRefreshHeaderInTableViewBlock:(void (^)())block {
    [self my_setMJRefreshHeader:^{
        block();
    }];
    objc_setAssociatedObject(self, UITableViewMJRefreshHeaderKey, block, OBJC_ASSOCIATION_COPY);
    
    return self;
}

- (NSInteger (^)())my_MJRefreshFooterInTableViewBlock {
    return objc_getAssociatedObject(self, UITableViewMJRefreshFooterKey);
}


- (instancetype)my_MJRefreshFooterInTableViewBlock:(void (^)())block {
    [self my_setMJRefreshFooter:^{
        block();
    }];
    
    objc_setAssociatedObject(self, UITableViewMJRefreshFooterKey, block, OBJC_ASSOCIATION_COPY);
    
    return self;
}

static const void *UITableViewMJRefreshHeaderKey               = &UITableViewMJRefreshHeaderKey;
static const void *UITableViewMJRefreshFooterKey               = &UITableViewMJRefreshFooterKey;

- (void)my_setMJRefreshHeader:(void (^)())block {
    
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i <= 3 ; i++){
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [arr addObject:image];
    }

    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        block();
    }];
    
    [header setImages:arr forState:MJRefreshStateIdle];
    [header setImages:arr forState:MJRefreshStatePulling];
    [header setImages:arr forState:MJRefreshStateRefreshing];
    self.mj_header = header;
}

- (void)my_setMJRefreshFooter:(void (^)())block {
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 1 ; i <= 3 ; i++){
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [arr addObject:image];
    }
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        block();
    }];
    [footer setImages:arr forState:MJRefreshStateIdle];
    [footer setImages:arr forState:MJRefreshStatePulling];
    [footer setImages:arr forState:MJRefreshStateRefreshing];
    self.mj_footer = footer;

}

@end
