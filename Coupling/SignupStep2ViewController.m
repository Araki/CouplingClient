//
//  SignupStep2ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "SignupStep2ViewController.h"
#import "SignupStep3ViewController.h"

@interface SignupStep2ViewController ()

- (void)dismissActionSheet:(id)sender;

@end

@implementation SignupStep2ViewController

@synthesize tableView;
@synthesize actionSheet;

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
    self.tableView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:245.0/250.0 blue:230.0/250.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    self.actionSheet = nil;
    [super viewDidUnload];
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
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 10.0, 100.0, 20.0)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:14.0];
        label.text = @"ニックネーム";
        [cell.contentView addSubview:label];
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 10.0, 170.0, 20.0)];
        field.borderStyle = UITextBorderStyleRoundedRect;
        field.font = [UIFont boldSystemFontOfSize:[UIFont labelFontSize]];
        field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        field.textAlignment = UITextAlignmentCenter;
        field.returnKeyType = UIReturnKeyDone;
        field.clearButtonMode = UITextFieldViewModeNever;
        field.adjustsFontSizeToFitWidth = YES;
        
        //[textField addTarget:self action:@selector(done:) forControlEvents:UIControlEventEditingDidEndOnExit];
        
        [cell.contentView addSubview:field];
    }
    return cell;
}

- (UITableViewCell *)dequeueNormalCell:(NSInteger)row
{
    static NSString *CellIdentifier = @"NormalCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = [self profileItemText:row];
    }
    return cell;
}

- (NSString *)profileItemText:(NSInteger)row
{
    switch (row) {
        case 0:
            return @"ニックネーム";
        case 1:
            return @"お住まいがある都道府県";
        case 2:
            return @"出身地の都道府県";
        case 3:
            return @"血液型";
        case 4:
            return @"身長";
        case 5:
            return @"体型";
        case 6:
            return @"学歴";
        case 7:
            return @"職業";
        case 8:
            return @"年収";
        case 9:
            return @"休日";
        case 10:
            return @"趣味・活動";
        case 11:
            return @"性格";
        case 12:
            return @"同居人";
        case 13:
            return @"タバコ";
        case 14:
            return @"お酒";
            
        default:
            return nil;
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    self.actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"完了"]];
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
    
    
    switch (indexPath.row) {
        case 0:
            //return @"ニックネーム";
        case 1:
            //return @"お住まいがある都道府県";
            
        case 2:
            //return @"出身地の都道府県";
        case 3:
            //return @"血液型";
        case 4:
            //return @"身長";
        case 5:
            //return @"体型";
        case 6:
            //return @"学歴";
        case 7:
            //return @"職業";
        case 8:
            //return @"年収";
        case 9:
            //return @"休日";
        case 10:
            //return @"趣味・活動";
        case 11:
            //return @"性格";
        case 12:
            //return @"同居人";
        case 13:
            //return @"タバコ";
        case 14:
            //return @"お酒";
            
        default:
            break;
    }
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
	return 5;
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *album[] = {@"row1", @"row2", @"row3", @"row4", @"row5"};
    return album[row];
}

#pragma mark -

- (void)dismissActionSheet:(id)sender
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)goNextView:(id)sender
{
    SignupStep3ViewController *signupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupStep3ViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
}

@end
