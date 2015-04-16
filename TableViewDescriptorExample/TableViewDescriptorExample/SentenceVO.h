//
//  SentenceVO.h
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 25/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SentenceVO : NSObject

@property (nonatomic,copy) NSString* sentence;
@property (nonatomic,strong) UIColor* color;

-(id)initWithSentence:(NSString*)sentence color:(UIColor*)color;

@end
