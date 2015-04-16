//
//  VSTableViewDataSource.h
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VSSectionDescriptor.h"

@interface VSTableViewDescriptor : NSObject <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong,readonly) NSMutableArray* sectionDescriptors;

-(id)init;
-(void)addSectionDescriptor:(VSSectionDescriptor*)sectionDescriptor;

// dataSource and delegate
// messages are sent before block treatment if method implemented (override block calls)
@property (nonatomic,weak) NSObject<UITableViewDataSource>* dataSource;
@property (nonatomic,weak) NSObject<UITableViewDelegate>* delegate;

@end
