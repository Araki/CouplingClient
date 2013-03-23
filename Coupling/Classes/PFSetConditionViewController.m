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
    self.actionSheet = [self actionSheetWithRow:indexPath.row];
    self.currentPath = indexPath;
}

#pragma mark - PFActionSheetDelegate
- (void)dismissOkButtonWithTitles:(NSArray *)titles
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title
{
    NSLog(@"component = %d : title = %@", component, title);    
}

- (PFActionSheet *)actionSheetWithRow:(NSInteger)row
{
    NSInteger numOfComponents = 1;
    NSArray *title1 = nil;
    NSArray *title2 = nil;
    NSArray *title3 = nil;
    switch (row) {
        case Age:
            // 年齢
            title1 = [PFUtil alcohol];
            break;
        case Address:
            // 居住地
            title1 = [PFUtil prefectures];
            break;
        case Introduction:
            // 自己紹介文
            title1 = [PFUtil introductions];
            break;
        case HomeTown:
            // 出身地
            title1 = [PFUtil prefectures];
            break;
        case BloodType:
            // 血液型
            title1 = [PFUtil bloodTypes];
            break;
        case Height:
            // 身長
            numOfComponents = 2;
            title1 = [PFUtil heights];
            title2 = [PFUtil heights];
            break;
        case Body:
            // 体型
            title1 = [PFUtil bodyShapes];
            break;
        case Education:
            // 学歴
            title1 = [PFUtil schoolBackgrounds];
            break;
        case Occupation:
            // 職業
            title1 = [PFUtil jobs];
            break;
        case Income:
            // 年収
            title1 = [PFUtil incomes];
            break;
        case Holiday:
            // 休日
            title1 = [PFUtil dayOff];
            break;
        case Hobbies:
            // 趣味・活動
            title1 = [PFUtil hobbies];
            break;
        case Personality:
            // 性格
            title1 = [PFUtil personalities];
            break;
        case Roommate:
            // 同居人
            title1 = [PFUtil roommates];
            break;
        case Tabaco:
            // タバコ
            title1 = [PFUtil smoking];
            break;
        case Alcohol:
            // お酒
            title1 = [PFUtil alcohol];
            break;
        case LastLoginData:
            // 最終ログイン日
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
