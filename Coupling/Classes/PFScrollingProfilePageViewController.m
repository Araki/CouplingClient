//
//  PFScrollingProfilePageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/21.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFScrollingProfilePageViewController.h"
#import "ApiController.h"
#import "PFProfile.h"
#import "PFUtil.h"
#import "PFUser.h"

@interface PFScrollingProfilePageViewController ()
{
    IBOutlet UILabel *nickname_label;
    IBOutlet UILabel *age_label;
    IBOutlet UILabel *prefecture_label;
    IBOutlet UILabel *country_label;
    IBOutlet UILabel *height_label;
    IBOutlet UILabel *blood_type_label;
    IBOutlet UILabel *gender_label;
    IBOutlet UILabel *job_label;
    
    IBOutlet UILabel *hobbies_label;
    IBOutlet UILabel *holiday_label;
    IBOutlet UILabel *income_label;
    
    IBOutlet UILabel *schoolBackGoround_label;
    IBOutlet UILabel *proportion_label;
    IBOutlet UILabel *smoking_label;
    IBOutlet UILabel *alcohol_label;
    IBOutlet UILabel *roommate_label;
    
    IBOutlet UITextView *introduction_text;
    
    IBOutlet UIImageView *imageView;
    
    //ボタン
    IBOutlet UIButton *favbutton;
    IBOutlet UIButton *likebutton;
    IBOutlet UIButton *facebook_btn;
    IBOutlet UIButton *facebook_btn2;
    
    IBOutlet UILabel *point_label;
    
    NSString *target_id;
    
    //お気に入りステータス 0:未 1:済
    int fav_status;
    
    //いいね！ステータス 0:未 1:済 2:フレンド
    int like_status;
    
    NSArray *apiary;
    
    
}
@end

@implementation PFScrollingProfilePageViewController

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
    // Do any additional setup after loading the view from its nib.
    fav_status = 0;
    like_status = 0;
    apiary = [NSArray arrayWithObjects:@"create",@"destory" ,nil];
}

-(void)check
{
    PFUser *user = [PFUser currentUser];
    ///////フレンドかどうか
    NSMutableDictionary *param =  [[NSMutableDictionary alloc] initWithObjects:
                                   [NSArray arrayWithObjects:user.sessionId, target_id,nil]
                                                                       forKeys: [NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    // friends/show
    NSDictionary *jsonObject =  [ApiController api:@"friends/show"
                                         andParams:param
                                     andHttpMethod:@"GET"
                                       andDelegate:nil
                                 ];
    if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
        //フレンド済み
        [self changeLikeStatus:2];
    } else {
        ///////いいね！済みかどうか
        // likes/show
        jsonObject =  [ApiController api:@"likes/show"
                               andParams:param
                           andHttpMethod:@"GET"
                             andDelegate:nil
                       ];
        if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
            [self changeLikeStatus:1];
        } else {
            [self changeLikeStatus:0];
        }
    }
    
    ///////お気に入り済みかどうか
    // favorites/show
    jsonObject =  [ApiController api:@"favorites/show"
                           andParams:param
                       andHttpMethod:@"GET"
                         andDelegate:nil
                   ];
    if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
        [self changeFavStatus:1];
    } else {
        [self changeFavStatus:0];
    }
    
    ///////ユーザー詳細
    param =  [[NSMutableDictionary alloc] initWithObjects:
              [NSArray arrayWithObjects:user.sessionId,nil]
                        forKeys: [NSArray arrayWithObjects:@"session_id", nil]];
    // users/(:id)/show
    jsonObject =  [ApiController api:[NSString stringWithFormat:@"users/%@/show",target_id]
                           andParams:param
                       andHttpMethod:@"GET"
                         andDelegate:nil
                   ];
    if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
        NSDictionary *pro = [[jsonObject objectForKey:@"user"]objectForKey:@"profile"];
        point_label.text =  [NSString stringWithFormat:@"%@",[pro objectForKey:@"like_point"]];
        if([pro objectForKey:@"facebook_id"] == nil) {
            facebook_btn.enabled = NO;
            facebook_btn2.enabled = NO;
        }
    }
}

//いいね！管理
-(void)changeLikeStatus:(int)status{
    like_status = status;
    if(status == 0)
        [likebutton setImage:[UIImage imageNamed:@"button_like.png"] forState:UIControlStateNormal];
    else if(status == 1)
        [likebutton setImage:[UIImage imageNamed:@"button_liked.png"] forState:UIControlStateNormal];
    else if(status == 2)
        [likebutton setImage:[UIImage imageNamed:@"button_talk.png"] forState:UIControlStateNormal];
}

