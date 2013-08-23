//
//  PFProfileTableViewCell.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfileTableViewCell.h"
#import "PFUtil.h"

@implementation PFProfileTableViewCell
{
    //文字列
    NSString *title;
    NSString *description;
    //ラベル
    UILabel *descriptionLabel;
    //表示データ
    PFProfile *user;
}

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        //初期化
        [self initView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)initView
{
    if (descriptionLabel == nil)
    {
        descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(95, 7, 200, 30)];
        [descriptionLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        [descriptionLabel setNumberOfLines:0];
        [descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [self addSubview:descriptionLabel];
    }
}

- (void)initCell:(PFProfile *)dict withRow:(int)row
{
    //背景指定
    if (row %2 == 0)
    {
        //[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    }
    else
    {
        //[self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@""]]];
    }
    
    user = dict;
    
    //文字列初期化
    title       = @"";
    description = @"";
    
    __block NSDictionary *strdict = [self getDescroptionAndTitleWithRow:row];
    
    //データ取得
    dispatch_queue_t gcd_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(gcd_queue, ^{
        
        title       = [strdict objectForKey:@"title"];
        description = [strdict objectForKey:@"description"];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [descriptionLabel setText:description];
            CGSize size = [description sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13.0f] constrainedToSize:CGSizeMake(200, 500) lineBreakMode:NSLineBreakByWordWrapping];
            if (row == 9)
            {
                [descriptionLabel setFrame:CGRectMake(20, 7, 270, size.height)];
            }
            else
            {
                [descriptionLabel setFrame:CGRectMake(130, 7, 200, size.height)];
            }
            
            if (size.height - 25 <= 0)
            {
                if (row == 9)
                {
                    [descriptionLabel setFrame:CGRectMake(descriptionLabel.frame.origin.x, 28, descriptionLabel.frame.size.width, size.height)];
                }
                else
                {
                    [descriptionLabel setFrame:CGRectMake(descriptionLabel.frame.origin.x, 7, descriptionLabel.frame.size.width, size.height)];
                }
            }
            else
            {
                [descriptionLabel setFrame:CGRectMake(descriptionLabel.frame.origin.x, self.frame.size.height - size.height - 6, descriptionLabel.frame.size.width, size.height)];
            }
            
            //描画処理
            [self setNeedsDisplay];
        });
    });
}

#pragma mark - Draw Method
- (void)drawRect:(CGRect)rect
{
    //タイトル
    [[UIColor blackColor] set];
    [title     drawInRect:CGRectMake(20, 7, 100, 20)
                 withFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0f]
            lineBreakMode:NSLineBreakByTruncatingTail
                alignment:NSTextAlignmentLeft];
}

#pragma mark - Self Methods
- (NSDictionary *)getDescroptionAndTitleWithRow:(int)row
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    NSString *descriptionStr = @"";
    NSString *titleStr = @"";
    switch (row) {
        case 9:
            descriptionStr = [user introduction];
            titleStr       = @"自己紹介";
            break;
        case 0:
            //TODO: JSONの値を表示する
            descriptionStr = @"";
            titleStr       = @"合コン参加人数";
            break;
        case 1:
            //TODO: JSONの値を表示する
            descriptionStr = @"";
            titleStr       = @"合コン希望場所";
            break;
        case 2:
            //TODO: JSONの値を表示する
            descriptionStr = @"";
            titleStr       = @"合コン希望時間";
            break;
        case 3:
            descriptionStr = [[PFUtil bloodTypes] objectAtIndex:[user bloodType]];
            titleStr       = @"血液型";
            break;
        case 4:
            descriptionStr  = [[PFUtil bodyShapes] objectAtIndex:[user proportion]];
            titleStr       = @"体型";
            break;
        case 5:
            descriptionStr = [[PFUtil schoolBackgrounds] objectAtIndex:[user schoolBackGoround]];
            titleStr       = @"学歴";
            break;
        case 6:
            descriptionStr = [[PFUtil jobs] objectAtIndex:[user job]];
            titleStr       = @"職業";
            break;
        case 7:
            descriptionStr = [[PFUtil incomes] objectAtIndex:[user income]];
            titleStr       = @"年収";
            break;
        case 8:
            descriptionStr = [[PFUtil dayOff] objectAtIndex:[user holiday]];
            titleStr       = @"休日";
            break;
        default:
            break;
    }
    [dict setObject:descriptionStr forKey:@"description"];
    [dict setObject:titleStr       forKey:@"title"];
    return dict;
}

@end
