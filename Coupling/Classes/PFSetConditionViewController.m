//
//  PFSetConditionViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFSetConditionViewController.h"

@interface PFSetConditionViewController ()

@property (nonatomic, strong) NSArray *conditionListArray; // 各検索条件のタイトル
@property (nonatomic, strong) NSMutableArray *detailListArray; // 選択された検索条件が入る

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
    self.detailListArray = [NSMutableArray arrayWithCapacity:kPFProfileTitleListNum];
    for (int i = 0; i < kPFProfileTitleListNum; i++) {
        [self.detailListArray addObject:[NSNull null]];
    }
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
        UILabel *conditionDetailLabel = cell.detailTextLabel;
        [conditionDetailLabel setText:@""];
        
    }
    [self updateCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)updateCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    UILabel *conditionTitleLabel = cell.textLabel;
   
    NSString *conditionTitle = [self.conditionListArray objectAtIndex:indexPath.row];
    [conditionTitleLabel setText:conditionTitle];
    [conditionTitleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [conditionTitleLabel setFrame:CGRectMake(0, 0, 200, 30)];
    [conditionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [conditionTitleLabel setBackgroundColor:kPFBackGroundColor];
    if (![[self.detailListArray objectAtIndex:indexPath.row]isEqual:[NSNull null]]) {
        cell.detailTextLabel.text = [self.detailListArray objectAtIndex:indexPath.row];
    } else {
        cell.detailTextLabel.text = @"";
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:kPFBackGroundColor];
}

#pragma mark - Tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.actionSheet = [self actionSheetWithRow:indexPath.row];
    self.currentPath = indexPath;
}

#pragma mark - PFActionSheet Delegate

- (void)dismissOkButtonWithTitles:(NSArray *)titles type:(kPFActionSheetType)type
{
    NSLog(@"titles = %@", titles);
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentPath];
    NSString *detail = nil;
    if (self.currentPath.row == Condition_Height) {
        NSString *fromValue = [titles objectAtIndex:0];
        NSString *toValue   = [titles objectAtIndex:1];
        detail = [NSString stringWithFormat:@"%@cm~%@cm", fromValue, toValue];
        cell.detailTextLabel.text = detail;
    } else {
        detail = [titles objectAtIndex:0];
        cell.detailTextLabel.text = detail;
    }
    [cell setNeedsLayout];
    [self.detailListArray replaceObjectAtIndex:self.currentPath.row withObject:detail];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type
{
    NSLog(@"component = %d : title = %@", component, title);
}

- (PFActionSheet *)actionSheetWithRow:(kPFConditionTitleList)row
{
    NSInteger numOfComponents = 1;
    NSArray *title1 = nil;
    NSArray *title2 = nil;
    NSArray *title3 = nil;
    switch (row) {
        case Condition_Age:
            title1 = [PFUtil alcohol];
            break;
        case Condition_Address:
            title1 = [PFUtil prefectures];
            break;
        case Condition_Introduction:
            title1 = [PFUtil introductions];
            break;
        case Condition_HomeTown:
            title1 = [PFUtil prefectures];
            break;
        case Condition_BloodType:
            title1 = [PFUtil bloodTypes];
            break;
        case Condition_Height:
            numOfComponents = 2;
            title1 = [PFUtil heights];
            title2 = [PFUtil heights];
            break;
        case Condition_Body:
            title1 = [PFUtil bodyShapes];
            break;
        case Condition_Education:
            title1 = [PFUtil schoolBackgrounds];
            break;
        case Condition_Occupation:
            title1 = [PFUtil jobs];
            break;
        case Condition_Income:
            title1 = [PFUtil incomes];
            break;
        case Condition_Holiday:
            title1 = [PFUtil dayOff];
            break;
        case Condition_Hobbies:
            title1 = [PFUtil hobbies];
            break;
        case Condition_Personality:
            title1 = [PFUtil personalities];
            break;
        case Condition_Roommate:
            title1 = [PFUtil roommates];
            break;
        case Condition_Tabaco:
            title1 = [PFUtil smoking];
            break;
        case Condition_Alcohol:
            title1 = [PFUtil alcohol];
            break;
        case Condition_LastLoginData:
            title1 = [PFUtil lastLogines];
            break;
            
        default:
            title1 = [NSArray arrayWithObject:nil];
            break;
    }
    
    PFActionSheet *sheet = [PFActionSheet sheetWithView:self.view
                                                  frame:CGRectMake(0, 150, 320, 485)
                                               delegate:self
                                                 titles:title1, title2, title3, nil];
    return sheet;
}

@end
