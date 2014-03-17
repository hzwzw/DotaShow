//
//  ViewController.m
//  DotaShow
//
//  Created by Jianqiang Meng on 3/13/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "ViewController.h"
#import <JASidePanelController.h>
#import <RNFrostedSidebar.h>
#import <CSAnimationView.h>
#import <FRDLivelyButton.h>

#import "ShareViewController.h"
#import "ShowGirlViewController.h"
@interface ViewController ()<RNFrostedSidebarDelegate>

@property (strong, nonatomic) RNFrostedSidebar *callout;
@property (strong, nonatomic) FRDLivelyButton *button;
@property (nonatomic, strong) NSMutableIndexSet *optionIndices;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _button = [[FRDLivelyButton alloc] initWithFrame:CGRectMake(0,0,36,28)];
    [_button setStyle:kFRDLivelyButtonStyleHamburger animated:NO];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    self.navigationItem.rightBarButtonItem = buttonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view startCanvasAnimation];
}

- (void)buttonAction:(FRDLivelyButton *)sender
{
    if (sender.buttonStyle == kFRDLivelyButtonStyleHamburger) {
        if (!_callout) {
            [self makeSlidBar];
        }
        [_callout show];
    }else
    {
        [_callout dismiss];
    }
        }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        CSAnimationView *animationView = [[CSAnimationView alloc] initWithFrame:CGRectMake(0, 0,320, 60)];
        animationView.backgroundColor = [UIColor clearColor];
        animationView.duration = 2.5;
        animationView.delay    = 0+(indexPath.row/15.0);
        animationView.type     = CSAnimationTypeBounceLeft;
        NSArray *textArray = [NSArray arrayWithObjects:@"ShowGirl",@"Share",@"ShowGirl",@"ShowGirl",@"ShowGirl",@"ShowGirl", nil];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 60)];
        label.text = textArray[indexPath.row];
        label.textColor = [UIColor blackColor];
        [animationView addSubview:label];
        [cell.contentView addSubview:animationView];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [cell startCanvasAnimation];
    if (indexPath.row ==0) {
        ShowGirlViewController *show = [[ShowGirlViewController alloc]init];
        [self.navigationController pushViewController:show animated:YES];
        return;
    }
    
    if (indexPath.row == 1) {
        ShareViewController *share = [[ShareViewController alloc]init];
        [self.navigationController pushViewController:share animated:YES];
        return;
    }
    ViewController *subView = [[ViewController alloc]init];
    [self.navigationController pushViewController:subView animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell startCanvasAnimation];
    cell.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark SlidBar delegate
- (void)sidebar:(RNFrostedSidebar *)sidebar willShowOnScreenAnimated:(BOOL)animatedYesOrNo
{
    [_button setStyle:kFRDLivelyButtonStyleClose animated:YES];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar willDismissFromScreenAnimated:(BOOL)animatedYesOrNo
{
    [_button setStyle:kFRDLivelyButtonStyleHamburger animated:YES];
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    NSLog(@"Tapped item at index %i",index);
    if (index == 3) {
        [sidebar dismissAnimated:YES];
    }
}

- (void)sidebar:(RNFrostedSidebar *)sidebar didEnable:(BOOL)itemEnabled itemAtIndex:(NSUInteger)index {
    if (itemEnabled) {
        [self.optionIndices addIndex:index];
    }
    else {
        [self.optionIndices removeIndex:index];
    }
}

- (void)makeSlidBar
{
    NSArray *images = @[
                        [UIImage imageNamed:@"gear"],
                        [UIImage imageNamed:@"globe"],
                        [UIImage imageNamed:@"profile"],
                        [UIImage imageNamed:@"star"],
                        ];
    NSArray *colors = @[
                        [UIColor colorWithRed:240/255.f green:159/255.f blue:254/255.f alpha:1],
                        [UIColor colorWithRed:255/255.f green:137/255.f blue:167/255.f alpha:1],
                        [UIColor colorWithRed:126/255.f green:242/255.f blue:195/255.f alpha:1],
                        [UIColor colorWithRed:119/255.f green:152/255.f blue:255/255.f alpha:1]
                        ];
    
    _callout = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:self.optionIndices borderColors:colors];
    _callout.delegate = self;
}
@end
