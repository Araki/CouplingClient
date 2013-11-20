//
//  MyPageDataManager.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/11/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "MyPageDataManager.h"
#import "PFHTTPConnector.h"

#define KEY_ALL         @"key_all_list"
#define KEY_MATCH       @"key_match_list"
#define KEY_LIKED       @"key_liked_list"
#define KEY_MY_LIKE     @"key_mylike"
#define KEY_MY_FAVORITE @"key_myfavorite"

@implementation MyPageDataManager
{
    //Type
    kPFMyPageSortType showType;
    //Blocks
    changeDataHandler changeHandler;
    //表示データ
    NSMutableArray *dataArrray;
    //保存データ
    NSMutableArray *allArray;
    NSMutableArray *matchArray;
    NSMutableArray *likedArray;
    NSMutableArray *myLikeArray;
    NSMutableArray *favoriteArray;
    //更新フラグ
    BOOL isAllLoad;
    BOOL isMatchLoad;
    BOOL isLikedLoad;
    BOOL isMyLikeLoad;
    BOOL isFavoriteLoad;
    //読み込みフラグ
    BOOL isAllLoading;
    BOOL isMatchLoading;
    BOOL isLikedLoading;
    BOOL isMyLikeLoading;
    BOOL isFavoriteLoading;
    //終了フラグ
    BOOL isEndAll;
    BOOL isEndMatch;
    BOOL isEndLiked;
    BOOL isEndMyLike;
    BOOL isEndFavorite;
}

#pragma mark - Init
+ (MyPageDataManager *)sharedManager
{
    static MyPageDataManager *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[MyPageDataManager alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self initObject];
    }
    return self;
}

- (void)initObject
{
    //Type指定
    showType = SortTyp_All;
    [self initDatas];
    //ロード
    [self loadData:showType];
}

- (void)initDatas
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:KEY_ALL]         != nil) allArray      = [NSMutableArray arrayWithArray:[self loadResponseCacheWithData:KEY_ALL]];
    else                                                allArray      = [NSMutableArray arrayWithCapacity:0];
    if ([defaults objectForKey:KEY_MATCH]       != nil) matchArray    = [NSMutableArray arrayWithArray:[self loadResponseCacheWithData:KEY_MATCH]];
    else                                                matchArray    = [NSMutableArray arrayWithCapacity:0];
    if ([defaults objectForKey:KEY_LIKED]       != nil) likedArray    = [NSMutableArray arrayWithArray:[self loadResponseCacheWithData:KEY_LIKED]];
    else                                                likedArray    = [NSMutableArray arrayWithCapacity:0];
    if ([defaults objectForKey:KEY_MY_LIKE]     != nil) myLikeArray   = [NSMutableArray arrayWithArray:[self loadResponseCacheWithData:KEY_MY_LIKE]];
    else                                                myLikeArray   = [NSMutableArray arrayWithCapacity:0];
    if ([defaults objectForKey:KEY_MY_FAVORITE] != nil) favoriteArray = [NSMutableArray arrayWithArray:[self loadResponseCacheWithData:KEY_MY_FAVORITE]];
    else                                                favoriteArray = [NSMutableArray arrayWithCapacity:0];
    //データ取得
    dataArrray = allArray;
}

#pragma mark - Self Methods
- (void)changeDataWithType:(kPFMyPageSortType)sortType onComplete:(changeDataHandler)cHandler
{
    //設定
    changeHandler = [cHandler copy];
    //データ取得
    [self loadData:sortType];
}

- (void)addLoadDataWithType:(kPFMyPageSortType)sortType onComplete:(changeDataHandler)cHandler
{
    showType = sortType;
    changeHandler = [cHandler copy];
    //データ取得
    switch (sortType) {
        case SortTyp_All:
            [self addLoadAllData];
            break;
        case SortTyp_CanTalk:
            [self addLoadMatchData];
            break;
        case SortTyp_Favorite:
            [self addLoadFavoriteData];
            break;
        case SortTyp_GoodFromMe:
            [self addLoadMyLikeData];
            break;
        case SortTyp_GoodFromPartner:
            [self addLoadLikedData];
            break;
        default:
            break;
    }
}

