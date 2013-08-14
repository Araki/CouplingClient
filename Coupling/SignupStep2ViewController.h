//
//  SignupStep2ViewController.h
//  Coupling
//
//  Created by tsuchimoto on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupStep2ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) NSIndexPath *currentPath;
@property (assign, nonatomic) NSInteger selectedRow;

- (IBAction)goNextView:(id)sender;

@end