//お気に入り管理
-(void)changeFavStatus:(int)status{
    fav_status = status;
    if(status == 0)
        [favbutton setImage:[UIImage imageNamed:@"button_favorite.png"] forState:UIControlStateNormal];
    else
        [favbutton setImage:[UIImage imageNamed:@"button_favorited.png"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionOpenFacebook:(id)sender {
    NSLog(@"openfacebook");
}

- (IBAction)actionViewingFacebookPage:(id)sender {
    NSLog(@"viewingFacebook");
}

- (IBAction)actionFavorite:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *param =  [[NSMutableDictionary alloc] initWithObjects:
                             [NSArray arrayWithObjects:user.sessionId, target_id,nil]
                            forKeys: [NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    //favorites/create
    NSDictionary *jsonObject =  [ApiController
                                 api:[NSString stringWithFormat:@"favorites/%@",
                                      [apiary objectAtIndex:fav_status]]
                                 andParams:param
                                 andHttpMethod:@"POST"
                                 andDelegate:nil
                                 ];

    if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
        [self changeFavStatus:(fav_status==1?0:1)];
    }
}

// いいねボタンかトークボタンが押されたときのアクション
- (IBAction)actionLikeOrTalk:(UIButton *)sender {
    if(like_status == 2){
        [self.delegate showTalkPage];
    } else {
        PFUser *user = [PFUser currentUser];
        NSMutableDictionary *param =  [[NSMutableDictionary alloc] initWithObjects:
                                       [NSArray arrayWithObjects:user.sessionId, target_id,nil]
                                                                           forKeys: [NSArray arrayWithObjects:@"session_id", @"target_id", nil]];

        //likes/create
        NSDictionary *jsonObject =  [ApiController
                                     api:[NSString stringWithFormat:@"likes/%@",
                                          [apiary objectAtIndex:like_status]]
                                     andParams:param
                                     andHttpMethod:@"POST"
                                     andDelegate:nil
                                     ];
        if([[jsonObject objectForKey:@"status"]isEqual:@"OK" ]) {
            [self changeLikeStatus:(like_status==1?0:1)];
        }
    }
}


-(void)setUserId:(NSString*)user_id{
    target_id = [NSString stringWithFormat:@"%@",user_id];
    [self performSelector:@selector(check) withObject:nil];
}
-(void)setProfile:(NSDictionary*)dic{
    PFProfile *profile = [[PFProfile alloc] initWithDictionary:dic];
    nickname_label.text = profile.nickName;
    age_label.text      = [NSString stringWithFormat:@"%d歳",profile.age];
    prefecture_label.text = [PFUtil.prefectures objectAtIndex:profile.prefecture];
//    country_label.text = profile.;
    height_label.text = [PFUtil.prefectures objectAtIndex:profile.height];
    blood_type_label.text = [PFUtil.bloodTypes objectAtIndex:profile.bloodType];
    gender_label.text = [PFUtil.prefectures objectAtIndex:profile.gender];
    job_label.text = [PFUtil.jobs objectAtIndex:profile.job];
    holiday_label.text = [PFUtil.dayOff objectAtIndex:profile.holiday];
    hobbies_label.text = [PFUtil.prefectures objectAtIndex:profile.holiday];
    NSMutableString *hobbies = [NSMutableString new];
    for (int i=0; [profile.hobbies count]; i++) {
//        [hobbies appendString:[PFUtil.hobbies objectAtIndex:[[[profile.hobbies objectAtIndex:i] objectForKey:@"id"] intValue]]];
        [hobbies appendString:[PFUtil.hobbies objectAtIndex:[[profile.hobbies objectAtIndex:i]intValue]]];
        if(i != [profile.hobbies count] -1 )
            [hobbies appendString:@","];
    }
    hobbies_label.text = hobbies;
    
    income_label.text = [PFUtil.incomes objectAtIndex:profile.income];
    schoolBackGoround_label.text = [PFUtil.prefectures objectAtIndex:profile.schoolBackGoround];
    proportion_label.text = [PFUtil.prefectures objectAtIndex:profile.proportion];
    smoking_label.text = [PFUtil.smoking objectAtIndex:profile.smoking];
    alcohol_label.text = [PFUtil.alcohol objectAtIndex:profile.alcohol];
    roommate_label.text = [PFUtil.roommates objectAtIndex:profile.roommate];
    introduction_text.text = profile.introduction;
    
}


@end
