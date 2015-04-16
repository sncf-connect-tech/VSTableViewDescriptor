//
//  VSTableViewDescriptorTests.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 25/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VSTableViewDescriptor.h"

@interface VSTableViewDescriptorTests : XCTestCase

@property (nonatomic,strong) VSTableViewDescriptor* tableViewDescriptor;

@end

@implementation VSTableViewDescriptorTests

- (void)setUp {
    [super setUp];
    
    self.tableViewDescriptor = [[VSTableViewDescriptor alloc] init];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddOneHeaderViewSection
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithHeight:^CGFloat(UITableView *tableView, int section) {
        return 40;
    } configure:^UIView *(UITableView *tableView, int section) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }];
    
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    sectionDescriptor = nil;
    sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[0];
    
    XCTAssertNotNil(sectionDescriptor,@"sectionDescriptor shouldn't be nil");
    
    XCTAssertTrue(sectionDescriptor.heightHeaderBlock(nil,0) == 40,@"sectionDescriptor heightBlock should be 40");
    XCTAssertTrue(sectionDescriptor.configureHeaderBlock(nil,0) != nil,@"sectionDescriptor heightBlock shouldn't be nil");
}

- (void)testAddOneHeaderViewAndFooterViewSection
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithHeight:^CGFloat(UITableView *tableView, int section) {
        return 40;
    } configure:^UIView *(UITableView *tableView, int section) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }andFooterSectionWithHeight:^CGFloat(UITableView *tableView, int section) {
        return 40;
    } configure:^UIView *(UITableView *tableView, int section) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }];
    
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    sectionDescriptor = nil;
    sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[0];
    
    XCTAssertNotNil(sectionDescriptor,@"sectionDescriptor shouldn't be nil");
    
    XCTAssertTrue(sectionDescriptor.heightHeaderBlock(nil,0) == 40,@"sectionDescriptor heightHeaderBlock should be 40");
    XCTAssertTrue(sectionDescriptor.configureHeaderBlock(nil,0) != nil,@"sectionDescriptor configureHeaderBlock shouldn't be nil");
    
    XCTAssertTrue(sectionDescriptor.heightFooterBlock(nil,0) == 40,@"sectionDescriptor heightFooterBlock should be 40");
    XCTAssertTrue(sectionDescriptor.configureFooterBlock(nil,0) != nil,@"sectionDescriptor configureFooterBlock shouldn't be nil");
}

- (void)testAddOneHeaderTitleSection
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"header title";
    }];
    
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    sectionDescriptor = nil;
    sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[0];
    
    XCTAssertNotNil(sectionDescriptor,@"sectionDescriptor shouldn't be nil");
    XCTAssertTrue([sectionDescriptor.titleHeaderBlock(nil,0) isEqualToString:@"header title"],@"sectionDescriptor titleHeaderBlock should be 'header title'");
}

- (void)testAddOneHeaderTitleAndFooterTitleSection
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"header title";
    }andFooterSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"footer title";
    }];
    
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    sectionDescriptor = nil;
    sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[0];
    
    XCTAssertNotNil(sectionDescriptor,@"sectionDescriptor shouldn't be nil");
    XCTAssertTrue([sectionDescriptor.titleHeaderBlock(nil,0) isEqualToString:@"header title"],@"sectionDescriptor titleHeaderBlock should be 'header title'");
    
    XCTAssertTrue([sectionDescriptor.titleFooterBlock(nil,0) isEqualToString:@"footer title"],@"sectionDescriptor titleHeaderBlock should be 'footer title'");

}

- (void)testRemoveAllSections
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"header title";
    }];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    XCTAssertTrue([self.tableViewDescriptor.sectionDescriptors count] > 0,@"tableViewDescriptor.sectionDescriptors.count should be greater than 0");
    
    [self.tableViewDescriptor.sectionDescriptors removeAllObjects];
    
    XCTAssertTrue([self.tableViewDescriptor.sectionDescriptors count] == 0,@"tableViewDescriptor.sectionDescriptors.count should be equal to 0");
}

- (void)testAddOneCellDescriptor
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 40;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }];
    
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    cellDescriptor = nil;
    
    XCTAssertTrue([sectionDescriptor.cellDescriptors count] > 0,@"sectionDescriptor.cellDescriptors should be greater than 0");
    
    cellDescriptor = sectionDescriptor.cellDescriptors[0];
    
    XCTAssertTrue(cellDescriptor.heightBlock(nil,0) == 40,@"cellDescriptor heightBlock should be 40");
    XCTAssertTrue(cellDescriptor.configureBlock(nil,0) != nil,@"cellDescriptor configureBlock shouldn't be nil");
}

- (void)testAddOneCellDescriptorWithSelectionAndWillDisplay
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 40;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }select:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"Hello");
    }];
    
    [cellDescriptor setWillDisplayBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        NSLog(@"Hello");
    }];

    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    cellDescriptor = nil;
    
    XCTAssertTrue([sectionDescriptor.cellDescriptors count] > 0,@"sectionDescriptor.cellDescriptors should be greater than 0");
    
    cellDescriptor = sectionDescriptor.cellDescriptors[0];
    
    XCTAssertTrue(cellDescriptor.heightBlock(nil,0) == 40,@"cellDescriptor heightBlock should be 40");
    XCTAssertTrue(cellDescriptor.configureBlock(nil,0) != nil,@"cellDescriptor configureBlock shouldn't be nil");
    XCTAssertTrue(cellDescriptor.selectBlock != nil,@"cellDescriptor selectBlock shouldn't be nil");
    XCTAssertTrue(cellDescriptor.willDisplayBlock != nil,@"cellDescriptor willDisplayBlock shouldn't be nil");
}

- (void)testRemoveAllCellDescriptors
{
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initEmpty];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 40;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    }select:^(UITableView *tableView, NSIndexPath *indexPath) {
        NSLog(@"Hello");
    }];
    
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    XCTAssertTrue([sectionDescriptor.cellDescriptors count] > 0,@"sectionDescriptor.count should be greater than 0");
    
    [sectionDescriptor.cellDescriptors removeAllObjects];
    
    XCTAssertTrue([sectionDescriptor.cellDescriptors count] == 0,@"sectionDescriptor.count should be equal to 0");
}

@end
