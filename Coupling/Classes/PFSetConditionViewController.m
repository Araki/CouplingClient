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
{
    UIImageView *footerView;
}

#pragma mark  - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = @"お相手検索";
    self.detailListArray = [NSMutableArray arrayWithCapacity:kPFProfileTitleListNum];
    
    for (int i = 0; i < kPFProfileTitleListNum; i++)
    {
        [self.detailListArray addObject:[NSNull null]];
    }
    
    self.conditionListArray = [PFUtil searchConditionTitles];
    
    
    //Frame調整
    [self.tableView setFrame:CGRectMake(0, 0, 320, self.tableView.frame.size.height - 55)];
    //フッター作成
    footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 109, 320, 65)];
    [footerView setUserInteractionEnabled:YES];
    [footerView setImage:[UIImage imageNamed:@"bg_footer"]];
    [self.view addSubview:footerView];
    //検索ボタン
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setImage:[UIImage imageNamed:@"button_search"] forState:UIControlStateNormal];
    [searchButton setFrame:CGRectMake(20, 23, 169, 35)];
    [searchButton addTarget:self action:@selector(searchUser) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:searchButton];
    //条件クリアボタン
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [clearButton setImage:[UIImage imageNamed:@"button_clear"] forState:UIControlStateNormal];
    [clearButton setFrame:CGRectMake(225, 30, 81, 27)];
    [clearButton addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:clearButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions
- (void)clearData
{
    self.detailListArray = [NSMutableArray arrayWithCapacity:kPFProfileTitleListNum];
    for (int i = 0; i < kPFProfileTitleListNum; i++)
    {
        [self.detailListArray addObject:[NSNull null]];
    }
    [self.tableView reloadData];
}

- (void)searchUser
{
    [self.setConditionViewControllerDelegate setSearchCondition:self.detailListArray];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kPFSearchConditionNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ConditionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        UILabel *conditionDetailLabel = cell.detailTextLabel;
        [conditionDetailLabel setText:@""];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.actionSheet = [self actionSheetWithRow:indexPath.row];
    self.currentPath = indexPath;
}

#pragma mark - PFActionSheet Delegate

- (void)dismissOkButtonWithTitles:(NSArray *)titles type:(kPFActionSheetType)type
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.currentPath];
    NSString *detail;
    if (self.currentPath.row == Condition_Age)
    {
        detail = [NSString stringWithFormat:@"%@〜%@",[titles objectAtIndex:0],[titles objectAtIndex:1]];
    }
    else
    {
        detail = [titles objectAtIndex:0];
    }
    cell.detailTextLabel.text = detail;
    [cell setNeedsLayout];
    [self.detailListArray replaceObjectAtIndex:self.currentPath.row withObject:detail];
}

- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type
{
    NSLog(@"component = %d : title = %@", component, title);
}

- (PFActionSheet *)actionSheetWithRow:(kPFConditionTitleList)row
{
    NSArray *title1 = nil;
    NSArray *title2 = nil;
    NSArray *title3 = nil;
    switch (row) {
        case Condition_Age:
            title1 = [PFUtil age];
            title2 = [PFUtil age];
            break;
        case Condition_Introduction:
            title1 = [PFUtil introductions];
            break;
        case Condition_People:
            
            break;
        case Condition_Day:
            
            break;
        case Condition_Time:
            
            break;
        case Condition_GoconAge:
            
            break;
        case Condition_Location:
            
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
        case Condition_LastLoginData:
            title1 = [PFUtil lastLogines];
            break;
        default:
            title1 = [NSArray arrayWithObject:nil];
            break;
    }
    
    PFActionSheet *sheet = [PFActionSheet sheetWithView:self.view
                                              frameType:defaultFrameType
                                               delegate:self
                                                 titles:title1, title2, title3, nil];
    return sheet;
}

@end
