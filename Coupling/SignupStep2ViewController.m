//
//  SignupStep2ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "SignupStep2ViewController.h"
#import "SignupStep4ViewController.h"
#import "PFUtil.h"

@interface SignupStep2ViewController ()

- (void)dismissActionSheet:(id)sender;
- (NSArray *)arrayForPicker:(NSInteger)row;

@end

@implementation SignupStep2ViewController

@synthesize tableView;
@synthesize nicknameField;
@synthesize actionSheet;
@synthesize currentPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = kPFCommonBackGroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    self.actionSheet = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        return [self dequeueTexeCell:row];
    } else {
        return [self dequeueNormalCell:row];
    }
}

- (UITableViewCell *)dequeueTexeCell:(NSInteger)row
{
    static NSString *CellIdentifier = @"TextCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 20.0)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = @"ニックネーム";
        [cell.contentView addSubview:label];
        
        self.nicknameField = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 10.0, 170.0, 20.0)];
        self.nicknameField.delegate = self;
        self.nicknameField.borderStyle = UITextBorderStyleRoundedRect;
        self.nicknameField.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
        self.nicknameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.nicknameField.textAlignment = NSTextAlignmentCenter;
        self.nicknameField.returnKeyType = UIReturnKeyDone;
        self.nicknameField.clearButtonMode = UITextFieldViewModeNever;
        self.nicknameField.adjustsFontSizeToFitWidth = YES;
        [cell.contentView addSubview:self.nicknameField];
    }
    return cell;
}

- (UITableViewCell *)dequeueNormalCell:(NSInteger)row
{
    static NSString *CellIdentifier = @"NormalCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.detailTextLabel.text = nil;
    }
    cell.textLabel.text = [self profileItemText:row];
    return cell;
}

- (NSString *)profileItemText:(NSInteger)row
{
    NSArray *items = [NSArray arrayWithObjects:@"ニックネーム", @"お住まいのエリア", @"血液型", @"体型", @"学歴", @"職業", @"年収", @"休日", nil];
    return (NSString *)[items objectAtIndex:row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
        
    }
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"閉じる"]];
    closeButton.momentary = YES;
    closeButton.frame = CGRectMake(260, 7.0, 50.0, 30.0);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blueColor];
    [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
    [self.actionSheet addSubview:closeButton];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40.0, 0, 0)];
    pickerView.dataSource = self;
	pickerView.delegate = self;
	pickerView.showsSelectionIndicator = YES;
    [self.actionSheet addSubview:pickerView];
    [self.actionSheet showInView:self.view];
	[self.actionSheet setFrame:CGRectMake(0, 150, 320, 485)];
    
    self.currentPath = indexPath;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

#pragma mark UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedRow = row;
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
	return [self arrayForPicker:self.currentPath.row].count;
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self arrayForPicker:self.currentPath.row] objectAtIndex:row];
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -

- (void)dismissActionSheet:(id)sender
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentPath];
    cell.detailTextLabel.text = [[self arrayForPicker:self.currentPath.row] objectAtIndex:self.selectedRow];
    self.selectedRow = 0;
    [cell setNeedsLayout];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (NSArray *)arrayForPicker:(NSInteger)row
{
    switch (row) {
        case 0:
            // ニックネーム
        case 1:
            // お住まいのエリア
            return [PFUtil prefectures];
        case 2:
            //血液型
            return [PFUtil bloodTypes];
        case 3:
            // 体型
            return [PFUtil bodyShapes];
        case 4:
            // 学歴
            return [PFUtil schoolBackgrounds];
        case 5:
            // 職業
            return [PFUtil jobs];
        case 6:
            // 年収
            return [PFUtil incomes];
        case 7:
            // 休日
            return [PFUtil dayOff];
        default:
            return [NSArray arrayWithObject:nil];
            break;
    }
    
}

- (IBAction)goNextView:(id)sender
{
    if (self.nicknameField.text == nil) {
        [self showAlert:@"ニックネームを確認してください。"];
        return;
    }
    for (int i = 1; i < [self.tableView numberOfRowsInSection:0]; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        if ([self.tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text == nil) {
            [self showAlert:[NSString stringWithFormat:@"%@を確認してください。", [self profileItemText:i]]];
            return;
        }
    }
    SignupStep4ViewController *signupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupStep4ViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

- (void)showAlert:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Pairful" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
