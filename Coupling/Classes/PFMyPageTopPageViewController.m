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
#import "PFHTTPConnector.h"
#import "MyPageDataManager.h"
#import "ISRefreshControl.h"

#define KEY_ALL         @"key_all_list"
#define KEY_MATCH       @"key_match_list"
#define KEY_LIKED       @"key_liked_list"
#define KEY_MY_LIKE     @"key_mylike"
#define KEY_MY_FAVORITE @"key_myfavorite"

@interface PFMyPageTopPageViewController ()

@property (nonatomic, strong) NSMutableArray *displayUserArray; // 実際に表示するユーザーの配列

@end

@implementation PFMyPageTopPageViewController
{
    kPFMyPageSortType showType;
    ISRefreshControl *refreshControl;
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outletTableViewController.backgroundColor = kPFBackGroundColor;
    //引っ張って更新
    refreshControl = [[ISRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.outletTableViewController addSubview:refreshControl];
    //全てを選択
    [self getAllList];
}

- (void)viewDidUnload
{
    [self setOutletTableViewController:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}

- (void)sortButtonWithButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    return [self.displayUserArray count];
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
        [cell setUserInteractionEnabled:YES];
        [cell setMyPageTopTableCellDelegate:self];
        //cell.outletUserPictureImage.image = [UIImage imageNamed:@"test_why_always_me.jpeg"];
    }
    //cell.outletUserAgeLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PFMyPageTopTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell initCellWithData:[self.displayUserArray objectAtIndex:indexPath.row] withShowType:showType];
}

#pragma mark - Cell Delegate
- (void)showTalkView:(NSDictionary *)user
{
    //トーク画面へ
    
    
}

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.outletTableViewController.contentSize.height < self.view.frame.size.height) return;
    
    //一番下までスクロールしたら更新する
    CGPoint offset = [self.outletTableViewController contentOffset];
    CGFloat currentOffsetY = offset.y + self.view.frame.size.height;
    if (currentOffsetY > (self.outletTableViewController.contentSize.height - 10))
    {
        [self addLoad];
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //相手詳細画面へ
    
}

- (IBAction)actionStatusSortBarButton:(id)sender
{
    [PFActionSheet sheetWithView:self.view
                       frameType:defaultFrameType
                        delegate:self
                          titles:[PFUtil myPageSortList], nil];
}

#pragma mark - Refresh Control
- (void)refresh
{
    switch (showType) {
        case SortTyp_All:
            [self reloadLoadAllList];
            break;
        case SortTyp_CanTalk:
            [self reloadLoadMatchList];
            break;
        case SortTyp_GoodFromPartner:
            [self reloadLoadMyLikedList];
            break;
        case SortTyp_GoodFromMe:
            [self reloadLoadMyLikeList];
            break;
        case SortTyp_Favorite:
            [self reloadLoadFavoriteList];
            break;
        default:
            break;
    }
}

#pragma mark - PFActionSheet Delegate
- (void)dismissOkButtonWithTitles:(NSArray *)titles type:(kPFActionSheetType)type
{
    kPFMyPageSortType sortType =
    [[PFUtil myPageSortList] indexOfObjectPassingTest:^BOOL(id element, NSUInteger idx, BOOL *stop) {
        return [(NSString *)element isEqualToString:[titles objectAtIndex:0]];
    }];
    showType = sortType;
    [self displayUserArrayWithSortType:sortType];
}

- (void)displayUserArrayWithSortType:(kPFMyPageSortType)sortType
{
    switch (sortType) {
        case SortTyp_All:
            [self getAllList];
            break;
        case SortTyp_CanTalk:
            [self getMatchList];
            break;
        case SortTyp_GoodFromPartner:
            [self getMYLikedList];
            break;
        case SortTyp_GoodFromMe:
            [self getMyLikeUser];
            break;
        case SortTyp_Favorite:
            [self getFavoriteUser];
            break;
        default:
            break;
    }
}

