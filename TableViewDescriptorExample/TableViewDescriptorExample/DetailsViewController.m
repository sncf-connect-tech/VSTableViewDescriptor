//
//  DetailsViewController.m
//  TableViewDescriptor
//
//  Created by Guihal Gwenn on 24/03/2015.
//  Copyright (c) 2015 Guihal Gwenn. All rights reserved.
//

#import "DetailsViewController.h"
#import "VSTableViewDescriptor.h"
#import "VSSentenceCellViewTableViewCell.h"
#import "SentenceVO.h"

@interface DetailsViewController ()

@property (nonatomic,strong) NSArray* mockModel;
@property (nonatomic,strong) VSTableViewDescriptor* tableViewDescriptor;

-(void)setupTableView;
-(void)addOneMoreCell:(BOOL)animated;
-(void)removeCell:(NSIndexPath*) indexPath animated:(BOOL)animated;

-(VSSectionDescriptor*)addMainSection;
-(void)addCell:(SentenceVO*)sentenceVO section:(VSSectionDescriptor*)sectionDescriptor;
-(void)addFooterSection;

@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mockModel = @[[[SentenceVO alloc] initWithSentence:@"Maître Corbeau, sur un arbre perché,\nTenait en son bec un fromage."
                                                      color:[UIColor redColor]],
                       [[SentenceVO alloc] initWithSentence:@"Maître Renard, par l'odeur alléché,\nLui tint à peu près ce langage :\n\"Hé ! bonjour, Monsieur du Corbeau."
                                                      color:[UIColor greenColor]],
                       [[SentenceVO alloc] initWithSentence:@"Que vous êtes joli ! que vous me semblez beau !\nSans mentir, si votre ramage\nSe rapporte à votre plumage,\nVous êtes le Phénix des hôtes de ces bois.\""
                                                      color:[UIColor blueColor]],
                       [[SentenceVO alloc] initWithSentence:@"A ces mots le Corbeau ne se sent pas de joie ;\nEt pour montrer sa belle voix,"
                                                      color:[UIColor blackColor]],
                       [[SentenceVO alloc] initWithSentence:@"Il ouvre un large bec, laisse tomber sa proie.\nLe Renard s'en saisit, et dit : \"Mon bon Monsieur,Apprenez que tout flatteur\nVit aux dépens de celui qui l'écoute :\nCette leçon vaut bien un fromage, sans doute. \"\nLe Corbeau, honteux et confus,\nJura, mais un peu tard, qu'on ne l'y prendrait plus."
                                                      color:[UIColor grayColor]]
    ];
    
    [self setupTableView];
}

static NSString* const kSentenceCellIdentifier = @"SentenceCell";

-(void)setupTableView
{
    // register cells
    UINib* nib = [UINib nibWithNibName:@"VSSentenceCellViewTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:kSentenceCellIdentifier];
    
    // create table descriptor
    self.tableViewDescriptor = [[VSTableViewDescriptor alloc] init];
    
    // add main section
    VSSectionDescriptor* sectionDescriptor = [self addMainSection];
    
    // add cells in main section
    for (SentenceVO* sentenceVO in self.mockModel)
    {
        [self addCell:sentenceVO section:sectionDescriptor];
    }
    
    // add footer section
    [self addFooterSection];
    
    // configure tableview, delegate and datasource is tableViewDescriptor
    self.tableView.delegate = self.tableViewDescriptor;
    self.tableView.dataSource = self.tableViewDescriptor;
}

#pragma mark - TableView

-(VSSectionDescriptor*)addMainSection
{
    __weak typeof(self) weakSelf = self; // important, use weak self in block
    
    VSSectionDescriptor* sectionDescriptor = nil;
    if (self.customSection) // uiviewSection
    {
        sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithHeight:^CGFloat(UITableView* tableView, int section)
                             {
                                 return 40;
                                 
                             } configure:^UIView *(UITableView* tableView, int section)
                             {
                                 return [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:weakSelf options:nil][0];
                             }];
    }
    else // simple title Section
    {
        sectionDescriptor = [[VSSectionDescriptor alloc] initHeaderSectionWithTitle:^NSString *(UITableView* tableView, int section)
                             {
                                 return @"Le Corbeau et le Renard";
                             }];
    }
    [self.tableViewDescriptor addSectionDescriptor:sectionDescriptor];
    return sectionDescriptor;
}

-(void)addCell:(SentenceVO*)sentenceVO section:(VSSectionDescriptor*)sectionDescriptor
{
    __weak typeof(self) weakSelf = self; // important, use weak self in block
    
    VSCellDescriptor* cellDescriptor = [[VSCellDescriptor alloc] initWithHeight:^CGFloat(UITableView* tableView, NSIndexPath *indexPath)
                                        {
                                            return [VSSentenceCellViewTableViewCell heightWithSentence:sentenceVO.sentence];
                                            
                                        } configure:^UITableViewCell *(UITableView* tableView, NSIndexPath *indexPath)
                                        {
                                            VSSentenceCellViewTableViewCell* cell = (VSSentenceCellViewTableViewCell*)[weakSelf.tableView dequeueReusableCellWithIdentifier:kSentenceCellIdentifier forIndexPath:indexPath];
                                            [cell configureWithSentenceVO:sentenceVO];
                                            return cell;
                                            
                                        } select:^(UITableView* tableView, NSIndexPath *indexPath)
                                        {
                                            [weakSelf addOneMoreCell:YES];
                                        }];
    
    [sectionDescriptor addCellDescriptor:cellDescriptor];
}

-(void)addFooterSection
{
    __weak typeof(self) weakSelf = self; // important, use weak self in block
    // footer section
    if (self.customSection) // uiviewSection
    {
        VSSectionDescriptor* footerSectionDescriptor = [[VSSectionDescriptor alloc] initFooterSectionWithHeight:^CGFloat(UITableView *tableView, int section)
                                                        {
                                                            return 40;
                                                            
                                                        } configure:^UIView *(UITableView* tableView, int section)
                                                        {
                                                            return [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:weakSelf options:nil][0];
                                                        }];
        [self.tableViewDescriptor addSectionDescriptor:footerSectionDescriptor];
    }
}

#pragma mark - Add or Remove Cell

-(void)addOneMoreCell:(BOOL)animated
{
    SentenceVO* sentenceVO = [[SentenceVO alloc] initWithSentence:@"La fable est terminée" color:[UIColor orangeColor]];

    VSSectionDescriptor* sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[0];
    [self addCell:sentenceVO section:sectionDescriptor];
    
    if (!animated)
    {
        [self.tableView reloadData];
    }
    else
    {
        NSMutableArray *insertIndexPaths = [NSMutableArray arrayWithCapacity:1];
        int row = (int)[sectionDescriptor.cellDescriptors count] - 1;
        [insertIndexPaths addObject: [NSIndexPath indexPathForRow:row inSection:0] ];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
        [self.tableView scrollToRowAtIndexPath:insertIndexPaths[0]
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:YES];
    }
}

-(void)removeCell:(NSIndexPath*) indexPath animated:(BOOL)animated
{
    VSSectionDescriptor* sectionDescriptor = self.tableViewDescriptor.sectionDescriptors[indexPath.section];
    [sectionDescriptor.cellDescriptors removeObjectAtIndex:indexPath.row];
    
    if (!animated)
    {
        [self.tableView reloadData];
    }
    else
    {
        NSMutableArray *removeIndexPaths = [NSMutableArray arrayWithCapacity:1];
        [removeIndexPaths addObject: indexPath ];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:removeIndexPaths withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
    }
}

- (void)dealloc
{
    
}


@end
