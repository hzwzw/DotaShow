//
//  ShowGirlViewController.m
//  DotaShow
//
//  Created by Jianqiang Meng on 3/14/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "ShowGirlViewController.h"
#import <RNGridMenu.h>

@interface ShowGirlViewController ()

@end

@implementation ShowGirlViewController

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
    RNGridMenuItem *item1 = [[RNGridMenuItem alloc]initWithImage:[UIImage imageNamed:@"0.jpg"] title:@"lot"];
    RNGridMenuItem *item2 = [[RNGridMenuItem alloc]initWithImage:[UIImage imageNamed:@"1.jpg"] title:@"lotsss"];
    RNGridMenu *av = [[RNGridMenu alloc]initWithItems:[NSArray arrayWithObjects:item1,item2,nil]];
    [av showInViewController:self center:self.view.center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