- (void)addLoad
{
    switch (showType) {
        case SortTyp_All:
            [self addLoadAllList];
            break;
        case SortTyp_CanTalk:
            [self addLoadMatchList];
            break;
        case SortTyp_GoodFromPartner:
            [self addLoadMyLikedList];
            break;
        case SortTyp_GoodFromMe:
            [self addLoadMyLikeList];
            break;
        case SortTyp_Favorite:
            [self addLoadFavoriteList];
            break;
        default:
            break;
    }
}

- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type
{
    
}

- (void)getAllList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] changeDataWithType:SortTyp_All
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_All){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                    [refreshControl endRefreshing];
                                            }];
}

- (void)addLoadAllList
{
    [[MyPageDataManager sharedManager] addLoadDataWithType:SortTyp_All
                                                onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                    if (sortType == SortTyp_All){
                                                        self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                        [self.outletTableViewController reloadData];
                                                    }
                                                }];
}

- (void)reloadLoadAllList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] reloadDataWithType:SortTyp_All
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_All){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)getMatchList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] changeDataWithType:SortTyp_CanTalk
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_CanTalk){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)addLoadMatchList
{
    [[MyPageDataManager sharedManager] addLoadDataWithType:SortTyp_CanTalk
                                                onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                    if (sortType == SortTyp_CanTalk){
                                                        self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                        [self.outletTableViewController reloadData];
                                                    }
                                                }];
}

- (void)reloadLoadMatchList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] reloadDataWithType:SortTyp_CanTalk
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_CanTalk){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)getMYLikedList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] changeDataWithType:SortTyp_GoodFromPartner
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_GoodFromPartner){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)addLoadMyLikedList
{
    [[MyPageDataManager sharedManager] addLoadDataWithType:SortTyp_GoodFromPartner
                                                onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                    if (sortType == SortTyp_GoodFromPartner){
                                                        self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                        [self.outletTableViewController reloadData];
                                                    }
                                                }];
}

- (void)reloadLoadMyLikedList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] reloadDataWithType:SortTyp_GoodFromPartner
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_GoodFromPartner){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)getMyLikeUser
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] changeDataWithType:SortTyp_GoodFromMe
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_GoodFromMe){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
     
}

- (void)addLoadMyLikeList
{
    [[MyPageDataManager sharedManager] addLoadDataWithType:SortTyp_GoodFromMe
                                                onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                    if (sortType == SortTyp_GoodFromMe){
                                                        self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                        [self.outletTableViewController reloadData];
                                                    }
                                                }];
}

- (void)reloadLoadMyLikeList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] reloadDataWithType:SortTyp_GoodFromMe
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_GoodFromMe){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)getFavoriteUser
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] changeDataWithType:SortTyp_Favorite
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_Favorite){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

- (void)addLoadFavoriteList
{
    [[MyPageDataManager sharedManager] addLoadDataWithType:SortTyp_Favorite
                                                onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                    if (sortType == SortTyp_Favorite){
                                                        self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                        [self.outletTableViewController reloadData];
                                                    }
                                                }];
}

- (void)reloadLoadFavoriteList
{
    [refreshControl beginRefreshing];
    [[MyPageDataManager sharedManager] reloadDataWithType:SortTyp_Favorite
                                               onComplete:^(NSArray *dataArray, kPFMyPageSortType sortType) {
                                                   if (sortType == SortTyp_Favorite){
                                                       self.displayUserArray = [NSMutableArray arrayWithArray:dataArray];
                                                       [self.outletTableViewController reloadData];
                                                   }
                                                   [refreshControl endRefreshing];
                                               }];
}

#pragma mark - Data Manager
- (void)addResponseCacheWithData:(NSArray *)response forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:response];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

- (NSArray *)loadResponseCacheWithData:(NSString *)key
{
    NSData *dt = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithData:dt];
    return arr;
}


@end