- (void)reloadDataWithType:(kPFMyPageSortType)sortType onComplete:(changeDataHandler)cHandler
{
    showType = sortType;
    changeHandler = [cHandler copy];
    switch (sortType) {
        case SortTyp_All:
            [self loadAllData];
            break;
        case SortTyp_CanTalk:
            [self loadMatchData];
            break;
        case SortTyp_Favorite:
            [self loadFavoriteData];
            break;
        case SortTyp_GoodFromMe:
            [self loadMyLikeData];
            break;
        case SortTyp_GoodFromPartner:
            [self loadLikedData];
            break;
        default:
            break;
    }
}

#pragma mark - Load Manager
- (void)loadData:(kPFMyPageSortType)sortType
{
    showType = sortType;
    switch (sortType) {
        case SortTyp_All:
            dataArrray = allArray;
            if (!isAllLoad) [self loadAllData];
            break;
        case SortTyp_CanTalk:
            dataArrray = matchArray;
            if (!isMatchLoad) [self loadMatchData];
            break;
        case SortTyp_Favorite:
            dataArrray = favoriteArray;
            if (!isFavoriteLoad) [self loadFavoriteData];
            break;
        case SortTyp_GoodFromMe:
            dataArrray = myLikeArray;
            if (!isMyLikeLoad) [self loadMyLikeData];
            break;
        case SortTyp_GoodFromPartner:
            dataArrray = likedArray;
            if (!isLikedLoad) [self loadLikedData];
            break;
        default:
            break;
    }
    [self callBlocks];
}

- (void)loadAllData
{
    NSLog(@"Load All Data");
}

- (void)addLoadAllData
{
    NSLog(@"Add Load All Data");
}

- (void)loadMatchData
{
    if (isMatchLoading) return;
    
    isEndMatch = NO;
    isMatchLoading = YES;
    //取得
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, @"1", @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendMatchesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                matchArray = [NSMutableArray arrayWithArray:[jsonObject objectForKey:@"users"]];
                [self addResponseCacheWithData:matchArray forKey:KEY_MATCH];
                isMatchLoad = YES;
                if (showType = SortTyp_CanTalk)
                {
                    dataArrray = matchArray;
                    [self callBlocks];
                }
                if ([matchArray count] < 25) isEndMatch = YES;
            });
        }
        isMatchLoading = NO;
    } onFailure:^(NSError *error) {
        isMatchLoading = NO;
    }];
}

- (void)addLoadMatchData
{
    if (isMatchLoading) return;
    if (isEndMatch) return;
    
    isMatchLoading = YES;
    //取得
    NSString *page = [NSString stringWithFormat:@"%d",([matchArray count] / 25) + 1];
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, page, @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendMatchesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //データ追加
                NSMutableArray *joinedArray = [NSMutableArray arrayWithArray:matchArray];
                [joinedArray addObjectsFromArray:[jsonObject objectForKey:@"users"]];
                matchArray = joinedArray;
                
                if (showType == SortTyp_CanTalk)
                {
                    dataArrray = matchArray;
                    [self callBlocks];
                }
                if ([matchArray count] %25 != 0) isEndMatch = YES;
            });
        }
        isMatchLoading = NO;
    } onFailure:^(NSError *error) {
        isMatchLoading = NO;
    }];
}

- (void)loadFavoriteData
{
    if (isFavoriteLoading) return;
    
    isEndFavorite = NO;
    isFavoriteLoading = YES;
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
                favoriteArray = [NSMutableArray arrayWithArray:[jsonObject objectForKey:@"users"]];
                [self addResponseCacheWithData:favoriteArray forKey:KEY_MY_FAVORITE];
                isFavoriteLoad = YES;
                if (showType == SortTyp_Favorite)
                {
                    dataArrray = favoriteArray;
                    [self callBlocks];
                }
                if ([favoriteArray count] < 25) isEndFavorite = YES;
            });
        }
        isFavoriteLoading = NO;
    } onFailure:^(NSError *error) {
        isFavoriteLoading = NO;
    }];
}

