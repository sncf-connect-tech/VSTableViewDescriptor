//
//  VSTableViewDescriptorDelegateTests.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 02/04/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "VSTableViewDescriptor.h"

@interface VSTableViewDescriptorDelegateTests : XCTestCase <UITableViewDataSource, UITableViewDelegate>
{
    
}

@property (nonatomic,strong) VSTableViewDescriptor* tableViewDescriptor;
@property (nonatomic,strong) UITableView* tableView;

@property (nonatomic,strong) NSMutableSet* expectationsExcluded;
@property (nonatomic,strong) NSMutableDictionary* expectations;

@end

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wprotocol"

@implementation VSTableViewDescriptorDelegateTests

- (void)setUp
{
    [super setUp];
    
    _expectationsExcluded = [[NSMutableSet alloc] init];
    _expectations = [[NSMutableDictionary alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    self.tableViewDescriptor = [[VSTableViewDescriptor alloc] init];
    self.tableView.delegate = _tableViewDescriptor;
    self.tableView.dataSource = _tableViewDescriptor;

}

- (void)tearDown
{
    [super tearDown];
}

- (void)testSectionViews
{
    [self createExpectation:@"expectationHeaderHeight"];
    [self createExpectation:@"expectationHeaderConfigure"];
    [self createExpectation:@"expectationFooterHeight"];
    [self createExpectation:@"expectationFooterConfigure"];
    
    // create a section
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithHeight:^CGFloat(UITableView *tableView, int section) {
        [self fullFill:@"expectationHeaderHeight"];
        return 20;
    } configure:^UIView *(UITableView *tableView, int section) {
        [self fullFill:@"expectationHeaderConfigure"];
        return nil;
    } andFooterSectionWithHeight:^CGFloat(UITableView *tableView, int section) {
        [self fullFill:@"expectationFooterHeight"];
        return 20;
    } configure:^UIView *(UITableView *tableView, int section) {
        [self fullFill:@"expectationFooterConfigure"];
        return nil;
    }];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    
    // create a cell
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 20;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return nil;
    } select:^(UITableView *tableView, NSIndexPath *indexPath) {
    }];
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    [self.tableViewDescriptor tableView:self.tableView heightForFooterInSection:0];
    [self.tableViewDescriptor tableView:self.tableView viewForFooterInSection:0];
    [self.tableViewDescriptor tableView:self.tableView heightForHeaderInSection:0];
    [self.tableViewDescriptor tableView:self.tableView viewForHeaderInSection:0];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testSectionTitles
{
    [self createExpectation:@"expectationHeaderTitle"];
    [self createExpectation:@"expectationFooterTitle"];
    
    // create a section
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        [self fullFill:@"expectationHeaderTitle"];
        return @"Hello";
    } andFooterSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        [self fullFill:@"expectationFooterTitle"];
        return @"Hello";
    }];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    
    // create a cell
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 20;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return nil;
    } select:^(UITableView *tableView, NSIndexPath *indexPath) {
    }];
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    [self.tableViewDescriptor tableView:self.tableView titleForFooterInSection:0];
    [self.tableViewDescriptor tableView:self.tableView titleForHeaderInSection:0];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

- (void)testCells
{
    [self createExpectation:@"expectationCellHeight"];
    [self createExpectation:@"expectationCellConfigure"];
    [self createExpectation:@"expectationCellSelect"];
    [self createExpectation:@"expectationWillDisplay"];
    
    // create a section
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"Hello";
    }];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    // create a cell
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        [self fullFill:@"expectationCellHeight"];
        return 20;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        [self fullFill:@"expectationCellConfigure"];
        return [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"..."];
    } select:^(UITableView *tableView, NSIndexPath *indexPath) {
        [self fullFill:@"expectationCellSelect"];
    }];
    [cellDescriptor setWillDisplayBlock:^(UITableView *tableView, UITableViewCell *cell, NSIndexPath *indexPath) {
        [self fullFill:@"expectationWillDisplay"];
    }];
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self.tableViewDescriptor tableView:self.tableView willDisplayCell: [self.tableView cellForRowAtIndexPath:indexPath]  forRowAtIndexPath:indexPath];
    [self.tableViewDescriptor tableView:self.tableView heightForRowAtIndexPath:indexPath];
    [self.tableViewDescriptor tableView:self.tableView cellForRowAtIndexPath:indexPath];
    [self.tableViewDescriptor tableView:self.tableView didSelectRowAtIndexPath:indexPath];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

-(void)testAMethodNotImplementedInTableViewDataSource
{
    [self createExpectation:@"expectationCellHeight"];
    
    self.tableViewDescriptor.dataSource = self;
    self.tableViewDescriptor.delegate = self;
    
    // create a section
    VSSectionDescriptor* sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView *tableView, int section) {
        return @"Hello";
    }];
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    
    // create a cell
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView *tableView, NSIndexPath *indexPath) {
        return 20;
    } configure:^UITableViewCell *(UITableView *tableView, NSIndexPath *indexPath) {
        return [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:@"..."];
    }];
    
    [sectionDescriptor addCellDescriptor:cellDescriptor];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // test here; @see tableView:didDeselectRowAtIndexPath:indexPath above
    [self.tableViewDescriptor tableView:self.tableView didDeselectRowAtIndexPath:indexPath];
    
    [self waitForExpectationsWithTimeout:1 handler:nil];
}

#pragma mark - UItableview delegate / datasource

-(void) tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self fullFill:@"expectationCellHeight"];
}

-(void)createExpectation:(NSString*)expectationName
{
    _expectations[expectationName] = [self expectationWithDescription:expectationName];
}

-(void)fullFill:(NSString*)expectationName
{
    if (![_expectationsExcluded containsObject:expectationName])
    {
        XCTestExpectation* expectations = _expectations[expectationName];
        [expectations fulfill];
        [_expectationsExcluded addObject:expectationName];
    }
}

-(void)createTable
{
    
    [self.tableView reloadData];
}

@end

#pragma GCC diagnostic pop
