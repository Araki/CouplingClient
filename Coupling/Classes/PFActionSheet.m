//
//  PFActionSheet.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFActionSheet.h"

@interface PFActionSheet ()

@property (nonatomic, assign) NSInteger actionSheetType;
@property (nonatomic, assign) NSInteger numberOfComponent;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *selectedTitles; // 選択されたタイトルが入る。
@end

@implementation PFActionSheet

+ (id)sheetWithView:(UIView *)view frameType:(kPFActionSheetFrameType)frameType delegate:(id)delegate titles:(NSArray *)title,...
{
    NSMutableArray *array = [NSMutableArray array];
	va_list argp;
	va_start(argp,title);
	id value = title;
	while(value!=nil){
		[array addObject:value];
		value = va_arg(argp,id);
	}
	va_end(argp);
    return [[self alloc] initWithWithView:(UIView *)view frameType:frameType delegate:(id)delegate titles:array];
}


- (id)initWithWithView:(UIView *)view frameType:(kPFActionSheetFrameType)frameType delegate:(id)delegate titles:(NSArray *)titles
{
    self = [super initWithTitle:nil delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        // Initialization code
        self.titleArray = titles;
        self.numberOfComponent = titles.count;
        self.PFDelegate = delegate;
        switch (self.numberOfComponent) {
            case 0:
                self.actionSheetType = singleType;
                break;
            case 1:
                self.actionSheetType = dowbleType;
                break;
            case 2:
                self.actionSheetType = tripleType;
                break;
            default:
                self.actionSheetType = singleType;
                break;
        }
        self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        // ok ボタン
        UISegmentedControl *okButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"決定"]];
        okButton.momentary = YES;
        okButton.frame = CGRectMake(260, 7.0, 50.0, 30.0);
        okButton.segmentedControlStyle = UISegmentedControlStyleBar;
        okButton.tintColor = [UIColor blueColor];
        [okButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:okButton];
        
        // cancel ボタン
        UISegmentedControl *cancelButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"キャンセル"]];
        cancelButton.momentary = YES;
        cancelButton.frame = CGRectMake(10, 7.0, 70.0, 30.0);
        cancelButton.segmentedControlStyle = UISegmentedControlStyleBar;
        cancelButton.tintColor = [UIColor blackColor];
        [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventValueChanged];
        [self addSubview:cancelButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:([PFUtil is4inch]) ? CGRectMake(0, 40.0, 320, 420) : CGRectMake(0, 40, 320, 420)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:self.pickerView];
        
        [self showInView:view];
        if (view.frame.size.height == 504.0f || view.frame.size.height == 416.0f)
        {
            self.frame = [self frameWithFrameType:frameType];
        }
        else
        {
            self.frame = [self frameWithFrameTypeNonNavBar:frameType];
        }
        
    }
    return self;
}

- (CGRect)frameWithFrameType:(kPFActionSheetFrameType)frameType
{
    CGRect frame;
    switch (frameType) {
        case defaultFrameType:
            frame = ([PFUtil is4inch]) ? kPFActionSheetFrameDefault_4inch : kPFActionSheetFrameDefault;
            break;
            
        default:
            frame = ([PFUtil is4inch]) ? kPFActionSheetFrameDefault_4inch : kPFActionSheetFrameDefault;
            break;
    }
    return frame;
}

- (CGRect)frameWithFrameTypeNonNavBar:(kPFActionSheetFrameType)frameType
{
    CGRect frame;
    switch (frameType) {
        case defaultFrameType:
            frame = ([PFUtil is4inch]) ? kPFActionSheetFrameDefault_NonNavBar_4inch : kPFActionSheetFrameDefault_NonNavBar;
            break;
            
        default:
            frame = ([PFUtil is4inch]) ? kPFActionSheetFrameDefault_NonNavBar_4inch : kPFActionSheetFrameDefault_NonNavBar;
            break;
    }
    return frame;
}

- (void)dismissActionSheet:(id)sender
{
    NSMutableArray *selectedTitles =[NSMutableArray arrayWithCapacity:self.numberOfComponent];
    for (int i = 0; i < self.numberOfComponent ; i++) {
        NSInteger index = [self.pickerView selectedRowInComponent:i];
        NSArray *titleList = [self.titleArray objectAtIndex:i];
        NSString *title = [titleList objectAtIndex:index];
        [selectedTitles addObject:title];
    }
    
    [self.PFDelegate dismissOkButtonWithTitles:selectedTitles type:self.actionSheetType];
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)cancelButtonAction
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - Pickerview delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self.PFDelegate selectedWithComponent:component title:[[self.titleArray objectAtIndex:component] objectAtIndex:row] type:self.actionSheetType];
}

#pragma mark - Pickerview datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker
{
	return self.numberOfComponent;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component
{
	return [[self.titleArray objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[self.titleArray objectAtIndex:component] objectAtIndex:row];
}

@end
