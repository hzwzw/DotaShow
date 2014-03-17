//
//  ShowGirlViewController.m
//  DotaShow
//
//  Created by Jianqiang Meng on 3/14/14.
//  Copyright (c) 2014 Jianqiang Meng. All rights reserved.
//

#import "ShowGirlViewController.h"
#import <RNGridMenu.h>
#import <iCarousel.h>

@interface ShowGirlViewController ()

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation ShowGirlViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setUp];
    }
    return self;
}

- (void)setUp
{
	//set up data
	self.items = [NSMutableArray array];
	for (int i = 0; i < 30; i++)
	{
		[_items addObject:@(i)];
	}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _carousel.type = iCarouselTypeCoverFlow2;
//    RNGridMenuItem *item1 = [[RNGridMenuItem alloc]initWithImage:[UIImage imageNamed:@"0.jpg"] title:@"lot"];
//    RNGridMenuItem *item2 = [[RNGridMenuItem alloc]initWithImage:[UIImage imageNamed:@"1.jpg"] title:@"lotsss"];
//    RNGridMenu *av = [[RNGridMenu alloc]initWithItems:[NSArray arrayWithObjects:item1,item2,nil]];
//    [av showInViewController:self center:self.view.center];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_items count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_items[index] stringValue];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
        case iCarouselOptionFadeMax:
        {
            if (carousel.type == iCarouselTypeCustom)
            {
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionArc:
        {
            return 2 * M_PI * 0.2;
        }
        case iCarouselOptionRadius:
        {
            return value * 0.5;
        }
        case iCarouselOptionTilt:
        {
            return 0.5;
        }
        case iCarouselOptionSpacing:
        {
            return value * 0.8;
        }
        default:
        {
            return value;
        }
    }
}

@end
