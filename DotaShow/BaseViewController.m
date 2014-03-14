//
//  BaseViewController.m
//  DotaShow
//
//  Created by Jianqiang Meng on 3/14/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "BaseViewController.h"
#import <FBShimmeringView.h>

@interface BaseViewController ()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation BaseViewController

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
    UIImage *backgroudImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"SectionCover" ofType:@"png"]];
    self.view.layer.contents = (id) backgroudImage.CGImage;
    FBShimmeringView *shimmeringView = [[FBShimmeringView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel = [[UILabel alloc] initWithFrame:shimmeringView.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = NSLocalizedString(@"DotaShow", nil);
    shimmeringView.contentView = _titleLabel;
    shimmeringView.shimmering = YES;
    self.navigationItem.titleView = shimmeringView;
    
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
