//
//  ViewController.m
//  LeafSlideMenu
//
//  Created by Wang on 14-7-3.
//  Copyright (c) 2014年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "LeafMenuViewController.h"
#import "LeftViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated{
    LeftViewController *left = [[LeftViewController alloc] initWithNibName:@"LeftViewController" bundle:nil];
    OneViewController *one = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:nil];
    TwoViewController *two = [[TwoViewController alloc] initWithNibName:@"TwoViewController" bundle:nil];
    LeafMenuViewController *menu = [[LeafMenuViewController alloc] initWithLeftVC:left centerVCs:@[[[UINavigationController alloc] initWithRootViewController:one],[[UINavigationController alloc] initWithRootViewController:two]]];
    menu.springAnimation = YES;
    menu.shadow = YES;
    
    [self presentViewController:menu animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
