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
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

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
			return [UIImage imageNamed:@"facebook500"];
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
			return [UIImage imageNamed:@"vimeo"];
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
            // If the session state is any of the two "open" states when the button is clicked
            if (FBSession.activeSession.state == FBSessionStateOpen
                || FBSession.activeSession.state == FBSessionStateOpenTokenExtended) {
                
                // Close the session and remove the access token from the cache
                // The session state handler (in the app delegate) will be called automatically
                [FBSession.activeSession closeAndClearTokenInformation];
                
                // If the session state is not any of the two "open" states when the button is clicked
            } else {
                // Open a session showing the user the login UI
                // You must ALWAYS ask for basic_info permissions when opening a session
//                FBSession *session = [[FBSession alloc] init];
//                // Set the active session
//                [FBSession setActiveSession:session];
//                // Open the session
//                [session openWithBehavior:FBSessionLoginBehaviorWithNoFallbackToWebView
//                        completionHandler:^(FBSession *session,
//                                            FBSessionState status,
//                                            NSError *error) {
//                            // Respond to session state changes, 
//                            // ex: updating the view
//                        }];
                
                [FBSession openActiveSessionWithReadPermissions:@[@"basic_info"]
                                                   allowLoginUI:YES
                                              completionHandler:
                 ^(FBSession *session, FBSessionState state, NSError *error) {
                     
                     // Retrieve the app delegate
                     AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
                     // Call the app delegate's sessionStateChanged:state:error method to handle session state changes
                     [appDelegate sessionStateChanged:session state:state error:error];
                 }];
            }
		}
	}
}

- (void)addSlideBarMenu
{
    _sideMenu = [[HMSideMenu alloc] initWithItems:@[[self makeItem:@"dribbble"],[self makeItem:@"youtube"],[self makeItem:@"facebook500"],[self makeItem:@"pinterest"],[self makeItem:@"twitter"],[self makeItem:@"instagram500"],[self makeItem:@"vimeo"]]];
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
