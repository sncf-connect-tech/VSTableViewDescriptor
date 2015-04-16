//
//  VSSenteceCellViewTableViewCell.h
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SentenceVO;

@interface VSSentenceCellViewTableViewCell : UITableViewCell

+(CGFloat) heightWithSentence:(NSString*)sentence;
-(void) configureWithSentenceVO:(SentenceVO*)sentenceVO;

@property (weak, nonatomic) IBOutlet UILabel *sentenceLabel;

@end
