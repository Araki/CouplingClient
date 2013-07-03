//
//  PFPairSearchProfileViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchProfileViewController.h"
#import "PFTalkPageViewController.h"


@interface PFPairSearchProfileViewController ()
{
    NSMutableData* data;
    
}
@end

@implementation PFPairSearchProfileViewController

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
        // スクロールするプロフィールページ
        self.scrollingProfileView = [[PFScrollingProfilePageViewController alloc] initWithNibName:@"PFScrollingProfilePageViewController" bundle:nil];

        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // スクロールするプロフィールページのパラメータ設定
    float width = self.scrollingProfileView.view.frame.size.width;
    float height = self.scrollingProfileView.view.frame.size.height;
    [self addChildViewController:self.scrollingProfileView];
    [self.outletProfileScrollView setContentSize:CGSizeMake(width, height)];
    [self.outletProfileScrollView addSubview:self.scrollingProfileView.view];
    
    self.outletProfileImageView.backgroundColor = kPFCommonBackGroundColor;
    
    
    
	// テスト用
//    UIImage *image = [UIImage imageNamed:@"test_imgres.jpeg"];
//    [self.outletProfileImageView setImage:image];
    [self.scrollingProfileView setProfile:[_user_dic objectForKey:@"profile"]];
    [self.scrollingProfileView setUserId:[_user_dic objectForKey:@"id"]];
    data = [[NSMutableData alloc] initWithCapacity:0];
    NSURLRequest *req = [NSURLRequest
                         requestWithURL:[NSURL URLWithString:[self getMainImageUrl:[[_user_dic objectForKey:@"profile"] objectForKey:@"images"]]]
                         cachePolicy:NSURLRequestUseProtocolCachePolicy
                         timeoutInterval:30.0];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if(conn) {
        
    }
    
}

-(NSString*)getMainImageUrl:(NSArray*)image_ary{
    for (NSDictionary *image in image_ary) {
        if([[image objectForKey:@"is_main"] boolValue] == true) {
            return [image objectForKey:@"url"];
        }
    }
    return nil;
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)nsdata{
    [data appendData:nsdata];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    [self abort:connection];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self.outletProfileImageView setImage:[UIImage imageWithData:data]];
    [self abort:connection];
}

-(void)abort:(NSURLConnection * )conn{
    if(conn != nil){
        [conn cancel];
        conn = nil;
    }
    if(data != nil){
        data = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOutletProfileImageView:nil];
    [self setOutletProfileScrollView:nil];
    [super viewDidUnload];
}
@end
