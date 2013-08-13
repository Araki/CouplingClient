//
//  PFPairSearchTopPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchTopPageViewController.h"
#import "IIViewDeckController.h"
#import "PFSetConditionViewController.h"
#import "PFTalkPageViewController.h"
#import "PFUser.h"
#import "PFCommands.h"
#import "PFHTTPConnector.h"
#import "PFProfileScrollView.h"

@interface PFPairSearchTopPageViewController ()

@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
@property (strong) NSMutableArray *controllers;

@end

@implementation PFPairSearchTopPageViewController
{
    PFProfileScrollView *profileScrollView;
}
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;
@synthesize controllers = _controllers;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)initView
{
    profileScrollView = [[PFProfileScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height - 44)];
    [self.view addSubview:profileScrollView];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初期化
    [self initView];
    
    //Storyboard取得
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];

    //User情報
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId,nil] forKeys: [NSArray arrayWithObjects:@"session_id", nil]];
    
    NSMutableArray *userlist = [[NSMutableArray alloc] initWithCapacity:0];
    [PFHTTPConnector requestWithCommand:kPFCommendUsersList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"]) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                //ScrollView初期化
                [profileScrollView initUserWithData:[jsonObject objectForKey:@"users"]];
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    /*
	for (NSUInteger i =0; i < [self.controllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
    
	self.outletPageControl.currentPage = 0;
	_page = 0;
	[self.outletPageControl setNumberOfPages:[self.controllers count]];
    
    NSLog(@"currentPage %d",self.outletPageControl.currentPage);
	UIViewController *viewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
    NSLog(@"currentPage %d",self.outletPageControl.currentPage);
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
    
    // scrollViewのサイズ
	self.outletScrollView.contentSize = CGSizeMake(outletScrollView.frame.size.width * [self.controllers count], outletScrollView.frame.size.height);
     */
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loadScrollViewWithPage:(int)page
{
    
    /*
    if (page < 0 || page >= [self.controllers count])
        return;
    
	// replace the placeholder if necessary
    UIViewController *controller = [self.controllers objectAtIndex:page];
    if (controller == nil) {
		return;
    }
    
	// add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.outletScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.outletScrollView addSubview:controller.view];
    }
     */
}

#pragma mark UIScrollViewDelegate methods
/*
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
	UIViewController *oldViewController = [self.controllers objectAtIndex:_page];
	UIViewController *newViewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	[oldViewController viewDidDisappear:YES];
	[newViewController viewDidAppear:YES];
    
	_page = self.outletPageControl.currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (_pageControlUsed || _rotating) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.outletScrollView.frame.size.width;
    int page = floor((self.outletScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
	if (self.outletPageControl.currentPage != page) {
		UIViewController *oldViewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
		UIViewController *newViewController = [self.controllers objectAtIndex:page];
		[oldViewController viewWillDisappear:YES];
		[newViewController viewWillAppear:YES];
		self.outletPageControl.currentPage = page;
		[oldViewController viewDidDisappear:YES];
		[newViewController viewDidAppear:YES];
		_page = page;
	}
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}
 */


#pragma mark - PairSearchPfofileScrollView Delegate

// トーク画面を表示する
- (void)showTalkPage
{
    [self.navigationController pushViewController:[PFTalkPageViewController new] animated:YES];
}

#pragma mark - IBAction

- (IBAction)actionNotificationButton:(UIButton *)sender
{
    NSLog(@"Notifivation");
}

- (IBAction)actionSetConditionsButton:(UIButton *)sender
{
    NSLog(@"setConditions");
}

- (void)viewDidUnload
{
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}
@end
