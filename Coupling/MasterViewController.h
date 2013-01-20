//
//  MasterViewController.h
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class SearchResultViewController;
@class PurchaseViewController;
@class PFPairSearchViewDeckController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *        detailViewController;
@property (strong, nonatomic) SearchResultViewController *  searchResultViewController;
@property (strong, nonatomic) PurchaseViewController *      purchaseViewController;
@property (strong, nonatomic) PFPairSearchViewDeckController * pairSearchViewDeckController;

@end
