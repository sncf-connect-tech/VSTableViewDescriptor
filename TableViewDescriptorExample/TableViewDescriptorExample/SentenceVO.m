//
//  SentenceVO.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 25/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "SentenceVO.h"

@implementation SentenceVO

-(id)initWithSentence:(NSString*)sentence color:(UIColor*)color
{
    self = [super init];
    if (self)
    {
        self.sentence = sentence;
        self.color = color;
    }
    return self;
}

@end
