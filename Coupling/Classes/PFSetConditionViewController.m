//
//  PFSetConditionViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFSetConditionViewController.h"

@interface PFSetConditionViewController ()

@property (strong) NSArray *conditionListArray;

@end

@implementation PFSetConditionViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = @"お相手検索";    
    
    
    // 
    self.conditionListArray = [PFUtil searchConditionTitles];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return kPFSearchConditionNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConditionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *conditionTitleLabel = cell.textLabel;
    UILabel *conditionDetailLabel = cell.detailTextLabel;
    NSString *conditionTitle = [self.conditionListArray objectAtIndex:indexPath.row];
    [conditionTitleLabel setText:conditionTitle];
    [conditionTitleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [conditionTitleLabel setFrame:CGRectMake(0, 0, 200, 30)];
    [conditionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [conditionTitleLabel setBackgroundColor:kPFBackGroundColor];
    [conditionDetailLabel setText:@""];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:kPFBackGroundColor];
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

#pragma mark - Pickerview delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentPath];
    cell.detailTextLabel.text = [[self arrayForPicker:self.currentPath.row] objectAtIndex:row];
    [cell setNeedsLayout];
}

#pragma mark - Pickerview datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
	return [self arrayForPicker:self.currentPath.row].count;
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[self arrayForPicker:self.currentPath.row] objectAtIndex:row];
}


- (void)dismissActionSheet:(id)sender
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}


- (NSArray *)arrayForPicker:(NSInteger)row
{
    switch (row) {
        case Age:
            // 年齢
            return [PFUtil alcohol];
        case Address:
            // 居住地
            return [PFUtil prefectures];
        case Introduction:
            // 自己紹介文
            return [PFUtil introductions];
        case HomeTown:
            // 出身地
            return [PFUtil prefectures];
        case BloodType:
            // 血液型
            return [PFUtil bloodTypes];
        case Height:
            // 身長
            return [PFUtil heights];
        case Body:
            // 体型
            return [PFUtil bodyShapes];
        case Education:
            // 学歴
            return [PFUtil schoolBackgrounds];
        case Occupation:
            // 職業
            return [PFUtil jobs];
        case Income:
            // 年収
            return [PFUtil incomes];
        case Holiday:
            // 休日
            return [PFUtil dayOff];
        case Hobbies:
            // 趣味・活動
            return [PFUtil hobbies];
        case Personality:
            // 性格
            return [PFUtil personalities];
        case Roommate:
            // 同居人
            return [PFUtil roommates];
        case Tabaco:
            // タバコ
            return [PFUtil smoking];
        case Alcohol:
            // お酒
            return [PFUtil alcohol];
        case LastLoginData:
            // 最終ログイン日
            return [PFUtil lastLogines];
            
        default:
            return [NSArray arrayWithObject:nil];
            break;
    }
    
}

@end
