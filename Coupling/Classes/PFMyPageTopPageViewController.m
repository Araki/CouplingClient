//
//  PFMyPageTopTableViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyPageTopPageViewController.h"
#import "PFMyPageTopTableCell.h"
#import "IIViewDeckController.h"


@interface PFMyPageTopPageViewController ()

@property (nonatomic, strong) NSArray *displayUserArray; // 実際に表示するユーザーの配列

@end

@implementation PFMyPageTopPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outletTableViewController.backgroundColor = kPFBackGroundColor;
}
/*
- (void)makeNavigationBarButton
{
    UIButton *canTalkButton = [PFUtil searchConditionBarButton];
    [canTalkButton addTarget:self action:@selector(sortButtonWithButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *canTalkBarButton = [[UIBarButtonItem alloc] initWithCustomView:canTalkButton];
    canTalkButton.tag = SortTyp_CanTalk;
    
    UIButton *goodFromPartnerButton = [PFUtil searchConditionBarButton];
    [goodFromPartnerButton addTarget:self action:@selector(sortButtonWithButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *goodFromPartnerBarButton = [[UIBarButtonItem alloc] initWithCustomView:goodFromPartnerButton];
    goodFromPartnerButton.tag = SortTyp_GoodFromPartner;
    
    UIButton *goodFromMeButton = [PFUtil searchConditionBarButton];
    [goodFromMeButton addTarget:self action:@selector(sortButtonWithButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *goodFromMeBarButton = [[UIBarButtonItem alloc] initWithCustomView:goodFromMeButton];
    goodFromMeButton.tag = SortTyp_GoodFromMe;
    
    UIButton *favoriteButton = [PFUtil searchConditionBarButton];
    [favoriteButton addTarget:self action:@selector(sortButtonWithButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favoriteBarButton = [[UIBarButtonItem alloc] initWithCustomView:favoriteButton];
    favoriteButton.tag = SortTyp_Favorite;
    
    self.outletNavigationBar.topItem.rightBarButtonItems =
    [NSArray arrayWithObjects:favoriteBarButton, goodFromMeBarButton, goodFromPartnerBarButton, canTalkBarButton, nil];
}
*/
- (void)sortButtonWithButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    NSLog(@"sort button is touched tag = %d", button.tag);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 80;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.forDisplayUserArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PFMyPageTopTableCell";
    
    PFMyPageTopTableCell* cell = (PFMyPageTopTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UINib* nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        NSArray* array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.backgroundColor = kPFBackGroundColor;
        cell.outletUserPictureImage.image = [UIImage imageNamed:@"test_imgres_1.jpeg"];
    }
    cell.outletUserAgeLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)viewDidUnload {
    [self setOutletTableViewController:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}

- (IBAction)actionStatusSortBarButton:(id)sender
{
    NSLog(@"senderTag = %d", ((UIBarButtonItem *)sender).tag);
    [PFActionSheet sheetWithView:self.view
                       frameType:defaultFrameType
                        delegate:self
                          titles:[PFUtil myPageSortList], nil];
}

#pragma mark - PFActionSheet Delegate

- (void)dismissOkButtonWithTitles:(NSArray *)titles type:(kPFActionSheetType)type
{
    kPFMyPageSortType sortType =
    [[PFUtil myPageSortList] indexOfObjectPassingTest:^BOOL(id element, NSUInteger idx, BOOL *stop) {
        return [(NSString *)element isEqualToString:[titles objectAtIndex:0]];
    }];
    self.displayUserArray = [self displayUserArrayWithSortType:sortType];
    [self.outletTableViewController reloadData];
}

- (NSArray *)displayUserArrayWithSortType:(kPFMyPageSortType)sortType
{
    NSArray *displayArray = nil;
    switch (sortType) {
        case SortTyp_CanTalk:
            displayArray = self.canTalkUserArray;
            break;
        case SortTyp_GoodFromPartner:
            displayArray = self.goodFromPartnerUserArray;
            break;
        case SortTyp_GoodFromMe:
            displayArray = self.goodFromMeUserArray;
            break;
        case SortTyp_Favorite:
            displayArray = self.favoriteUserDArray;
            break;
            
        default:
            break;
    }
    return displayArray;
}


- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type
{
    
}

@end
