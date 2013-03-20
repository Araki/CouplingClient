//
//  PFActionSheet.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFActionSheet.h"

@interface PFActionSheet ()

@property (nonatomic, assign) NSInteger numberOfComponent;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *selectedTitles; // 選択されたタイトルが入る。

@end

@implementation PFActionSheet

+ (id)sheetWithView:(UIView *)view frame:(CGRect)frame delegate:(id)delegate NumberOfComponents:(NSInteger)numOfComponent titles:(NSArray *)title,...
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
    return [[self alloc] initWithWithView:(UIView *)view frame:(CGRect)frame delegate:(id)delegate numberOfComponents:numOfComponent titles:array];
}


- (id)initWithWithView:(UIView *)view frame:(CGRect)frame delegate:(id)delegate numberOfComponents:(NSInteger)numOfComponent titles:(NSArray *)titles
{
    self = [super initWithTitle:nil delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    if (self) {
        // Initialization code
        self.titleArray = titles;
        self.numberOfComponent = numOfComponent;
        self.PFDelegate = delegate;
        
        self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        
        UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"閉じる"]];
        closeButton.momentary = YES;
        closeButton.frame = CGRectMake(260, 7.0, 50.0, 30.0);
        closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
        closeButton.tintColor = [UIColor blueColor];
        [closeButton addTarget:self action:@selector(dismissActionSheet:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:closeButton];
        
        self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40.0, 320, 420)];
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:self.pickerView];
        [self showInView:view];
        [self setFrame:frame];
    }
    return self;
}

- (void)showInView:(UIView *)view
{
    
    [super showInView:view];
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
    
    [self.PFDelegate dismissOkButtonWithTitles:selectedTitles];
}

#pragma mark - Pickerview delegate

//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
//{
//}

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
