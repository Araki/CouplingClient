//
//  PFProfilePictureSelectTableViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/07.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfilePictureSelectTableViewController.h"
#import "PFProfilePictureSelectTableViewCell.h"
#import "PFUserModel.h"

@interface PFProfilePictureSelectTableViewController ()

@property(retain, nonatomic) PFUserModel *user;

@end

@implementation PFProfilePictureSelectTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
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
    self.view.backgroundColor = kPFBackGroundColor;

    // navigationBarの設定
    UIButton *topRightBarButton = [PFUtil addPictureButton];
    [topRightBarButton addTarget:self action:@selector(addPicture) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:topRightBarButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    // test
    self.user = [[PFUserModel alloc] init];
    
    UIImage *testImage1 = [UIImage imageNamed:@"test_why_always_me.jpeg"];
    UIImage *testImage2 = [UIImage imageNamed:@"test_imgres.jpeg"];
    [self.user.profileImages addObject:testImage1];
    [self.user.profileImages addObject:testImage2];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 写真追加 - NavigationBarの右のボタン
- (void)addPicture
{
    NSString *title         = @"写真追加";
    NSString *cancel        = @"キャンセル";
    NSString *takePhotos    = @"写真を撮る";
    NSString *fromLibrary   = @"ライブラリから選択";
    UIActionSheet *actionSheet = [[UIActionSheet alloc] init];
    [actionSheet setDelegate:self];
    [actionSheet setTitle:title];
    [actionSheet addButtonWithTitle:takePhotos];
    [actionSheet addButtonWithTitle:fromLibrary];
    [actionSheet addButtonWithTitle:cancel];
    [actionSheet setCancelButtonIndex:2];
    [actionSheet showInView:self.view];
}

#pragma mark - Action sheet delegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    [imagePicker setDelegate:self];
    switch (buttonIndex) {
        case 0:
            [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
            [self presentModalViewController:imagePicker animated:YES];
            break;
        case 1:
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            [self presentModalViewController:imagePicker animated:YES];
            break;
        default:
            break;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    // 選択されたイメージを追加
    [self.user.profileImages addObject:image];
    // リロードする
    [self.tableView reloadData];
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  self.user.profileImages.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProfilePictureSelectCell";
    
    PFProfilePictureSelectTableViewCell* cell = (PFProfilePictureSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UINib* nib = [UINib nibWithNibName:@"PFProfilePictureSelectTableViewCell" bundle:nil];
        NSArray* array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.outletUserImage.image = [UIImage imageNamed:@"test_imgres_1.jpeg"];
        cell.delegate = self;
    }
    cell.outletUserImage.image = [self.user.profileImages objectAtIndex:indexPath.row];
    // 何番目のボタンがタップされたかわかるようにボタンのタグにindexPath.rowをナンバリングする
    cell.outletSetMainButton.tag = indexPath.row;
    cell.outletDeleteButton.tag  = indexPath.row;
    
    if (indexPath.row == 0) {
        [cell.outletSetMainButton setHidden:YES];
        [cell.outletDeleteButton setHidden:YES];
        [cell.outletMainImageView setHidden:NO];
    } else {
        [cell.outletSetMainButton setHidden:NO];
        [cell.outletDeleteButton setHidden:NO];
        [cell.outletMainImageView setHidden:YES];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selectedIndexPath.row = %d", indexPath.row);
}

#pragma mark - PFProfilePictureSelectTableViewCell delegate

// メインにするボタン
- (void)setMainButtonWithIndex:(NSInteger)index
{
    // 選択したイメージを一番上に挿入する
    [self.user.profileImages insertObject:[self.user.profileImages objectAtIndex:index] atIndex:0];
    [self.user.profileImages removeObjectAtIndex:index + 1];
    [self.tableView reloadData];
}

// 削除するボタン
- (void)deleteButtonWithIndex:(NSInteger)index
{
    [self.user.profileImages removeObjectAtIndex:index];
    [self.tableView reloadData];
}

@end
