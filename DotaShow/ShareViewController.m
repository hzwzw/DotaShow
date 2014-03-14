//
//  ShareViewController.m
//  DotaShow
//
//  Created by Jianqiang Meng on 3/14/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "ShareViewController.h"
#import <ALRadialMenu.h>
#import <HMSideMenu.h>
@interface ShareViewController ()<ALRadialMenuDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIButton *socialButton;

@property (strong, nonatomic) ALRadialMenu *radialMenu;
@property (strong, nonatomic) ALRadialMenu *socialMenu;
@property (nonatomic, strong) HMSideMenu *sideMenu;
@property (strong, nonatomic) NSArray *popups;

@end

@implementation ShareViewController

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
    self.radialMenu = [[ALRadialMenu alloc] init];
	self.radialMenu.delegate = self;
	
	self.socialMenu = [[ALRadialMenu alloc] init];
	self.socialMenu.delegate = self;
    [self setTitle:@"Share"];
    [self addSlideBarMenu];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonPressed:(id)sender {
	//the button that brings the items into view was pressed
    [self.radialMenu buttonsWillAnimateFromButton:sender withFrame:self.button.frame inView:self.view];
}

- (IBAction)socialButtonPressed:(id)sender
{
    [self.socialMenu buttonsWillAnimateFromButton:sender withFrame:self.socialButton.frame inView:self.view];
}

- (IBAction)hmButton:(id)sender {
    if (_sideMenu.isOpen) {
        [_sideMenu close];
    }else
        [_sideMenu open];
}


#pragma mark - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	//FIXME: dipshit, change one of these variable names
	if (radialMenu == self.radialMenu) {
		return 9;
	} else if (radialMenu == self.socialMenu) {
		return 3;
	}
	
	return 0;
}


- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.radialMenu) {
		return 360;
	} else if (radialMenu == self.socialMenu) {
		return 90;
	}
	
	return 0;
}


- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	if (radialMenu == self.radialMenu) {
		return 80;
	} else if (radialMenu == self.socialMenu) {
		return 80;
	}
	
	return 0;
}


- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
	if (radialMenu == self.radialMenu) {
		if (index == 1) {
			return [UIImage imageNamed:@"dribbble"];
		} else if (index == 2) {
			return [UIImage imageNamed:@"youtube"];
		} else if (index == 3) {
			return [UIImage imageNamed:@"vimeo"];
		} else if (index == 4) {
			return [UIImage imageNamed:@"pinterest"];
		} else if (index == 5) {
			return [UIImage imageNamed:@"twitter"];
		} else if (index == 6) {
			return [UIImage imageNamed:@"instagram500"];
		} else if (index == 7) {
			return [UIImage imageNamed:@"email"];
		} else if (index == 8) {
			return [UIImage imageNamed:@"googleplus-revised"];
		} else if (index == 9) {
			return [UIImage imageNamed:@"facebook500"];
		}
        
	} else if (radialMenu == self.socialMenu) {
		if (index == 1) {
			return [UIImage imageNamed:@"email"];
		} else if (index == 2) {
			return [UIImage imageNamed:@"googleplus-revised"];
		} else if (index == 3) {
			return [UIImage imageNamed:@"facebook500"];
		}
	}
	
	return nil;
}


- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
	if (radialMenu == self.radialMenu) {
		[self.radialMenu itemsWillDisapearIntoButton:self.button];
	} else if (radialMenu == self.socialMenu) {
		[self.socialMenu itemsWillDisapearIntoButton:self.socialButton];
		if (index == 1) {
			NSLog(@"email");
		} else if (index == 2) {
			NSLog(@"google+");
		} else if (index == 3) {
			NSLog(@"facebook");
		}
	}
}

- (void)addSlideBarMenu
{
    _sideMenu = [[HMSideMenu alloc] initWithItems:@[[self makeItem:@"dribbble"],[self makeItem:@"youtube"],[self makeItem:@"vimeo"],[self makeItem:@"pinterest"],[self makeItem:@"twitter"],[self makeItem:@"instagram500"],[self makeItem:@"facebook500"]]];
    //[_sideMenu setItemSpacing:.0];
    [_sideMenu setAnimationDuration:1.0];
    [self.view addSubview:_sideMenu];
}

- (HMSideMenuItem *)makeItem:(NSString *)name
{
    HMSideMenuItem *item1 = [[HMSideMenuItem alloc]initWithSize:CGSizeMake(35,35) action:^{
        NSLog(@"yesss");
    }];
    UIImageView *twitterIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [twitterIcon setImage:[UIImage imageNamed:name]];
    [item1 addSubview:twitterIcon];
    return item1;
}
@end
