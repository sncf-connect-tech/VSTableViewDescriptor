//
//  VSTableViewDataSource.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "VSTableViewDescriptor.h"
#import <objc/runtime.h>

@interface VSTableViewDescriptor ()

@end

@implementation VSTableViewDescriptor

#pragma mark - LifeCycle

-(id)init
{
    self = [super init];
    if (self)
    {
        _sectionDescriptors = [NSMutableArray array]; //TODO: add optionnal capacity
    }
    return self;
}

#pragma mark - Section Descriptor

-(void)addSectionDescriptor:(VSSectionDescriptor*)sectionDescriptor
{
    [self.sectionDescriptors addObject:sectionDescriptor];
}

-(VSSectionDescriptor*)getSectionDescriptorAt:(int)index
{
    return self.sectionDescriptors[index];
}

#pragma mark - TableView Section Delegate & DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataSource && [self.dataSource respondsToSelector:_cmd])
    {
        [self warningOverrides:self.dataSource selector:_cmd];
    }
    
    return [self.sectionDescriptors count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return nil;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.configureHeaderBlock)
    {
        return sectionDescriptor.configureHeaderBlock(tableView, (int)section);
    }
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return -1;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.heightHeaderBlock)
    {
        return sectionDescriptor.heightHeaderBlock(tableView, (int)section);
    }
    
    return -1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return nil;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.configureFooterBlock)
        return sectionDescriptor.configureFooterBlock(tableView, (int)section);
    
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return -1;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.heightFooterBlock)
        return sectionDescriptor.heightFooterBlock(tableView, (int)section);
    
    return -1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:_cmd])
    {
        [self warningOverrides:self.dataSource selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return nil;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.titleHeaderBlock)
        return sectionDescriptor.titleHeaderBlock(tableView, (int)section);
    
    return nil;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:_cmd])
    {
        [self warningOverrides:self.dataSource selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return nil;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    if (sectionDescriptor.titleFooterBlock)
        return sectionDescriptor.titleFooterBlock(tableView, (int)section);
    
    return nil;
}

#pragma mark - TableView Cell Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataSource && [self.dataSource respondsToSelector:_cmd])
    {
        [self warningOverrides:self.dataSource selector:_cmd];
    }
    
    if ([self.sectionDescriptors count] < 1) return 0;
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[section];
    return [sectionDescriptor.cellDescriptors count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[indexPath.section];
    VSCellDescriptor* cellDescriptor = sectionDescriptor.cellDescriptors[indexPath.row];
    if (cellDescriptor.heightBlock)
        return cellDescriptor.heightBlock(tableView, indexPath);
    
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[indexPath.section];
    VSCellDescriptor* cellDescriptor = sectionDescriptor.cellDescriptors[indexPath.row];
    if (cellDescriptor.willDisplayBlock)
        cellDescriptor.willDisplayBlock(tableView, cell, indexPath);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.dataSource && [self.dataSource respondsToSelector:_cmd])
    {
        [self warningOverrides:self.dataSource selector:_cmd];
    }
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[indexPath.section];
    VSCellDescriptor* cellDescriptor = sectionDescriptor.cellDescriptors[indexPath.row];
    if (cellDescriptor.configureBlock)
        return cellDescriptor.configureBlock(tableView, indexPath);
    
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:_cmd])
    {
        [self warningOverrides:self.delegate selector:_cmd];
    }
    
    VSSectionDescriptor* sectionDescriptor = self.sectionDescriptors[indexPath.section];
    VSCellDescriptor* cellDescriptor = sectionDescriptor.cellDescriptors[indexPath.row];
    if (cellDescriptor.selectBlock)
        cellDescriptor.selectBlock(tableView, indexPath);
}

#pragma mark - Forwarding Messages

// overrides from NSObject
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    if ([self.delegate respondsToSelector:aSelector])
    {
        return self.delegate;
    }
    if ([self.dataSource respondsToSelector:aSelector])
    {
        return self.dataSource;
    }
    return [super forwardingTargetForSelector:aSelector];
}

// overrides from NSObject
- (BOOL)respondsToSelector:(SEL)aSelector
{
    return [super respondsToSelector:aSelector] || [self.delegate respondsToSelector:aSelector] || [self.dataSource respondsToSelector:aSelector];
}

#pragma mark - Waring

-(void)warningOverrides:(id)sender selector:(SEL)selector
{
#ifdef DEBUG
    NSLog(@"WARNING : %@ overrides %@::%@",[sender class],[self class],NSStringFromSelector(selector));
#endif
}

@end
