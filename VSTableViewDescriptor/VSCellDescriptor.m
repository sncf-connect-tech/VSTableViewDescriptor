//
//  VSCellDescriptor.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "VSCellDescriptor.h"

@interface VSCellDescriptor ()

@end

@implementation VSCellDescriptor

-(id)initWithHeight:(CellHeightBlock)heightBlock configure:(CellConfigureBlock)configureBlock
{
    self = [self initWithHeight:heightBlock configure:configureBlock select:nil];
    return self;
}

- (id)initWithHeight:(CellHeightBlock)heightBlock
           configure:(CellConfigureBlock)configureBlock
              select:(CellSelectBlock)selectBlock
{
    self = [super init];
    if (self)
    {
        self.heightBlock = [heightBlock copy];
        self.configureBlock = [configureBlock copy];
        self.selectBlock = [selectBlock copy];
    }
    return self;
}

- (id)initWithHeight:(CellHeightBlock)heightBlock
           configure:(CellConfigureBlock)configureBlock
              select:(CellSelectBlock)selectBlock
         willDisplay:(CellWillDisplayBlock)willDisplayBlock
{
    self = [self initWithHeight:heightBlock configure:configureBlock select:selectBlock];
    if (self)
    {
        self.willDisplayBlock = [willDisplayBlock copy];
    }
    return self;
}

@end
