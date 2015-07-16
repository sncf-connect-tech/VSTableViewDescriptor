//
//  VSSectionDescriptor.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "VSSectionDescriptor.h"

@interface VSSectionDescriptor ()

-(id) init;

@end

@implementation VSSectionDescriptor

-(id)initEmpty
{
    self = [self init];
    return self;
}

-(id)initHeaderSectionWithHeight:(SectionHeaderHeightBlock)heightHeaderBlock configure:(SectionHeaderConfigureBlock)configureHeaderBlock
{
    self = [self initHeaderSectionWithHeight:heightHeaderBlock configure:configureHeaderBlock andFooterSectionWithHeight:nil configure:nil];
    return self;
}

-(id) initFooterSectionWithHeight:(SectionFooterHeightBlock)heightFooterBlock configure:(SectionFooterConfigureBlock)configureFooterBlock;
{
    self = [self initHeaderSectionWithHeight:nil configure:nil andFooterSectionWithHeight:heightFooterBlock configure:configureFooterBlock];
    return self;
}

-(id)initHeaderSectionWithHeight:(SectionHeaderHeightBlock)heightHeaderBlock configure:(SectionHeaderConfigureBlock)configureHeaderBlock andFooterSectionWithHeight:(SectionFooterHeightBlock)heightFooterBlock configure:(SectionFooterConfigureBlock)configureFooterBlock
{
    self = [self init];
    if (self)
    {
        self.heightHeaderBlock = [heightHeaderBlock copy];
        self.configureHeaderBlock = [configureHeaderBlock copy];
        
        self.heightFooterBlock = [heightFooterBlock copy];
        self.configureFooterBlock = [configureFooterBlock copy];
    }
    return self;
}

-(id) initHeaderSectionWithTitle:(SectionHeaderTitleBlock)titleHeaderBlock
{
    self = [self initHeaderSectionWithTitle:titleHeaderBlock andFooterSectionWithTitle:nil];
    return self;
}

-(id) initFooterSectionWithTitle:(SectionFooterTitleBlock)titleFooterBlock
{
    self = [self initHeaderSectionWithTitle:nil andFooterSectionWithTitle:titleFooterBlock];
    return self;
}

-(id) initHeaderSectionWithTitle:(SectionHeaderTitleBlock)titleHeaderBlock andFooterSectionWithTitle:(SectionFooterTitleBlock)titleFooterBlock
{
    self = [self init];
    if (self)
    {
        self.titleHeaderBlock = [titleHeaderBlock copy];
        self.titleFooterBlock = [titleFooterBlock copy];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _cellDescriptors = [NSMutableArray array]; //TODO: add optionnal capacity
    }
    return self;
}

#pragma mark - Cell Descriptor

-(void)addCellDescriptor:(VSCellDescriptor *)cellDescriptor
{
    [self.cellDescriptors addObject:cellDescriptor];
}

-(void)addCellDescriptor:(VSCellDescriptor *)cellDescriptor atIndex:(int)index
{
    [self.cellDescriptors insertObject:cellDescriptor atIndex:index];
}

@end
