//
//  VSSenteceCellViewTableViewCell.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "VSSentenceCellViewTableViewCell.h"
#import "SentenceVO.h"

@implementation VSSentenceCellViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

static const int kLabelWith = 304;
static const int kVerticalMargin = 12;

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

+(CGFloat)heightWithSentence:(NSString *)sentence
{
    CGSize size = [sentence sizeWithFont:[UIFont systemFontOfSize:12]
                       constrainedToSize:CGSizeMake(kLabelWith, MAXFLOAT)
                           lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 15 + kVerticalMargin * 2;
}

#pragma GCC diagnostic pop

-(void) configureWithSentenceVO:(SentenceVO*)sentenceVO
{
    self.sentenceLabel.text = sentenceVO.sentence;
    self.sentenceLabel.textColor = sentenceVO.color;
    [self.sentenceLabel sizeToFit];
}

@end
