//
//  VSSectionDescriptor.h
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VSCellDescriptor.h"

typedef CGFloat (^SectionHeaderHeightBlock)(UITableView* tableView, int section);
typedef UIView* (^SectionHeaderConfigureBlock)(UITableView* tableView, int section);

typedef CGFloat (^SectionFooterHeightBlock)(UITableView* tableView, int section);
typedef UIView* (^SectionFooterConfigureBlock)(UITableView* tableView, int section);

typedef NSString* (^SectionHeaderTitleBlock)(UITableView* tableView, int section);
typedef NSString* (^SectionFooterTitleBlock)(UITableView* tableView, int section);


@interface VSSectionDescriptor : NSObject

@property (nonatomic, copy) SectionHeaderHeightBlock heightHeaderBlock;
@property (nonatomic, copy) SectionHeaderConfigureBlock configureHeaderBlock;
@property (nonatomic, copy) SectionFooterHeightBlock heightFooterBlock;
@property (nonatomic, copy) SectionFooterConfigureBlock configureFooterBlock;
@property (nonatomic, copy) SectionHeaderTitleBlock titleHeaderBlock;
@property (nonatomic, copy) SectionFooterTitleBlock titleFooterBlock;

@property (nonatomic,strong,readonly) NSMutableArray* cellDescriptors;

// empty
-(id) initEmpty;
// custome view
-(id) initHeaderSectionWithHeight:(SectionHeaderHeightBlock)heightHeaderBlock configure:(SectionHeaderConfigureBlock)configureHeaderBlock;
-(id) initHeaderSectionWithHeight:(SectionHeaderHeightBlock)heightHeaderBlock configure:(SectionHeaderConfigureBlock)configureHeaderBlock andFooterSectionWithHeight:(SectionFooterHeightBlock)heightFooterBlock configure:(SectionFooterConfigureBlock)configureFooterBlock;
// default view (only label)
-(id) initHeaderSectionWithTitle:(SectionHeaderTitleBlock)titleHeaderBlock;
-(id) initHeaderSectionWithTitle:(SectionHeaderTitleBlock)titleHeaderBlock andFooterSectionWithTitle:(SectionFooterTitleBlock)titleFooterBlock;

-(void)addCellDescriptor:(VSCellDescriptor*)cellDescriptor;

// autocompletion tricks
-(void)setHeightHeaderBlock:(SectionHeaderHeightBlock)heightHeaderBlock;
-(void)setConfigureHeaderBlock:(SectionHeaderConfigureBlock)configureHeaderBlock;
-(void)setHeightFooterBlock:(SectionFooterHeightBlock)heightFooterBlock;
-(void)setConfigureFooterBlock:(SectionFooterConfigureBlock)configureFooterBlock;
-(void)setTitleHeaderBlock:(SectionHeaderTitleBlock)titleHeaderBlock;
-(void)setTitleFooterBlock:(SectionFooterTitleBlock)titleFooterBlock;

@end
