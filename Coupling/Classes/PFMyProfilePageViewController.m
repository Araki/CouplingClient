//
//  PFMyProfilePageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/06.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyProfilePageViewController.h"
#import "IIViewDeckController.h"
#import "PFHTTPConnector.h"
#import "PFProfile.h"
#import "SignupStep2ViewController.h"

@interface PFMyProfilePageViewController ()

@property (nonatomic, strong) PFProfile *profile;

@end

@implementation PFMyProfilePageViewController

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
        PFUser *user = [PFUser currentUser];
        
        NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId,nil] forKeys: [NSArray arrayWithObjects:@"session_id", nil]];
        
        [PFHTTPConnector requestWithCommand:kPFCommandProfileShow params:params onSuccess:^(PFHTTPResponse *response) {
            NSDictionary *jsonObject = [response jsonDictionary];
            NSDictionary *profileDic = [jsonObject objectForKey:@"profile"];
            if(profileDic) {
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    _profile = [PFProfile dataModelWithDictionary:profileDic];
                    [self showProfileImage];
                    NSLog(@"myProfileJson = %@", [jsonObject description]);
                });
            }
        } onFailure:^(NSError *error) {
            NSLog(@"@@@@@ connection Error: %@", error);
        }];
    }
    return self;
}

- (void)showProfileImage
{
    NSArray *imagesArray = self.profile.images;
    for (PFImageModel *imageModel in imagesArray) {
        if (imageModel.isMain) {
            self.outletUserProfileImageView.image = imageModel.image;
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.outletTableView.backgroundColor = kPFBackGroundColor;
    self.view.backgroundColor = kPFCommonBackGroundColor;
    
    
    // test
    self.outletUserProfileImageView.image = [UIImage imageNamed:@"test_imgres.jpeg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return kPFProfileTitleListNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    UILabel *profileTitleLabel = cell.textLabel;
    
    NSString *conditionTitle = [[PFUtil profileTitles] objectAtIndex:indexPath.row];
    [profileTitleLabel setText:conditionTitle];
    [profileTitleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [profileTitleLabel setFrame:CGRectMake(0, 0, 200, 30)];
    [profileTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [profileTitleLabel setBackgroundColor:kPFBackGroundColor];
    
    cell.detailTextLabel.text = [self profileStatusForRowAtIndexPath:indexPath];
    return cell;
}

- (NSString *)profileStatusForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kPFProfileTitleList row = (kPFProfileTitleList)indexPath.row;
    NSString *status = nil;
    PFProfile *prof = self.profile;
        
    switch (row) {
        case Profile_NickName:
            status = prof.nickName;
            break;
        case Profile_Birthdate:

            break;
        case Profile_Address:
            
            break;
        case Profile_Introduction:

            break;
        case Profile_BloodType:

            break;
        case Profile_Body:

            break;
        case Profile_Education:

            break;
        case Profile_Occupation:
            
            break;
        case Profile_Income:
            
            break;
        case Profile_Holiday:
            
            break;
        default:
            status = [NSArray arrayWithObject:nil];
            break;
    }
    return status;
}

// profile変更用の画面に遷移
- (IBAction)actionConfirmProfileButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    SignupStep2ViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"SignupStep2ViewController"];
    [self.navigationController pushViewController:view animated:YES];
    
}
- (void)viewDidUnload {
    [self setOutletTableView:nil];
    [self setOutletUserProfileImageView:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}
@end
