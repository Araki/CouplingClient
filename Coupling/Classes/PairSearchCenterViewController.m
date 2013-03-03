//
//  PairSearchCenterViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PairSearchCenterViewController.h"
#import "IIViewDeckController.h"
#import "PFPairSearchProfileViewController.h"
#import "PFSetConditionViewController.h"

@interface PairSearchCenterViewController ()

@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
@property (strong) NSMutableArray *controllers;

@end

@implementation PairSearchCenterViewController
@synthesize outletScrollView;
@synthesize outletPageControl;
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;
@synthesize controllers = _controllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	// Do any additional setup after loading the view.    
    // UIScrollViewSettings
	[self.outletScrollView setPagingEnabled:YES];
	[self.outletScrollView setScrollEnabled:YES];
	[self.outletScrollView setShowsHorizontalScrollIndicator:NO];
	[self.outletScrollView setShowsVerticalScrollIndicator:NO];
	[self.outletScrollView setDelegate:self];
    
    // UIPageControl settings
    [self.outletPageControl setEnabled:NO];
    
    
    // test
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    PFPairSearchProfileViewController *view1 = [storyboard instantiateViewControllerWithIdentifier:@"PFPairSearchProfileViewController"];
    
    PFPairSearchProfileViewController *view2 = [storyboard instantiateViewControllerWithIdentifier:@"PFPairSearchProfileViewController"];
    
    PFPairSearchProfileViewController *view3 = [storyboard instantiateViewControllerWithIdentifier:@"PFPairSearchProfileViewController"];
    
    self.controllers = [[NSMutableArray alloc] initWithObjects:view1,
                                                               view2,
                                                               view3,nil];
    
    // navigationBarの背景
    UIImage *image = [UIImage imageNamed:@"bg_header.png"];
    [self.outletNavigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	for (NSUInteger i =0; i < [self.controllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
    
	self.outletPageControl.currentPage = 0;
	_page = 0;
	[self.outletPageControl setNumberOfPages:[self.controllers count]];
    
	UIViewController *viewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
    
    // scrollViewのサイズ
	self.outletScrollView.contentSize = CGSizeMake(outletScrollView.frame.size.width * [self.controllers count], outletScrollView.frame.size.height);

}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	UIViewController *viewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidAppear:animated];
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	UIViewController *viewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillDisappear:animated];
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	UIViewController *viewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidDisappear:animated];
	}
	[super viewDidDisappear:animated];
}

- (void)loadScrollViewWithPage:(int)page {
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
}

#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	UIViewController *oldViewController = [self.controllers objectAtIndex:_page];
	UIViewController *newViewController = [self.controllers objectAtIndex:self.outletPageControl.currentPage];
	[oldViewController viewDidDisappear:YES];
	[newViewController viewDidAppear:YES];
    
	_page = self.outletPageControl.currentPage;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - IBAction

- (IBAction)actionShowMenuButton:(UIButton *)sender {
    [self.viewDeckController toggleLeftView];
}

- (IBAction)actionNotificationButton:(UIButton *)sender {
    NSLog(@"Notifivation");
    
}

- (IBAction)actionSetConditionsButton:(UIButton *)sender {
    NSLog(@"setConditions");
    
}

- (void)viewDidUnload {
    [self setOutletScrollView:nil];
    [self setOutletPageControl:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}
@end
