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
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outletTableViewController.backgroundColor = kPFBackGroundColor;
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
        cell.outletUserPictureImage.image = [UIImage imageNamed:@"test_why_always_me.jpeg"];
    }
    cell.outletUserAgeLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (IBAction)actionStatusSortBarButton:(id)sender
{
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
    showType = sortType;
    [self displayUserArrayWithSortType:sortType];
}

- (void)displayUserArrayWithSortType:(kPFMyPageSortType)sortType
{
    NSArray *displayArray = nil;
    switch (sortType) {
        case SortTyp_All:
            displayArray = self.allUserArray;
            break;
        case SortTyp_CanTalk:
            displayArray = self.canTalkUserArray;
            [self getMatchList];
            break;
        case SortTyp_GoodFromPartner:
            displayArray = self.goodFromPartnerUserArray;
            [self getMYLikedList];
            break;
        case SortTyp_GoodFromMe:
            displayArray = self.goodFromMeUserArray;
            [self getMyLikeUser];
            break;
        case SortTyp_Favorite:
            displayArray = self.favoriteUserDArray;
            [self getFavoriteUser];
            break;
        default:
            break;
    }
    self.displayUserArray = [NSMutableArray arrayWithArray:displayArray];
    [self.outletTableViewController reloadData];
}

- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type
{
    
}

- (void)getMatchList
{
    //ユーザリスト取得
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_MATCH] != nil)
    {
        self.canTalkUserArray = [self loadResponseCacheWithData:KEY_MATCH];
        if (showType == SortTyp_CanTalk)
        {
            self.displayUserArray = [NSMutableArray arrayWithArray:self.canTalkUserArray];
            [self.outletTableViewController reloadData];
        }
    }
    
    //取得
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, @"1", @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendMatchesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //データ保存
                self.canTalkUserArray = [jsonObject objectForKey:@"users"];
                [self addResponseCacheWithData:self.canTalkUserArray forKey:KEY_MATCH];
                
                if (showType == SortTyp_CanTalk)
                {
                    self.displayUserArray = [NSMutableArray arrayWithArray:self.canTalkUserArray];
                    [self.outletTableViewController reloadData];
                }
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)getMYLikedList
{
    //ユーザリスト取得
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_LIKED] != nil)
    {
        self.goodFromPartnerUserArray = [self loadResponseCacheWithData:KEY_LIKED];
        if (showType == SortTyp_GoodFromPartner)
        {
            self.displayUserArray = [NSMutableArray arrayWithArray:self.goodFromPartnerUserArray];
            [self.outletTableViewController reloadData];
        }
    }
    
    //取得
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, @"1", @"25", @"liked", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", @"type",nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //データ保存
                self.goodFromPartnerUserArray = [jsonObject objectForKey:@"users"];
                [self addResponseCacheWithData:self.goodFromPartnerUserArray forKey:KEY_LIKED];
                
                if (showType == SortTyp_GoodFromPartner)
                {
                    self.displayUserArray = [NSMutableArray arrayWithArray:self.goodFromPartnerUserArray];
                    [self.outletTableViewController reloadData];
                }
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)getMyLikeUser
{
    //ユーザリスト取得
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_MY_LIKE] != nil)
    {
        self.goodFromMeUserArray = [self loadResponseCacheWithData:KEY_MY_LIKE];
        if (showType == SortTyp_GoodFromMe)
        {
            self.displayUserArray = [NSMutableArray arrayWithArray:self.goodFromMeUserArray];
            [self.outletTableViewController reloadData];
        }
    }
    
    //取得
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, @"1", @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //データ保存
                self.goodFromMeUserArray = [jsonObject objectForKey:@"users"];
                [self addResponseCacheWithData:self.goodFromMeUserArray forKey:KEY_MY_LIKE];
                
                if (showType == SortTyp_GoodFromMe)
                {
                    self.displayUserArray = [NSMutableArray arrayWithArray:self.goodFromMeUserArray];
                    [self.outletTableViewController reloadData];
                }
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
     
}

- (void)getFavoriteUser
{
    //ユーザリスト取得
    if ([[NSUserDefaults standardUserDefaults] objectForKey:KEY_MY_FAVORITE] != nil)
    {
        self.favoriteUserDArray = [self loadResponseCacheWithData:KEY_MY_FAVORITE];
        if (showType == SortTyp_Favorite)
        {
            self.displayUserArray = [NSMutableArray arrayWithArray:self.favoriteUserDArray];
            [self.outletTableViewController reloadData];
        }
    }
    
    //取得
    //取得
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, @"1", @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendFavoritesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //データ保存
                self.favoriteUserDArray = [jsonObject objectForKey:@"users"];
                [self addResponseCacheWithData:self.favoriteUserDArray forKey:KEY_MY_FAVORITE];
                
                if (showType == SortTyp_Favorite)
                {
                    self.displayUserArray = [NSMutableArray arrayWithArray:self.favoriteUserDArray];
                    [self.outletTableViewController reloadData];
                }
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
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