- (void)addLoadFavoriteData
{
    if (isFavoriteLoading) return;
    if (isEndFavorite) return;
    
    isFavoriteLoading = YES;
    //取得
    NSString *page = [NSString stringWithFormat:@"%d",([favoriteArray count] / 25) + 1];
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, page, @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendFavoritesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                NSMutableArray *joinedArray = [NSMutableArray arrayWithArray:favoriteArray];
                [joinedArray addObjectsFromArray:[jsonObject objectForKey:@"users"]];
                favoriteArray = joinedArray;

                isFavoriteLoad = YES;
                if (showType == SortTyp_Favorite)
                {
                    dataArrray = favoriteArray;
                    [self callBlocks];
                }
                if ([favoriteArray count] %25 != 0) isEndFavorite = YES;
            });
        }
        isFavoriteLoading = NO;
    } onFailure:^(NSError *error) {
        isFavoriteLoading = NO;
    }];
}

- (void)loadMyLikeData
{
    if (isMyLikeLoading) return;
    
    isEndMyLike = NO;
    isMyLikeLoading = YES;
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
                myLikeArray = [NSMutableArray arrayWithArray:[jsonObject objectForKey:@"users"]];
                [self addResponseCacheWithData:myLikeArray forKey:KEY_MY_LIKE];
                isMyLikeLoad = YES;
                if (showType == SortTyp_GoodFromMe)
                {
                    dataArrray = myLikeArray;
                    [self callBlocks];
                }
                if ([myLikeArray count] < 25) isEndMyLike = YES;
            });
        }
        isMyLikeLoading = NO;
    } onFailure:^(NSError *error) {
        isMyLikeLoading = NO;
    }];
}

- (void)addLoadMyLikeData
{
    if (isMyLikeLoading) return;
    if (isEndMyLike) return;
    
    isMyLikeLoading = YES;
    //取得
    NSString *page = [NSString stringWithFormat:@"%d",([myLikeArray count] / 25) + 1];
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, page, @"25", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                NSMutableArray *joinedArray = [NSMutableArray arrayWithArray:myLikeArray];
                [joinedArray addObjectsFromArray:[jsonObject objectForKey:@"users"]];
                myLikeArray = joinedArray;
                
                if (showType == SortTyp_GoodFromMe)
                {
                    dataArrray = myLikeArray;
                    [self callBlocks];
                }
                if ([myLikeArray count] %25 != 0) isEndMyLike = YES;
            });
        }
        isMyLikeLoading = NO;
    } onFailure:^(NSError *error) {
        isMyLikeLoading = NO;
    }];
}

- (void)loadLikedData
{
    if (isLikedLoading) return;
    
    isEndLiked = NO;
    isLikedLoading = YES;
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
                likedArray = [NSMutableArray arrayWithArray:[jsonObject objectForKey:@"users"]];
                [self addResponseCacheWithData:likedArray forKey:KEY_LIKED];
                isLikedLoad = YES;
                if (showType == SortTyp_GoodFromPartner)
                {
                    dataArrray = likedArray;
                    [self callBlocks];
                }
                if ([likedArray count] < 25) isEndLiked = YES;
            });
        }
        isLikedLoading = NO;
    } onFailure:^(NSError *error) {
        isLikedLoading = NO;
    }];
}

- (void)addLoadLikedData
{
    if (isLikedLoading) return;
    if (isEndLiked) return;
    
    isLikedLoading = YES;
    //取得
    NSString *page = [NSString stringWithFormat:@"%d",([likedArray count]/ 25) + 1];
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, page, @"25", @"liked", nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per", @"type",nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"])
        {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                NSMutableArray *joinedArray = [NSMutableArray arrayWithArray:likedArray];
                [joinedArray addObjectsFromArray:[jsonObject objectForKey:@"users"]];
                likedArray = joinedArray;
                
                isLikedLoad = YES;
                if (showType == SortTyp_GoodFromPartner)
                {
                    dataArrray = likedArray;
                    [self callBlocks];
                }
                if ([likedArray count] %25 != 0) isEndLiked = YES;
            });
        }
        isLikedLoading = NO;
    } onFailure:^(NSError *error) {
        isLikedLoading = NO;
    }];
}

#pragma mark - Blocks
- (void)callBlocks
{
    if (changeHandler)
    {
        changeHandler(dataArrray, showType);
    }
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
