//
//  VSCellDescriptor.h
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef CGFloat (^CellHeightBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^CellWillDisplayBlock)(UITableView* tableView, UITableViewCell* cell, NSIndexPath* indexPath);
typedef UITableViewCell* (^CellConfigureBlock)(UITableView* tableView, NSIndexPath* indexPath);
typedef void (^CellSelectBlock)(UITableView* tableView, NSIndexPath* indexPath);

@interface VSCellDescriptor : NSObject

@property (nonatomic, copy) CellHeightBlock heightBlock;
@property (nonatomic, copy) CellWillDisplayBlock willDisplayBlock;
@property (nonatomic, copy) CellConfigureBlock configureBlock;
@property (nonatomic, copy) CellSelectBlock selectBlock;

-(id) initWithHeight:(CellHeightBlock)heightBlock configure:(CellConfigureBlock)configureBlock;
-(id) initWithHeight:(CellHeightBlock)heightBlock configure:(CellConfigureBlock)configureBlock select:(CellSelectBlock)selectBlock;

// autocompletion tricks
- (void)setHeightBlock:(CellHeightBlock)heightBlock;
- (void)setWillDisplayBlock:(CellWillDisplayBlock)willDisplayBlock;
- (void)setConfigureBlock:(CellConfigureBlock)configureBlock;
- (void)setSelectBlock:(CellSelectBlock)selectBlock;

@end